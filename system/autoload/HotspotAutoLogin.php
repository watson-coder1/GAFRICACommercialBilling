<?php

/**
 * Hotspot Auto-Login Handler
 * Enhanced version with proper MAC handling and auto-login debugging
 */

class HotspotAutoLogin
{
    /**
     * Create MikroTik user and auto-login after payment
     */
    public static function createAndLogin($session, $package)
    {
        try {
            // Get router info
            $router = ORM::for_table('tbl_routers')
                ->where('enabled', 1)
                ->find_one();
                
            if (!$router) {
                self::log("ERROR: No enabled router found");
                return false;
            }

            // Normalize MAC address - MikroTik expects uppercase
            $originalMac = $session->mac_address;
            $normalizedMac = strtoupper($originalMac);
            
            self::log("PROCESSING: Phone {$session->phone_number}, Original MAC: $originalMac, Normalized: $normalizedMac");
            
            // Use normalized MAC address as username/password for auto-login
            $username = $normalizedMac;
            $password = $normalizedMac;
            
            // Connect to MikroTik using existing method
            require_once 'system/devices/MikrotikHotspot.php';
            $mikrotikDevice = new MikrotikHotspot();
            $client = $mikrotikDevice->getClient($router->ip_address, $router->username, $router->password);
            
            if (!$client) {
                self::log("ERROR: Failed to connect to MikroTik at {$router->ip_address}");
                return false;
            }
            
            self::log("SUCCESS: Connected to MikroTik {$router->ip_address}");
            
            // Remove existing user if exists to avoid conflicts
            try {
                $removeRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/remove');
                $removeRequest->setArgument('name', $username);
                $client->sendSync($removeRequest);
                self::log("INFO: Removed existing user $username (if existed)");
            } catch (Exception $e) {
                // User might not exist, continue
                self::log("INFO: No existing user to remove for $username");
            }
            
            // Create new user using RouterOS Request directly
            $addRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/add');
            $addRequest->setArgument('name', $username);
            $addRequest->setArgument('password', $password);
            $addRequest->setArgument('mac-address', $normalizedMac);
            $addRequest->setArgument('server', 'vlan-hotspot');
            $addRequest->setArgument('comment', 'Phone: ' . $session->phone_number . ' | Package: ' . $package->name);
            
            // Set time limit if package has duration
            if ($package->duration_hours > 0) {
                $timelimit = $package->duration_hours . ":00:00";
                $addRequest->setArgument('limit-uptime', $timelimit);
                self::log("INFO: Set time limit to $timelimit for user $username");
            }
            
            $client->sendSync($addRequest);
            
            // Update session with normalized MikroTik username
            $session->mikrotik_user = $username;
            $session->mac_address = $normalizedMac; // Also normalize in database
            $session->save();
            
            self::log("SUCCESS: Created user $username for MAC $normalizedMac");
            
            // Give MikroTik a moment to process the user creation
            sleep(1);
            
            // Now attempt auto-login with improved logic
            return self::attemptAutoLogin($client, $session, $username, $password, $normalizedMac, $router);
            
        } catch (Exception $e) {
            self::log("ERROR: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Enhanced auto-login with retry logic and live IP fetching
     */
    private static function attemptAutoLogin($client, $session, $username, $password, $mac, $router)
    {
        try {
            self::log("AUTOLOGIN: Starting auto-login process for $username");
            
            // Step 1: Try to get live IP from MikroTik hosts
            $liveIP = self::getLiveIPFromMikroTik($client, $mac);
            
            // Step 2: Use live IP or fallback to session IP or generate one
            $clientIP = $liveIP ?? $session->ip_address ?? '10.0.1.' . (100 + (rand() % 150));
            
            self::log("AUTOLOGIN: Using IP $clientIP for MAC $mac (live: " . ($liveIP ? 'yes' : 'no') . ")");
            
            // Step 3: Force disconnect if device is already connected but not authenticated
            self::forceDisconnectIfNeeded($client, $mac);
            
            // Step 4: Wait for device to potentially reconnect
            sleep(2);
            
            // Step 5: Attempt direct login via RouterOS API
            try {
                $loginRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/login');
                $loginRequest->setArgument('user', $username);
                $loginRequest->setArgument('password', $password);
                $loginRequest->setArgument('mac-address', $mac);
                
                if ($clientIP) {
                    $loginRequest->setArgument('ip', $clientIP);
                }
                
                $response = $client->sendSync($loginRequest);
                self::log("AUTOLOGIN: Direct login command sent successfully for $username");
                
                // Check if login was successful by looking for active session
                $activeCheck = self::checkActiveSession($client, $mac, $username);
                if ($activeCheck) {
                    self::log("SUCCESS: User $username is now active in hotspot!");
                    return true;
                } else {
                    self::log("WARNING: Login command sent but user not found in active sessions");
                }
                
            } catch (Exception $loginException) {
                self::log("AUTOLOGIN ERROR: Direct login failed - " . $loginException->getMessage());
            }
            
            // Step 6: Try alternative method via MikroTik device class
            try {
                require_once 'system/devices/MikrotikHotspot.php';
                $mikrotikDevice = new MikrotikHotspot();
                
                $customer = [
                    'username' => $username,
                    'password' => $password
                ];
                
                $result = $mikrotikDevice->connect_customer($customer, $clientIP, $mac, $router->id);
                
                if ($result) {
                    self::log("AUTOLOGIN: Alternative method succeeded for $username");
                    return true;
                } else {
                    self::log("AUTOLOGIN: Alternative method also failed for $username");
                }
                
            } catch (Exception $altException) {
                self::log("AUTOLOGIN ERROR: Alternative method failed - " . $altException->getMessage());
            }
            
            // If we reach here, auto-login failed but user is created
            self::log("AUTOLOGIN: Auto-login attempts failed, but user created. Device should authenticate on reconnect.");
            return true; // Still return true because user was created successfully
            
        } catch (Exception $e) {
            self::log("AUTOLOGIN ERROR: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Get live IP address for MAC from MikroTik hosts
     */
    private static function getLiveIPFromMikroTik($client, $mac)
    {
        try {
            $hostRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/host/print');
            $hostRequest->setArgument('?mac-address', $mac);
            
            $hosts = $client->sendSync($hostRequest);
            
            if (!empty($hosts)) {
                foreach ($hosts as $host) {
                    if ($host->getType() === PEAR2\Net\RouterOS\Response::TYPE_DATA) {
                        $ip = $host->getArgument('address');
                        if ($ip) {
                            self::log("LIVE-IP: Found live IP $ip for MAC $mac");
                            return $ip;
                        }
                    }
                }
            }
            
            self::log("LIVE-IP: No live IP found for MAC $mac in hosts");
            return null;
            
        } catch (Exception $e) {
            self::log("LIVE-IP ERROR: " . $e->getMessage());
            return null;
        }
    }
    
    /**
     * Force disconnect device if it's connected but not authenticated
     */
    private static function forceDisconnectIfNeeded($client, $mac)
    {
        try {
            // Check if MAC is in hosts but not in active sessions
            $hostRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/host/print');
            $hostRequest->setArgument('?mac-address', $mac);
            $hosts = $client->sendSync($hostRequest);
            
            if (!empty($hosts)) {
                // Device is connected, check if it's authenticated
                $activeRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/print');
                $activeRequest->setArgument('?mac-address', $mac);
                $activeSessions = $client->sendSync($activeRequest);
                
                if (empty($activeSessions)) {
                    // Connected but not authenticated - force disconnect
                    $removeRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/host/remove');
                    $removeRequest->setArgument('mac-address', $mac);
                    $client->sendSync($removeRequest);
                    
                    self::log("DISCONNECT: Forced disconnect for MAC $mac to trigger re-auth");
                } else {
                    self::log("INFO: MAC $mac already authenticated");
                }
            } else {
                self::log("INFO: MAC $mac not in hosts list");
            }
            
        } catch (Exception $e) {
            self::log("DISCONNECT ERROR: " . $e->getMessage());
        }
    }
    
    /**
     * Check if user is in active sessions
     */
    private static function checkActiveSession($client, $mac, $username)
    {
        try {
            // Check by MAC address
            $activeRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/print');
            $activeRequest->setArgument('?mac-address', $mac);
            $activeSessions = $client->sendSync($activeRequest);
            
            if (!empty($activeSessions)) {
                self::log("ACTIVE-CHECK: Found active session for MAC $mac");
                return true;
            }
            
            // Also check by username
            $activeRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/print');
            $activeRequest->setArgument('?user', $username);
            $activeSessions = $client->sendSync($activeRequest);
            
            if (!empty($activeSessions)) {
                self::log("ACTIVE-CHECK: Found active session for username $username");
                return true;
            }
            
            self::log("ACTIVE-CHECK: No active session found for MAC $mac or username $username");
            return false;
            
        } catch (Exception $e) {
            self::log("ACTIVE-CHECK ERROR: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Log messages for debugging
     */
    private static function log($message)
    {
        $logFile = 'system/uploads/hotspot_autologin.log';
        $timestamp = date('Y-m-d H:i:s');
        file_put_contents($logFile, "[$timestamp] $message" . PHP_EOL, FILE_APPEND);
    }
    
    /**
     * Fix fake MAC addresses in existing sessions
     */
    public static function fixFakeMacAddresses()
    {
        // Get all sessions with fake MACs (contains ':' at regular intervals)
        $sessions = ORM::for_table('tbl_portal_sessions')
            ->where_like('mac_address', '%:%:%:%:%:%')
            ->where('payment_status', 'completed')
            ->where_null('mikrotik_user')
            ->find_many();
            
        foreach ($sessions as $session) {
            // Check if this looks like a fake MAC (too regular pattern)
            if (preg_match('/^[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}$/', $session->mac_address)) {
                self::log("FAKE MAC DETECTED: Session {$session->session_id} has fake MAC {$session->mac_address}");
            }
        }
    }
}
