<?php

/**
 * Captive Portal Controller
 * Handles hotspot package selection and payment processing
 */

if (!defined('PEAR2_NET_ROUTEROS')) {
    define('PEAR2_NET_ROUTEROS', 'pear2/net_routeros');
}

// Debug logging for all portal requests
$debugInfo = "=== Portal Request " . date('Y-m-d H:i:s') . " ===\n";
$debugInfo .= "Route: " . ($routes['1'] ?? 'default') . "\n";
$debugInfo .= "Method: " . $_SERVER['REQUEST_METHOD'] . "\n";
$debugInfo .= "GET: " . json_encode($_GET) . "\n";
$debugInfo .= "POST: " . json_encode($_POST) . "\n";
file_put_contents('system/uploads/portal_debug.log', $debugInfo . "\n", FILE_APPEND);

switch ($routes['1']) {
    case 'login':
        $mac = $_GET['mac'] ?? '';
        $ip = $_GET['ip'] ?? '';
        $sessionId = uniqid('portal_', true);
        
        // If no IP provided, detect real IP
        if (empty($ip)) {
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? $_SERVER['HTTP_X_REAL_IP'] ?? $_SERVER['REMOTE_ADDR'] ?? 'Unknown';
            // Clean up IP if it contains multiple IPs (from proxy)
            if (strpos($ip, ',') !== false) {
                $ip = trim(explode(',', $ip)[0]);
            }
        }
        
        // If no MAC provided, try to get device info from User Agent
        if (empty($mac)) {
            $userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';
            // Create a pseudo-MAC from device fingerprint
            if (!empty($userAgent)) {
                $deviceHash = substr(md5($userAgent . $ip), 0, 12);
                $mac = implode(':', str_split($deviceHash, 2));
            } else {
                $mac = 'device-' . substr(md5($ip . time()), 0, 12);
            }
        }
        
        // Check if MAC already has active session
        $activeSession = ORM::for_table('tbl_portal_sessions')
            ->where('mac_address', $mac)
            ->where('payment_status', 'completed')
            ->where_gt('expires_at', date('Y-m-d H:i:s'))
            ->find_one();
            
        if ($activeSession) {
            // User already has active session
            r2(U . 'portal/status/' . $activeSession->session_id);
        }
        
        // Create new session
        $session = ORM::for_table('tbl_portal_sessions')->create();
        $session->session_id = $sessionId;
        $session->mac_address = $mac;
        $session->ip_address = $ip;
        $session->save();
        
        // Get available packages
        $packages = ORM::for_table('tbl_hotspot_packages')
            ->where('status', 'active')
            ->order_by_asc('price')
            ->find_many();
            
        $ui->assign('packages', $packages);
        $ui->assign('session_id', $sessionId);
        $ui->assign('mac', $mac);
        $ui->assign('ip', $ip);
        $ui->assign('app_url', APP_URL);
        $ui->display('portal-login-enhanced.tpl');
        break;
        
    case 'select':
        // Debug logging
        $debugLog = "=== Portal Select Debug " . date('Y-m-d H:i:s') . " ===\n";
        $debugLog .= "POST Data: " . json_encode($_POST) . "\n";
        
        $sessionId = $_POST['session_id'] ?? '';
        $packageId = $_POST['package_id'] ?? '';
        $phoneNumber = $_POST['phone_number'] ?? '';
        
        $debugLog .= "Session ID: $sessionId\n";
        $debugLog .= "Package ID: $packageId\n";
        $debugLog .= "Phone Number: $phoneNumber\n";
        
        file_put_contents('system/uploads/portal_debug.log', $debugLog . "\n", FILE_APPEND);
        
        if (!$sessionId || !$packageId || !$phoneNumber) {
            file_put_contents('system/uploads/portal_debug.log', "ERROR: Missing required information\n\n", FILE_APPEND);
            r2(U . 'portal/login', 'e', 'Missing required information');
        }
        
        // Validate phone number format (Kenyan format)
        if (!preg_match('/^(254|0)[17]\d{8}$/', $phoneNumber)) {
            file_put_contents('system/uploads/portal_debug.log', "ERROR: Invalid phone number format\n\n", FILE_APPEND);
            r2(U . 'portal/login', 'e', 'Invalid phone number format');
        }
        
        // Format phone number to 254 format
        $phoneNumber = preg_replace('/^0/', '254', $phoneNumber);
        
        // Update session with package and phone
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'portal/login', 'e', 'Invalid session');
        }
        
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $packageId)
            ->find_one();
            
        if (!$package) {
            r2(U . 'portal/login', 'e', 'Invalid package');
        }
        
        $session->package_id = $packageId;
        $session->phone_number = $phoneNumber;
        $session->save();
        
        // Initiate M-Pesa STK Push
        try {
            file_put_contents('system/uploads/portal_debug.log', "Initiating Mpesa STK Push...\n", FILE_APPEND);
            
            $mpesa = new MpesaIntegration();
            
            // Check if Mpesa is configured
            if (!$mpesa->isConfigured()) {
                file_put_contents('system/uploads/portal_debug.log', "ERROR: Mpesa not configured\n\n", FILE_APPEND);
                r2(U . 'portal/login', 'e', 'Payment system not configured. Please contact administrator.');
            }
            
            $stkResult = $mpesa->initiateSTKPush(
                $phoneNumber, 
                $package->price, 
                $sessionId,
                'Glinta WiFi - ' . $package->name
            );
            
            file_put_contents('system/uploads/portal_debug.log', "STK Result: " . json_encode($stkResult) . "\n\n", FILE_APPEND);
            
            if ($stkResult['success']) {
                // Create M-Pesa transaction record immediately
                $transaction = ORM::for_table('tbl_mpesa_transactions')->create();
                $transaction->transaction_id = $stkResult['checkout_request_id'];
                $transaction->phone_number = $phoneNumber;
                $transaction->amount = $package->price;
                $transaction->session_id = $sessionId;
                $transaction->status = 'pending';
                $transaction->save();
                
                file_put_contents('system/uploads/portal_debug.log', "Transaction created: " . $stkResult['checkout_request_id'] . "\n", FILE_APPEND);
                
                // STK push sent successfully
                r2(U . 'portal/payment/' . $sessionId, 's', 'Payment request sent to your phone. Please check and enter your M-Pesa PIN.');
            } else {
                // STK push failed
                r2(U . 'portal/login', 'e', 'Failed to initiate payment: ' . $stkResult['message']);
            }
        } catch (Exception $e) {
            file_put_contents('system/uploads/portal_debug.log', "EXCEPTION: " . $e->getMessage() . "\n\n", FILE_APPEND);
            r2(U . 'portal/login', 'e', 'Payment system error: ' . $e->getMessage());
        }
        break;
        
    case 'payment':
        $sessionId = $routes['2'] ?? '';
        
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'portal/login', 'e', 'Invalid session');
        }
        
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $session->package_id)
            ->find_one();
            
        // Create M-Pesa transaction record
        $transaction = ORM::for_table('tbl_mpesa_transactions')->create();
        $transaction->transaction_id = uniqid('txn_', true);
        $transaction->phone_number = $session->phone_number;
        $transaction->amount = $package->price;
        $transaction->session_id = $sessionId;
        $transaction->status = 'pending';
        $transaction->save();
        
        $ui->assign('session', $session);
        $ui->assign('package', $package);
        $ui->assign('transaction', $transaction);
        $ui->display('portal-payment.tpl');
        break;
        
    case 'status':
        $sessionId = $routes['2'] ?? '';
        
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'portal/login', 'e', 'Invalid session');
        }
        
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $session->package_id)
            ->find_one();
            
        $transaction = ORM::for_table('tbl_mpesa_transactions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        $ui->assign('session', $session);
        $ui->assign('package', $package);
        $ui->assign('transaction', $transaction);
        $ui->display('portal-status.tpl');
        break;
        
    case 'callback':
        // M-Pesa callback handler
        header('Content-Type: application/json');
        
        // Get raw POST data
        $input = file_get_contents('php://input');
        
        // Log callback for debugging
        file_put_contents('system/uploads/mpesa_callbacks.log', 
            date('Y-m-d H:i:s') . ' - ' . $input . PHP_EOL, FILE_APPEND);
        
        // Process callback using MpesaIntegration class
        try {
            $mpesa = new MpesaIntegration();
            $data = json_decode($input, true);
            
            if ($data) {
                $result = $mpesa->processCallback($data);
                if ($result) {
                    // Payment successful - create MikroTik user
                    createHotspotUserFromCallback($data);
                    
                    echo json_encode([
                        'ResultCode' => 0,
                        'ResultDesc' => 'Success'
                    ]);
                } else {
                    echo json_encode([
                        'ResultCode' => 1,
                        'ResultDesc' => 'Failed to process callback'
                    ]);
                }
            } else {
                echo json_encode([
                    'ResultCode' => 1,
                    'ResultDesc' => 'Invalid JSON data'
                ]);
            }
        } catch (Exception $e) {
            // Log error but still respond to Safaricom
            file_put_contents('system/uploads/mpesa_callbacks.log', 
                date('Y-m-d H:i:s') . ' - ERROR: ' . $e->getMessage() . PHP_EOL, FILE_APPEND);
            
            echo json_encode([
                'ResultCode' => 0,
                'ResultDesc' => 'Acknowledged'
            ]);
        }
        break;
        
    case 'admin':
        // Admin panel for portal management
        if (!$admin) {
            r2(U . 'login', 'e', 'Access denied');
        }
        
        $sessions = ORM::for_table('tbl_portal_sessions')
            ->select_many('tbl_portal_sessions.*', 'tbl_hotspot_packages.name', 'tbl_hotspot_packages.price')
            ->join('tbl_hotspot_packages', array('tbl_portal_sessions.package_id', '=', 'tbl_hotspot_packages.id'))
            ->order_by_desc('tbl_portal_sessions.created_at')
            ->limit(50)
            ->find_many();
            
        $packages = ORM::for_table('tbl_hotspot_packages')
            ->order_by_asc('price')
            ->find_many();
            
        $ui->assign('sessions', $sessions);
        $ui->assign('packages', $packages);
        $ui->assign('_title', 'Portal Management');
        $ui->display('admin/portal-admin.tpl');
        break;
        
    case 'voucher':
        // Voucher/M-Pesa code authentication handler
        $sessionId = $_POST['session_id'] ?? '';
        $voucherCode = strtoupper(trim($_POST['voucher_code'] ?? ''));
        $mpesaCode = strtoupper(trim($_POST['mpesa_code'] ?? ''));
        
        if (!$sessionId) {
            r2(U . 'portal/login', 'e', 'Invalid session');
        }
        
        if (!$voucherCode && !$mpesaCode) {
            r2(U . 'portal/login', 'e', 'Please enter either a voucher code or M-Pesa receipt code');
        }
        
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $sessionId)
            ->find_one();
            
        if (!$session) {
            r2(U . 'portal/login', 'e', 'Invalid session');
        }
        
        $authenticated = false;
        $authenticationType = '';
        
        // Try M-Pesa receipt code first
        if ($mpesaCode) {
            $mpesaTransaction = ORM::for_table('tbl_mpesa_transactions')
                ->where('mpesa_receipt_number', $mpesaCode)
                ->where('status', 'completed')
                ->find_one();
                
            if ($mpesaTransaction) {
                // Find the session associated with this transaction
                $paidSession = ORM::for_table('tbl_portal_sessions')
                    ->where('session_id', $mpesaTransaction->session_id)
                    ->find_one();
                    
                if ($paidSession && $paidSession->payment_status == 'completed') {
                    // Update current session with the paid session details
                    $session->package_id = $paidSession->package_id;
                    $session->phone_number = $paidSession->phone_number;
                    $session->payment_status = 'completed';
                    $session->expires_at = $paidSession->expires_at;
                    $session->mikrotik_user = $paidSession->mikrotik_user;
                    $session->save();
                    
                    $authenticated = true;
                    $authenticationType = 'M-Pesa Receipt';
                    
                    file_put_contents('system/uploads/portal_debug.log', 
                        date('Y-m-d H:i:s') . " - M-Pesa code authentication: $mpesaCode for session: $sessionId\n", FILE_APPEND);
                }
            }
        }
        
        // Try voucher code if M-Pesa didn't work
        if (!$authenticated && $voucherCode) {
            // Check if voucher exists and is valid
            $voucher = ORM::for_table('tbl_voucher')
                ->where('voucher_code', $voucherCode)
                ->where('status', 'active')
                ->find_one();
                
            if ($voucher) {
                // Get voucher plan details
                $plan = ORM::for_table('tbl_plans')
                    ->where('id', $voucher->plan_id)
                    ->find_one();
                    
                if ($plan) {
                    // Create hotspot package equivalent
                    $package = ORM::for_table('tbl_hotspot_packages')
                        ->where('name', $plan->name_plan)
                        ->find_one();
                        
                    if (!$package) {
                        // Create package from plan
                        $package = ORM::for_table('tbl_hotspot_packages')->create();
                        $package->name = $plan->name_plan;
                        $package->price = $plan->price;
                        $package->duration_hours = $plan->time_limit;
                        $package->status = 'active';
                        $package->created_at = date('Y-m-d H:i:s');
                        $package->save();
                    }
                    
                    // Update session
                    $session->package_id = $package->id;
                    $session->payment_status = 'completed';
                    $session->expires_at = date('Y-m-d H:i:s', strtotime('+' . $plan->time_limit . ' hours'));
                    
                    // Create MikroTik user
                    try {
                        $username = 'hs_' . substr(str_replace(':', '', $session->mac_address), -6) . '_' . time();
                        $password = substr(md5($username . time()), 0, 8);
                        
                        $router = ORM::for_table('tbl_routers')
                            ->where('enabled', 1)
                            ->find_one();
                            
                        if ($router) {
                            require_once 'system/devices/MikrotikHotspot.php';
                            $device = new MikrotikHotspot();
                            $client = $device->getClient($router->ip_address, $router->username, $router->password);
                            
                            if ($client) {
                                $addRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/add');
                                $client->sendSync(
                                    $addRequest
                                        ->setArgument('name', $username)
                                        ->setArgument('profile', $plan->name_plan)
                                        ->setArgument('password', $password)
                                        ->setArgument('comment', "Voucher: $voucherCode")
                                        ->setArgument('limit-uptime', $plan->time_limit . ":00:00")
                                );
                                
                                $session->mikrotik_user = $username;
                            }
                        }
                    } catch (Exception $e) {
                        file_put_contents('system/uploads/portal_debug.log', 
                            date('Y-m-d H:i:s') . " - Voucher MikroTik user creation error: " . $e->getMessage() . "\n", FILE_APPEND);
                    }
                    
                    $session->save();
                    
                    // Mark voucher as used
                    $voucher->status = 'used';
                    $voucher->save();
                    
                    $authenticated = true;
                    $authenticationType = 'Voucher Code';
                    
                    file_put_contents('system/uploads/portal_debug.log', 
                        date('Y-m-d H:i:s') . " - Voucher authentication: $voucherCode for session: $sessionId\n", FILE_APPEND);
                }
            }
        }
        
        if ($authenticated) {
            r2(U . 'portal/status/' . $sessionId, 's', "Authentication successful using $authenticationType! You now have internet access.");
        } else {
            if ($mpesaCode) {
                r2(U . 'portal/login', 'e', 'M-Pesa receipt code not found or already used. Please contact support.');
            } else {
                r2(U . 'portal/login', 'e', 'Invalid or expired voucher code. Please check and try again.');
            }
        }
        break;
        
    default:
        r2(U . 'portal/login');
        break;
}

/**
 * Create MikroTik hotspot user after successful payment
 */
function createHotspotUserFromCallback($callbackData) {
    try {
        // Extract transaction details from M-Pesa callback
        $transactionId = $callbackData['Body']['stkCallback']['CheckoutRequestID'] ?? '';
        
        // Find the session and package
        $transaction = ORM::for_table('tbl_mpesa_transactions')
            ->where('transaction_id', $transactionId)
            ->find_one();
            
        if (!$transaction) {
            return false;
        }
        
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $transaction->session_id)
            ->find_one();
            
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $session->package_id)
            ->find_one();
            
        // Create unique username
        $username = 'hs_' . substr($session->mac_address, -6) . '_' . time();
        $password = substr(md5($username . time()), 0, 8);
        
        // Get router information
        $router = ORM::for_table('tbl_routers')
            ->where('enabled', 1)
            ->find_one();
            
        if (!$router) {
            return false;
        }
        
        // Create MikroTik user using existing device handler
        $device = new MikrotikHotspot();
        $client = $device->getClient($router->ip_address, $router->username, $router->password);
        
        if ($client) {
            // Create hotspot user profile data
            $planData = [
                'name_plan' => $package->name,
                'typebp' => 'Limited',
                'limit_type' => 'Time_Limit',
                'time_limit' => $package->duration_hours,
                'time_unit' => 'Hrs',
                'shared_users' => 1
            ];
            
            // Create customer data
            $customerData = [
                'username' => $username,
                'password' => $password,
                'mac_address' => $session->mac_address
            ];
            
            // Add user to MikroTik
            $device->addHotspotUser($client, $planData, $customerData);
            
            // Update session with user credentials
            $session->payment_status = 'completed';
            $session->expires_at = date('Y-m-d H:i:s', strtotime('+' . $package->duration_hours . ' hours'));
            $session->save();
            
            // Log success
            file_put_contents('system/uploads/hotspot_users.log', 
                date('Y-m-d H:i:s') . ' - Created user: ' . $username . ' for MAC: ' . $session->mac_address . PHP_EOL, FILE_APPEND);
                
            return true;
        }
        
        return false;
        
    } catch (Exception $e) {
        // Log error
        file_put_contents('system/uploads/hotspot_users.log', 
            date('Y-m-d H:i:s') . ' - ERROR: ' . $e->getMessage() . PHP_EOL, FILE_APPEND);
        return false;
    }
}