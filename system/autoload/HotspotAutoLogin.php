<?php

/**
 * Hotspot Auto-Login Handler
 * Fixes automatic login after payment
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

            // Use MAC address as username/password for auto-login
            $username = $session->mac_address;
            $password = $session->mac_address;
            
            // Connect to MikroTik using existing method
            require_once 'system/devices/MikrotikHotspot.php';
            $mikrotikDevice = new MikrotikHotspot();
            $client = $mikrotikDevice->getClient($router->ip_address, $router->username, $router->password);
            
            // Skip user removal - will overwrite if exists
            
            // Create new user using RouterOS Request directly
            $addRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/add');
            $addRequest->setArgument('name', $username);
            $addRequest->setArgument('password', $password);
            $addRequest->setArgument('mac-address', $session->mac_address);
            $addRequest->setArgument('server', 'vlan-hotspot');
            $addRequest->setArgument('comment', 'Phone: ' . $session->phone_number . ' | Package: ' . $package->name);
            
            // Set time limit if package has duration
            if ($package->duration_hours > 0) {
                $timelimit = $package->duration_hours . ":00:00";
                $addRequest->setArgument('limit-uptime', $timelimit);
            }
            
            $client->sendSync($addRequest);
            
            // Update session with MikroTik username
            $session->mikrotik_user = $username;
            $session->save();
            
            self::log("SUCCESS: Created user $username for MAC $session->mac_address");
            
            // Now actually log the user in to the hotspot
            try {
                // Get client IP - try from session first, then generate one
                $clientIP = $session->ip_address ?? '192.168.1.' . (100 + (rand() % 150));
                
                // Use MikroTik connect_customer method to actually log them in
                $customer = [
                    'username' => $username,
                    'password' => $password
                ];
                
                // Call the actual login function
                $mikrotikDevice->connect_customer($customer, $clientIP, $session->mac_address, $router->id);
                
                self::log("AUTO-LOGIN SUCCESS: User $username logged in with IP $clientIP");
                
                // Also try alternative login method
                $loginRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/login');
                $loginRequest->setArgument('user', $username);
                $loginRequest->setArgument('password', $password);
                $loginRequest->setArgument('ip', $clientIP);
                $loginRequest->setArgument('mac-address', $session->mac_address);
                
                $client->sendSync($loginRequest);
                
                self::log("AUTO-LOGIN: Direct login command sent for user $username");
                
            } catch (Exception $loginException) {
                self::log("AUTO-LOGIN ERROR: " . $loginException->getMessage());
                // Don't fail the whole process if login fails, user can still manually login
            }
            
            return true;
            
        } catch (Exception $e) {
            self::log("ERROR: " . $e->getMessage());
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