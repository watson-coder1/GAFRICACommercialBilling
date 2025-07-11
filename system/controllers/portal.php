<?php

/**
 * Captive Portal Controller
 * Handles hotspot package selection and payment processing
 */

if (!defined('PEAR2_NET_ROUTEROS')) {
    define('PEAR2_NET_ROUTEROS', 'pear2/net_routeros');
}

switch ($routes['1']) {
    case 'login':
        $mac = $_GET['mac'] ?? '';
        $ip = $_GET['ip'] ?? '';
        $sessionId = uniqid('portal_', true);
        
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
        $ui->display('portal-login.tpl');
        break;
        
    case 'select':
        $sessionId = $_POST['session_id'] ?? '';
        $packageId = $_POST['package_id'] ?? '';
        $phoneNumber = $_POST['phone_number'] ?? '';
        
        if (!$sessionId || !$packageId || !$phoneNumber) {
            r2(U . 'portal/login', 'e', 'Missing required information');
        }
        
        // Validate phone number format (Kenyan format)
        if (!preg_match('/^(254|0)[17]\d{8}$/', $phoneNumber)) {
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
        
        // For now, redirect to payment status (will implement M-Pesa later)
        r2(U . 'portal/payment/' . $sessionId);
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
        
    default:
        r2(U . 'portal/login');
        break;
}