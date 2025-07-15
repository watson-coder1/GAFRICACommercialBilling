<?php

/**
 * Reseller MikroTik Configuration System
 * Allows resellers to add, configure, and manage their MikroTik routers
 */

// Check reseller authentication
require_once 'reseller_dashboard.php';
$reseller_admin = _reseller_admin();
$reseller_id = $_SESSION['reseller_id'];

$action = $routes['2'] ?? 'list';

switch ($action) {
    case 'list':
        handleMikroTikList($reseller_id);
        break;
    case 'add':
        handleMikroTikAdd($reseller_id);
        break;
    case 'edit':
        handleMikroTikEdit($reseller_id);
        break;
    case 'test':
        handleMikroTikTest($reseller_id);
        break;
    case 'delete':
        handleMikroTikDelete($reseller_id);
        break;
    case 'configure':
        handleMikroTikConfigure($reseller_id);
        break;
    case 'users':
        handleMikroTikUsers($reseller_id);
        break;
    default:
        r2(U . 'reseller/mikrotik', 'e', 'Invalid action');
}

function handleMikroTikList($reseller_id) {
    global $ui;
    
    // Check reseller limits
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    $routers = ORM::for_table('tbl_routers')
        ->where('reseller_id', $reseller_id)
        ->find_many();
    
    // Test connectivity for each router
    foreach ($routers as $router) {
        $router->connection_status = testMikroTikConnection($router);
        $router->active_users = getMikroTikActiveUsers($router);
    }
    
    $ui->assign('routers', $routers);
    $ui->assign('reseller', $reseller);
    $ui->assign('router_count', count($routers));
    $ui->assign('max_routers', $reseller->max_routers);
    $ui->display('reseller/mikrotik_list.tpl');
}

function handleMikroTikAdd($reseller_id) {
    global $ui;
    
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    // Check router limit
    $current_count = ORM::for_table('tbl_routers')
        ->where('reseller_id', $reseller_id)
        ->count();
    
    if ($current_count >= $reseller->max_routers) {
        r2(U . 'reseller/mikrotik', 'e', 'Router limit reached. Your plan allows maximum ' . $reseller->max_routers . ' routers.');
    }
    
    if (_post('save')) {
        $name = _post('name');
        $ip_address = _post('ip_address');
        $username = _post('username');
        $password = _post('password');
        $description = _post('description');
        $api_port = _post('api_port') ?: 8728;
        $api_ssl = _post('api_ssl') ? 1 : 0;
        
        // Validation
        if (empty($name) || empty($ip_address) || empty($username) || empty($password)) {
            r2(U . 'reseller/mikrotik/add', 'e', 'All fields are required');
        }
        
        // Validate IP address
        if (!filter_var($ip_address, FILTER_VALIDATE_IP)) {
            r2(U . 'reseller/mikrotik/add', 'e', 'Invalid IP address format');
        }
        
        // Test connection before saving
        $test_result = testMikroTikConnectionManual($ip_address, $username, $password, $api_port, $api_ssl);
        
        if (!$test_result['success']) {
            r2(U . 'reseller/mikrotik/add', 'e', 'Connection test failed: ' . $test_result['message']);
        }
        
        // Create router
        $router = ORM::for_table('tbl_routers')->create();
        $router->name = $name;
        $router->ip_address = $ip_address;
        $router->username = $username;
        $router->password = $password;
        $router->description = $description;
        $router->api_port = $api_port;
        $router->api_ssl = $api_ssl;
        $router->reseller_id = $reseller_id;
        $router->enabled = 1;
        $router->save();
        
        // Log router addition
        _log('MikroTik router added: ' . $name . ' (' . $ip_address . ')', 'Reseller', $reseller_id);
        
        r2(U . 'reseller/mikrotik', 's', 'MikroTik router added successfully and connection tested!');
    }
    
    $ui->assign('reseller', $reseller);
    $ui->display('reseller/mikrotik_add.tpl');
}

function handleMikroTikEdit($reseller_id) {
    global $ui, $routes;
    
    $router_id = $routes['3'] ?? 0;
    
    $router = ORM::for_table('tbl_routers')
        ->where('id', $router_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$router) {
        r2(U . 'reseller/mikrotik', 'e', 'Router not found');
    }
    
    if (_post('save')) {
        $name = _post('name');
        $ip_address = _post('ip_address');
        $username = _post('username');
        $password = _post('password');
        $description = _post('description');
        $api_port = _post('api_port') ?: 8728;
        $api_ssl = _post('api_ssl') ? 1 : 0;
        $enabled = _post('enabled') ? 1 : 0;
        
        // Test connection if credentials changed
        if ($ip_address != $router->ip_address || $username != $router->username || 
            $password != $router->password || $api_port != $router->api_port || $api_ssl != $router->api_ssl) {
            
            $test_result = testMikroTikConnectionManual($ip_address, $username, $password, $api_port, $api_ssl);
            
            if (!$test_result['success']) {
                r2(U . 'reseller/mikrotik/edit/' . $router_id, 'e', 'Connection test failed: ' . $test_result['message']);
            }
        }
        
        // Update router
        $router->name = $name;
        $router->ip_address = $ip_address;
        $router->username = $username;
        $router->password = $password;
        $router->description = $description;
        $router->api_port = $api_port;
        $router->api_ssl = $api_ssl;
        $router->enabled = $enabled;
        $router->save();
        
        _log('MikroTik router updated: ' . $name . ' (' . $ip_address . ')', 'Reseller', $reseller_id);
        
        r2(U . 'reseller/mikrotik', 's', 'MikroTik router updated successfully!');
    }
    
    $ui->assign('router', $router);
    $ui->display('reseller/mikrotik_edit.tpl');
}

function handleMikroTikTest($reseller_id) {
    global $routes;
    
    $router_id = $routes['3'] ?? 0;
    
    $router = ORM::for_table('tbl_routers')
        ->where('id', $router_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$router) {
        r2(U . 'reseller/mikrotik', 'e', 'Router not found');
    }
    
    $test_result = testMikroTikConnection($router);
    
    if ($test_result['success']) {
        $active_users = getMikroTikActiveUsers($router);
        $message = 'Connection successful! Active users: ' . $active_users;
        r2(U . 'reseller/mikrotik', 's', $message);
    } else {
        r2(U . 'reseller/mikrotik', 'e', 'Connection failed: ' . $test_result['message']);
    }
}

function handleMikroTikDelete($reseller_id) {
    global $routes;
    
    $router_id = $routes['3'] ?? 0;
    
    $router = ORM::for_table('tbl_routers')
        ->where('id', $router_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$router) {
        r2(U . 'reseller/mikrotik', 'e', 'Router not found');
    }
    
    // Check if router has active customers
    $active_customers = ORM::for_table('tbl_user_recharges')
        ->where('routers', $router_id)
        ->where('status', 'on')
        ->count();
    
    if ($active_customers > 0) {
        r2(U . 'reseller/mikrotik', 'e', 'Cannot delete router with active customers');
    }
    
    $router_name = $router->name;
    $router->delete();
    
    _log('MikroTik router deleted: ' . $router_name, 'Reseller', $reseller_id);
    
    r2(U . 'reseller/mikrotik', 's', 'MikroTik router deleted successfully');
}

function handleMikroTikUsers($reseller_id) {
    global $ui, $routes;
    
    $router_id = $routes['3'] ?? 0;
    
    $router = ORM::for_table('tbl_routers')
        ->where('id', $router_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$router) {
        r2(U . 'reseller/mikrotik', 'e', 'Router not found');
    }
    
    // Get active users from MikroTik
    $active_users = getMikroTikDetailedUsers($router);
    
    // Get customer info from database
    $customers = ORM::for_table('tbl_customers')
        ->where('reseller_id', $reseller_id)
        ->find_many();
    
    $customer_map = [];
    foreach ($customers as $customer) {
        $customer_map[$customer->username] = $customer;
    }
    
    // Merge MikroTik data with customer data
    foreach ($active_users as &$user) {
        if (isset($customer_map[$user['name']])) {
            $user['customer'] = $customer_map[$user['name']];
        }
    }
    
    $ui->assign('router', $router);
    $ui->assign('active_users', $active_users);
    $ui->display('reseller/mikrotik_users.tpl');
}

function testMikroTikConnection($router) {
    return testMikroTikConnectionManual(
        $router->ip_address, 
        $router->username, 
        $router->password, 
        $router->api_port ?: 8728, 
        $router->api_ssl ?: 0
    );
}

function testMikroTikConnectionManual($ip, $username, $password, $port = 8728, $ssl = 0) {
    try {
        require_once 'system/devices/RouterOSAPI.php';
        
        $API = new RouterosAPI();
        $API->timeout = 5; // 5 second timeout
        
        if ($ssl) {
            $API->useSsl = true;
        }
        
        if ($API->connect($ip, $username, $password, $port)) {
            // Test basic command
            $identity = $API->comm('/system/identity/print');
            
            $API->disconnect();
            
            return [
                'success' => true,
                'message' => 'Connection successful',
                'identity' => $identity[0]['name'] ?? 'Unknown'
            ];
        } else {
            return [
                'success' => false,
                'message' => 'Authentication failed'
            ];
        }
        
    } catch (Exception $e) {
        return [
            'success' => false,
            'message' => $e->getMessage()
        ];
    }
}

function getMikroTikActiveUsers($router) {
    try {
        require_once 'system/devices/RouterOSAPI.php';
        
        $API = new RouterosAPI();
        $API->timeout = 5;
        
        if ($router->api_ssl) {
            $API->useSsl = true;
        }
        
        if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
            // Get PPPoE active
            $pppoe_active = $API->comm('/ppp/active/print');
            
            // Get Hotspot active
            $hotspot_active = $API->comm('/ip/hotspot/active/print');
            
            $API->disconnect();
            
            return count($pppoe_active) + count($hotspot_active);
        }
        
        return 0;
        
    } catch (Exception $e) {
        return 0;
    }
}

function getMikroTikDetailedUsers($router) {
    $users = [];
    
    try {
        require_once 'system/devices/RouterOSAPI.php';
        
        $API = new RouterosAPI();
        $API->timeout = 10;
        
        if ($router->api_ssl) {
            $API->useSsl = true;
        }
        
        if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
            // Get PPPoE active users
            $pppoe_active = $API->comm('/ppp/active/print');
            
            foreach ($pppoe_active as $user) {
                $users[] = [
                    'name' => $user['name'] ?? '',
                    'type' => 'PPPoE',
                    'address' => $user['address'] ?? '',
                    'uptime' => $user['uptime'] ?? '',
                    'bytes_in' => $user['bytes-in'] ?? 0,
                    'bytes_out' => $user['bytes-out'] ?? 0,
                    'session_id' => $user['.id'] ?? ''
                ];
            }
            
            // Get Hotspot active users
            $hotspot_active = $API->comm('/ip/hotspot/active/print');
            
            foreach ($hotspot_active as $user) {
                $users[] = [
                    'name' => $user['user'] ?? '',
                    'type' => 'Hotspot',
                    'address' => $user['address'] ?? '',
                    'uptime' => $user['uptime'] ?? '',
                    'bytes_in' => $user['bytes-in'] ?? 0,
                    'bytes_out' => $user['bytes-out'] ?? 0,
                    'session_id' => $user['.id'] ?? ''
                ];
            }
            
            $API->disconnect();
        }
        
    } catch (Exception $e) {
        error_log("MikroTik detailed users error: " . $e->getMessage());
    }
    
    return $users;
}