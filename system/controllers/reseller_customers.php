<?php

/**
 * Reseller Customer Management
 * Manage customers for reseller
 */

// Ensure reseller is logged in
if (!isset($_SESSION['reseller_admin_id'])) {
    header('Location: ' . RESELLER_URL . '/login');
    exit;
}

$admin_id = $_SESSION['reseller_admin_id'];
$reseller_id = $_SESSION['reseller_id'];

$action = $routes[1] ?? 'list';

switch ($action) {
    case 'list':
        handleCustomerList();
        break;
    case 'view':
        handleCustomerView();
        break;
    case 'add':
        handleCustomerAdd();
        break;
    case 'edit':
        handleCustomerEdit();
        break;
    case 'delete':
        handleCustomerDelete();
        break;
    case 'recharge':
        handleCustomerRecharge();
        break;
    case 'disconnect':
        handleCustomerDisconnect();
        break;
    case 'voucher':
        handleCustomerVoucher();
        break;
    case 'plans':
        handleCustomerPlans();
        break;
    default:
        handleCustomerList();
}

function handleCustomerList() {
    global $ui, $reseller_id;
    
    // Get customers for this reseller
    $customers = ORM::for_table('tbl_customers')
        ->where('reseller_id', $reseller_id)
        ->order_by_desc('id')
        ->find_many();
    
    $ui->assign('customers', $customers);
    $ui->assign('_title', 'Customer Management');
    $ui->assign('_system_menu', 'customers');
    $ui->display('customers/list.tpl');
}

function handleCustomerView() {
    global $ui, $reseller_id, $routes;
    
    $customer_id = $routes[2] ?? 0;
    
    $customer = ORM::for_table('tbl_customers')
        ->where('id', $customer_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$customer) {
        r2(RESELLER_URL . '/customers', 'e', 'Customer not found');
    }
    
    // Get customer transactions
    $transactions = ORM::for_table('tbl_transactions')
        ->where('username', $customer->username)
        ->order_by_desc('id')
        ->limit(20)
        ->find_many();
    
    $ui->assign('customer', $customer);
    $ui->assign('transactions', $transactions);
    $ui->assign('_title', 'Customer Details');
    $ui->assign('_system_menu', 'customers');
    $ui->display('customers/view.tpl');
}

function handleCustomerAdd() {
    global $ui, $reseller_id;
    
    if ($_POST) {
        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';
        $fullname = $_POST['fullname'] ?? '';
        $email = $_POST['email'] ?? '';
        $phone = $_POST['phone'] ?? '';
        
        // Validate required fields
        if (empty($username) || empty($password) || empty($fullname)) {
            r2(RESELLER_URL . '/customers/add', 'e', 'Username, password and full name are required');
        }
        
        // Check if username exists
        $existing = ORM::for_table('tbl_customers')
            ->where('username', $username)
            ->find_one();
        
        if ($existing) {
            r2(RESELLER_URL . '/customers/add', 'e', 'Username already exists');
        }
        
        // Create customer
        $customer = ORM::for_table('tbl_customers')->create();
        $customer->username = $username;
        $customer->password = password_hash($password, PASSWORD_DEFAULT);
        $customer->fullname = $fullname;
        $customer->email = $email;
        $customer->phonenumber = $phone;
        $customer->reseller_id = $reseller_id;
        $customer->created_at = date('Y-m-d H:i:s');
        $customer->updated_at = date('Y-m-d H:i:s');
        $customer->save();
        
        r2(RESELLER_URL . '/customers', 's', 'Customer created successfully');
    }
    
    $ui->assign('_title', 'Add Customer');
    $ui->assign('_system_menu', 'customers');
    $ui->display('customers/add.tpl');
}

function handleCustomerEdit() {
    global $ui, $reseller_id, $routes;
    
    $customer_id = $routes[2] ?? 0;
    
    $customer = ORM::for_table('tbl_customers')
        ->where('id', $customer_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$customer) {
        r2(RESELLER_URL . '/customers', 'e', 'Customer not found');
    }
    
    if ($_POST) {
        $fullname = $_POST['fullname'] ?? '';
        $email = $_POST['email'] ?? '';
        $phone = $_POST['phone'] ?? '';
        $password = $_POST['password'] ?? '';
        
        if (empty($fullname)) {
            r2(RESELLER_URL . '/customers/edit/' . $customer_id, 'e', 'Full name is required');
        }
        
        $customer->fullname = $fullname;
        $customer->email = $email;
        $customer->phonenumber = $phone;
        
        if (!empty($password)) {
            $customer->password = password_hash($password, PASSWORD_DEFAULT);
        }
        
        $customer->updated_at = date('Y-m-d H:i:s');
        $customer->save();
        
        r2(RESELLER_URL . '/customers', 's', 'Customer updated successfully');
    }
    
    $ui->assign('customer', $customer);
    $ui->assign('_title', 'Edit Customer');
    $ui->assign('_system_menu', 'customers');
    $ui->display('customers/edit.tpl');
}

function handleCustomerDelete() {
    global $reseller_id, $routes;
    
    $customer_id = $routes[2] ?? 0;
    
    $customer = ORM::for_table('tbl_customers')
        ->where('id', $customer_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$customer) {
        r2(RESELLER_URL . '/customers', 'e', 'Customer not found');
    }
    
    $customer->delete();
    r2(RESELLER_URL . '/customers', 's', 'Customer deleted successfully');
}

function handleCustomerRecharge() {
    global $ui, $reseller_id, $routes;
    
    $customer_id = $routes[2] ?? 0;
    
    $customer = ORM::for_table('tbl_customers')
        ->where('id', $customer_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$customer) {
        r2(RESELLER_URL . '/customers', 'e', 'Customer not found');
    }
    
    // Get available plans for this reseller
    $plans = ORM::for_table('tbl_plans')
        ->where('enabled', 1)
        ->find_many();
    
    // Get reseller's routers
    $routers = ORM::for_table('tbl_routers')
        ->where('reseller_id', $reseller_id)
        ->where('enabled', 1)
        ->find_many();
    
    if ($_POST) {
        $plan_id = $_POST['plan_id'] ?? '';
        $router_id = $_POST['router_id'] ?? '';
        $type = $_POST['type'] ?? 'Hotspot';
        $payment_method = $_POST['payment_method'] ?? 'Manual';
        
        if (empty($plan_id) || empty($router_id)) {
            r2(RESELLER_URL . '/customers/recharge/' . $customer_id, 'e', 'Plan and router are required');
        }
        
        $plan = ORM::for_table('tbl_plans')->find_one($plan_id);
        $router = ORM::for_table('tbl_routers')->find_one($router_id);
        
        if (!$plan || !$router) {
            r2(RESELLER_URL . '/customers/recharge/' . $customer_id, 'e', 'Invalid plan or router');
        }
        
        // Create transaction
        $transaction = ORM::for_table('tbl_transactions')->create();
        $transaction->invoice = date('Ymd') . rand(1000, 9999);
        $transaction->username = $customer->username;
        $transaction->plan_name = $plan->name_plan;
        $transaction->price = $plan->price;
        $transaction->recharged_on = date('Y-m-d');
        $transaction->recharged_time = date('H:i:s');
        $transaction->expiration = date('Y-m-d', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
        $transaction->time = date('Y-m-d H:i:s');
        $transaction->method = $payment_method;
        $transaction->routers = $router_id;
        $transaction->type = $type;
        $transaction->admin_id = $_SESSION['reseller_admin_id'];
        $transaction->reseller_id = $reseller_id;
        $transaction->save();
        
        // Create or update user recharge
        $recharge = ORM::for_table('tbl_user_recharges')
            ->where('username', $customer->username)
            ->where('namebp', $plan->name_plan)
            ->find_one();
        
        if (!$recharge) {
            $recharge = ORM::for_table('tbl_user_recharges')->create();
            $recharge->username = $customer->username;
            $recharge->namebp = $plan->name_plan;
            $recharge->recharged_on = date('Y-m-d H:i:s');
            $recharge->routers = $router_id;
            $recharge->type = $type;
        }
        
        $recharge->expiration = date('Y-m-d H:i:s', strtotime('+' . $plan->validity . ' ' . $plan->validity_unit));
        $recharge->status = 'on';
        $recharge->save();
        
        // Add user to MikroTik if needed
        if ($type === 'Hotspot') {
            // Add hotspot user logic here
            addHotspotUser($customer, $plan, $router);
        } elseif ($type === 'PPOE') {
            // Add PPOE user logic here
            addPPOEUser($customer, $plan, $router);
        }
        
        r2(RESELLER_URL . '/customers', 's', 'Customer recharged successfully');
    }
    
    $ui->assign('customer', $customer);
    $ui->assign('plans', $plans);
    $ui->assign('routers', $routers);
    $ui->assign('_title', 'Recharge Customer');
    $ui->assign('_system_menu', 'customers');
    $ui->display('customers/recharge.tpl');
}

function handleCustomerDisconnect() {
    global $reseller_id, $routes;
    
    $customer_id = $routes[2] ?? 0;
    
    $customer = ORM::for_table('tbl_customers')
        ->where('id', $customer_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$customer) {
        r2(RESELLER_URL . '/customers', 'e', 'Customer not found');
    }
    
    // Disconnect from all routers
    $routers = ORM::for_table('tbl_routers')
        ->where('reseller_id', $reseller_id)
        ->where('enabled', 1)
        ->find_many();
    
    foreach ($routers as $router) {
        disconnectCustomerFromRouter($customer, $router);
    }
    
    // Update user recharges
    $recharges = ORM::for_table('tbl_user_recharges')
        ->where('username', $customer->username)
        ->find_many();
    
    foreach ($recharges as $recharge) {
        $recharge->status = 'off';
        $recharge->save();
    }
    
    r2(RESELLER_URL . '/customers', 's', 'Customer disconnected successfully');
}

function handleCustomerVoucher() {
    global $ui, $reseller_id, $routes;
    
    $customer_id = $routes[2] ?? 0;
    
    $customer = ORM::for_table('tbl_customers')
        ->where('id', $customer_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$customer) {
        r2(RESELLER_URL . '/customers', 'e', 'Customer not found');
    }
    
    // Get available vouchers for this reseller
    $vouchers = ORM::for_table('tbl_voucher')
        ->where('reseller_id', $reseller_id)
        ->where('user', '')
        ->where('status', 0)
        ->find_many();
    
    if ($_POST) {
        $voucher_code = $_POST['voucher_code'] ?? '';
        
        if (empty($voucher_code)) {
            r2(RESELLER_URL . '/customers/voucher/' . $customer_id, 'e', 'Voucher code is required');
        }
        
        $voucher = ORM::for_table('tbl_voucher')
            ->where('code', $voucher_code)
            ->where('reseller_id', $reseller_id)
            ->where('user', '')
            ->where('status', 0)
            ->find_one();
        
        if (!$voucher) {
            r2(RESELLER_URL . '/customers/voucher/' . $customer_id, 'e', 'Invalid or used voucher code');
        }
        
        // Redeem voucher
        $voucher->user = $customer->username;
        $voucher->date_used = date('Y-m-d H:i:s');
        $voucher->status = 1;
        $voucher->save();
        
        // Process voucher recharge (implement voucher logic)
        
        r2(RESELLER_URL . '/customers', 's', 'Voucher redeemed successfully');
    }
    
    $ui->assign('customer', $customer);
    $ui->assign('vouchers', $vouchers);
    $ui->assign('_title', 'Redeem Voucher');
    $ui->assign('_system_menu', 'customers');
    $ui->display('customers/voucher.tpl');
}

function handleCustomerPlans() {
    global $ui, $reseller_id, $routes;
    
    $customer_id = $routes[2] ?? 0;
    
    $customer = ORM::for_table('tbl_customers')
        ->where('id', $customer_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$customer) {
        r2(RESELLER_URL . '/customers', 'e', 'Customer not found');
    }
    
    // Get customer's active plans
    $active_plans = ORM::for_table('tbl_user_recharges')
        ->where('username', $customer->username)
        ->where('status', 'on')
        ->find_many();
    
    $ui->assign('customer', $customer);
    $ui->assign('active_plans', $active_plans);
    $ui->assign('_title', 'Customer Plans');
    $ui->assign('_system_menu', 'customers');
    $ui->display('customers/plans.tpl');
}

// Helper functions for MikroTik integration
function addHotspotUser($customer, $plan, $router) {
    try {
        require_once 'system/devices/RouterOSAPI.php';
        
        $API = new RouterosAPI();
        
        if ($router->api_ssl) {
            $API->useSsl = true;
        }
        
        if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
            // Check if user exists
            $existing = $API->comm('/ip/hotspot/user/print', [
                '?name' => $customer->username
            ]);
            
            if (empty($existing)) {
                // Add new user
                $API->comm('/ip/hotspot/user/add', [
                    'name' => $customer->username,
                    'password' => $customer->password,
                    'profile' => $plan->name_plan,
                    'limit-uptime' => $plan->validity . $plan->validity_unit
                ]);
            } else {
                // Update existing user
                $API->comm('/ip/hotspot/user/set', [
                    '.id' => $existing[0]['.id'],
                    'profile' => $plan->name_plan,
                    'limit-uptime' => $plan->validity . $plan->validity_unit
                ]);
            }
            
            $API->disconnect();
        }
        
    } catch (Exception $e) {
        error_log("Error adding hotspot user: " . $e->getMessage());
    }
}

function addPPOEUser($customer, $plan, $router) {
    try {
        require_once 'system/devices/RouterOSAPI.php';
        
        $API = new RouterosAPI();
        
        if ($router->api_ssl) {
            $API->useSsl = true;
        }
        
        if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
            // Check if user exists
            $existing = $API->comm('/ppp/secret/print', [
                '?name' => $customer->username
            ]);
            
            if (empty($existing)) {
                // Add new user
                $API->comm('/ppp/secret/add', [
                    'name' => $customer->username,
                    'password' => $customer->password,
                    'profile' => $plan->name_plan,
                    'service' => 'pppoe'
                ]);
            } else {
                // Update existing user
                $API->comm('/ppp/secret/set', [
                    '.id' => $existing[0]['.id'],
                    'profile' => $plan->name_plan
                ]);
            }
            
            $API->disconnect();
        }
        
    } catch (Exception $e) {
        error_log("Error adding PPOE user: " . $e->getMessage());
    }
}

function disconnectCustomerFromRouter($customer, $router) {
    try {
        require_once 'system/devices/RouterOSAPI.php';
        
        $API = new RouterosAPI();
        
        if ($router->api_ssl) {
            $API->useSsl = true;
        }
        
        if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
            // Disconnect from hotspot
            $hotspot_active = $API->comm('/ip/hotspot/active/print', [
                '?user' => $customer->username
            ]);
            
            foreach ($hotspot_active as $session) {
                $API->comm('/ip/hotspot/active/remove', [
                    '.id' => $session['.id']
                ]);
            }
            
            // Disconnect from PPOE
            $pppoe_active = $API->comm('/ppp/active/print', [
                '?name' => $customer->username
            ]);
            
            foreach ($pppoe_active as $session) {
                $API->comm('/ppp/active/remove', [
                    '.id' => $session['.id']
                ]);
            }
            
            $API->disconnect();
        }
        
    } catch (Exception $e) {
        error_log("Error disconnecting customer: " . $e->getMessage());
    }
}