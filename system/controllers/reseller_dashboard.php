<?php

/**
 * Complete Reseller Dashboard System
 * Provides full billing system functionality for resellers
 */

// Check if user is a reseller admin
function _reseller_admin($redirect = true) {
    global $routes;
    
    if (!isset($_SESSION['reseller_admin_id'])) {
        if ($redirect) {
            r2(U . 'reseller/login', 'e', 'Please login to access reseller panel');
        }
        return false;
    }
    
    $admin = ORM::for_table('tbl_reseller_admins')
        ->where('id', $_SESSION['reseller_admin_id'])
        ->where('status', 'active')
        ->find_one();
    
    if (!$admin) {
        if ($redirect) {
            r2(U . 'reseller/login', 'e', 'Invalid session');
        }
        return false;
    }
    
    // Check reseller subscription status
    require_once 'system/autoload/ResellerAuth.php';
    $subscriptionCheck = ResellerAuth::checkSubscription($admin->reseller_id);
    
    if (!$subscriptionCheck['active']) {
        if ($redirect) {
            r2(U . 'reseller/subscription', 'e', $subscriptionCheck['message']);
        }
        return false;
    }
    
    $_SESSION['reseller_id'] = $admin->reseller_id;
    return $admin->as_array();
}

$action = $routes['1'] ?? 'dashboard';
$reseller_admin = _reseller_admin();
$reseller_id = $_SESSION['reseller_id'];

$ui->assign('_title', 'Reseller Dashboard');
$ui->assign('_system_menu', 'reseller_dashboard');
$ui->assign('reseller_admin', $reseller_admin);

switch ($action) {
    case 'dashboard':
        handleResellerDashboard($reseller_id);
        break;
    case 'sales':
        handleSalesReports($reseller_id);
        break;
    case 'customers':
        handleCustomerManagement($reseller_id);
        break;
    case 'routers':
        handleRouterManagement($reseller_id);
        break;
    case 'transactions':
        handleTransactionManagement($reseller_id);
        break;
    case 'packages':
        handlePackageManagement($reseller_id);
        break;
    case 'users_status':
        handleUserStatus($reseller_id);
        break;
    case 'settings':
        handleResellerSettings($reseller_id);
        break;
    default:
        r2(U . 'reseller/dashboard', 'e', 'Invalid action');
}

function handleResellerDashboard($reseller_id) {
    global $ui;
    
    // Get reseller info
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    // Today's statistics
    $today = date('Y-m-d');
    $stats = [];
    
    // Revenue statistics
    $stats['today_revenue'] = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where('recharged_on', $today)
        ->sum('price') ?: 0;
    
    $stats['week_revenue'] = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', date('Y-m-d', strtotime('monday this week')))
        ->sum('price') ?: 0;
    
    $stats['month_revenue'] = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', date('Y-m-01'))
        ->sum('price') ?: 0;
    
    // Customer statistics
    $stats['total_customers'] = ORM::for_table('tbl_customers')
        ->where('reseller_id', $reseller_id)
        ->count();
    
    $stats['active_customers'] = ORM::for_table('tbl_user_recharges')
        ->where('reseller_id', $reseller_id)
        ->where('status', 'on')
        ->where_gte('expiration', date('Y-m-d H:i:s'))
        ->count();
    
    // Router statistics
    $stats['total_routers'] = ORM::for_table('tbl_routers')
        ->where('reseller_id', $reseller_id)
        ->count();
    
    $stats['enabled_routers'] = ORM::for_table('tbl_routers')
        ->where('reseller_id', $reseller_id)
        ->where('enabled', 1)
        ->count();
    
    // Get MikroTik real-time stats
    $mikrotik_stats = getResellerMikroTikStats($reseller_id);
    
    // Recent transactions
    $recent_transactions = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->order_by_desc('recharged_on')
        ->limit(10)
        ->find_many();
    
    // Payment method breakdown
    $payment_methods = ORM::for_table('tbl_transactions')
        ->select('method')
        ->select_expr('COUNT(*)', 'count')
        ->select_expr('SUM(price)', 'total')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', date('Y-m-01'))
        ->group_by('method')
        ->find_many();
    
    // Subscription info
    $subscription = ORM::for_table('tbl_reseller_subscription_payments')
        ->where('reseller_id', $reseller_id)
        ->where('status', 'completed')
        ->order_by_desc('payment_date')
        ->find_one();
    
    $ui->assign('reseller', $reseller);
    $ui->assign('stats', $stats);
    $ui->assign('mikrotik_stats', $mikrotik_stats);
    $ui->assign('recent_transactions', $recent_transactions);
    $ui->assign('payment_methods', $payment_methods);
    $ui->assign('subscription', $subscription);
    $ui->display('reseller/dashboard.tpl');
}

function handleSalesReports($reseller_id) {
    global $ui;
    
    $period = _post('period') ?: 'daily';
    $start_date = _post('start_date') ?: date('Y-m-d', strtotime('-30 days'));
    $end_date = _post('end_date') ?: date('Y-m-d');
    
    // Generate sales report
    $sales_data = [];
    
    if ($period == 'daily') {
        $query = "SELECT DATE(recharged_on) as date, 
                         COUNT(*) as transactions, 
                         SUM(price) as revenue,
                         COUNT(DISTINCT username) as unique_customers
                  FROM tbl_transactions 
                  WHERE reseller_id = ? 
                  AND recharged_on BETWEEN ? AND ?
                  GROUP BY DATE(recharged_on)
                  ORDER BY date DESC";
    } elseif ($period == 'weekly') {
        $query = "SELECT YEARWEEK(recharged_on) as week,
                         MIN(DATE(recharged_on)) as start_date,
                         MAX(DATE(recharged_on)) as end_date,
                         COUNT(*) as transactions,
                         SUM(price) as revenue,
                         COUNT(DISTINCT username) as unique_customers
                  FROM tbl_transactions 
                  WHERE reseller_id = ? 
                  AND recharged_on BETWEEN ? AND ?
                  GROUP BY YEARWEEK(recharged_on)
                  ORDER BY week DESC";
    } else { // monthly
        $query = "SELECT DATE_FORMAT(recharged_on, '%Y-%m') as month,
                         COUNT(*) as transactions,
                         SUM(price) as revenue,
                         COUNT(DISTINCT username) as unique_customers
                  FROM tbl_transactions 
                  WHERE reseller_id = ? 
                  AND recharged_on BETWEEN ? AND ?
                  GROUP BY DATE_FORMAT(recharged_on, '%Y-%m')
                  ORDER BY month DESC";
    }
    
    $sales_data = ORM::for_table('tbl_transactions')
        ->raw_query($query, [$reseller_id, $start_date . ' 00:00:00', $end_date . ' 23:59:59'])
        ->find_many();
    
    // Package performance
    $package_performance = ORM::for_table('tbl_transactions')
        ->select('plan_name')
        ->select_expr('COUNT(*)', 'sales_count')
        ->select_expr('SUM(price)', 'total_revenue')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', $start_date . ' 00:00:00')
        ->where_lte('recharged_on', $end_date . ' 23:59:59')
        ->group_by('plan_name')
        ->order_by_desc('total_revenue')
        ->find_many();
    
    $ui->assign('period', $period);
    $ui->assign('start_date', $start_date);
    $ui->assign('end_date', $end_date);
    $ui->assign('sales_data', $sales_data);
    $ui->assign('package_performance', $package_performance);
    $ui->display('reseller/sales_reports.tpl');
}

function handleUserStatus($reseller_id) {
    global $ui;
    
    $status_filter = _post('status') ?: 'all';
    
    // Get real-time user status from MikroTik
    $mikrotik_users = getResellerMikroTikUsers($reseller_id);
    
    // Get customer database info
    $customers_query = ORM::for_table('tbl_customers')
        ->select('tbl_customers.*')
        ->select('tbl_user_recharges.status', 'plan_status')
        ->select('tbl_user_recharges.expiration')
        ->select('tbl_plans.name_plan', 'plan_name')
        ->left_outer_join('tbl_user_recharges', 
            ['tbl_customers.id', '=', 'tbl_user_recharges.customer_id'])
        ->left_outer_join('tbl_plans', 
            ['tbl_user_recharges.plan_id', '=', 'tbl_plans.id'])
        ->where('tbl_customers.reseller_id', $reseller_id);
    
    if ($status_filter == 'active') {
        $customers_query->where('tbl_user_recharges.status', 'on')
                       ->where_gte('tbl_user_recharges.expiration', date('Y-m-d H:i:s'));
    } elseif ($status_filter == 'expired') {
        $customers_query->where_raw("(tbl_user_recharges.status = 'off' OR tbl_user_recharges.expiration < NOW())");
    } elseif ($status_filter == 'online') {
        // Will filter by MikroTik online status
    }
    
    $customers = $customers_query->find_many();
    
    // Merge database info with real-time MikroTik status
    foreach ($customers as $customer) {
        $customer->online_status = 'offline';
        $customer->session_time = null;
        $customer->data_usage = null;
        
        foreach ($mikrotik_users as $mt_user) {
            if ($mt_user['name'] == $customer->username) {
                $customer->online_status = 'online';
                $customer->session_time = $mt_user['uptime'] ?? null;
                $customer->data_usage = $mt_user['bytes'] ?? null;
                break;
            }
        }
    }
    
    // Filter by online status if needed
    if ($status_filter == 'online') {
        $customers = array_filter($customers, function($c) { 
            return $c->online_status == 'online'; 
        });
    } elseif ($status_filter == 'offline') {
        $customers = array_filter($customers, function($c) { 
            return $c->online_status == 'offline'; 
        });
    }
    
    $ui->assign('customers', $customers);
    $ui->assign('status_filter', $status_filter);
    $ui->assign('mikrotik_users', $mikrotik_users);
    $ui->display('reseller/user_status.tpl');
}

function handleRouterManagement($reseller_id) {
    global $ui, $routes;
    
    $router_action = $routes['2'] ?? 'list';
    
    if ($router_action == 'list') {
        $routers = ORM::for_table('tbl_routers')
            ->where('reseller_id', $reseller_id)
            ->find_many();
        
        // Test connectivity for each router
        foreach ($routers as $router) {
            $router->status = testRouterConnectivity($router);
        }
        
        $ui->assign('routers', $routers);
        $ui->display('reseller/routers.tpl');
        
    } elseif ($router_action == 'add' && _post('save')) {
        // Add new router
        $router = ORM::for_table('tbl_routers')->create();
        $router->name = _post('name');
        $router->ip_address = _post('ip_address');
        $router->username = _post('username');
        $router->password = _post('password');
        $router->description = _post('description');
        $router->reseller_id = $reseller_id;
        $router->enabled = 1;
        $router->save();
        
        r2(U . 'reseller/routers', 's', 'Router added successfully');
    }
}

function getResellerMikroTikStats($reseller_id) {
    $stats = [
        'pppoe_active' => 0,
        'hotspot_active' => 0,
        'total_active' => 0
    ];
    
    try {
        $routers = ORM::for_table('tbl_routers')
            ->where('reseller_id', $reseller_id)
            ->where('enabled', 1)
            ->find_many();
        
        foreach ($routers as $router) {
            // Connect to MikroTik and get active sessions
            require_once 'system/devices/Mikrotik.php';
            $mikrotik = new Mikrotik($router->ip_address, $router->username, $router->password);
            
            if ($mikrotik->connect()) {
                $pppoe_active = $mikrotik->comm('/ppp/active/print');
                $hotspot_active = $mikrotik->comm('/ip/hotspot/active/print');
                
                $stats['pppoe_active'] += count($pppoe_active);
                $stats['hotspot_active'] += count($hotspot_active);
            }
        }
        
        $stats['total_active'] = $stats['pppoe_active'] + $stats['hotspot_active'];
        
    } catch (Exception $e) {
        // Log error but don't break dashboard
        error_log("MikroTik stats error for reseller $reseller_id: " . $e->getMessage());
    }
    
    return $stats;
}

function getResellerMikroTikUsers($reseller_id) {
    $users = [];
    
    try {
        $routers = ORM::for_table('tbl_routers')
            ->where('reseller_id', $reseller_id)
            ->where('enabled', 1)
            ->find_many();
        
        foreach ($routers as $router) {
            require_once 'system/devices/Mikrotik.php';
            $mikrotik = new Mikrotik($router->ip_address, $router->username, $router->password);
            
            if ($mikrotik->connect()) {
                $pppoe_users = $mikrotik->comm('/ppp/active/print');
                $hotspot_users = $mikrotik->comm('/ip/hotspot/active/print');
                
                foreach ($pppoe_users as $user) {
                    $users[] = [
                        'name' => $user['name'],
                        'type' => 'PPPoE',
                        'address' => $user['address'] ?? '',
                        'uptime' => $user['uptime'] ?? '',
                        'bytes' => $user['bytes'] ?? '',
                        'router' => $router->name
                    ];
                }
                
                foreach ($hotspot_users as $user) {
                    $users[] = [
                        'name' => $user['user'] ?? '',
                        'type' => 'Hotspot',
                        'address' => $user['address'] ?? '',
                        'uptime' => $user['uptime'] ?? '',
                        'bytes' => $user['bytes'] ?? '',
                        'router' => $router->name
                    ];
                }
            }
        }
        
    } catch (Exception $e) {
        error_log("MikroTik users error for reseller $reseller_id: " . $e->getMessage());
    }
    
    return $users;
}

function testRouterConnectivity($router) {
    try {
        require_once 'system/devices/Mikrotik.php';
        $mikrotik = new Mikrotik($router->ip_address, $router->username, $router->password);
        
        if ($mikrotik->connect()) {
            return 'online';
        } else {
            return 'offline';
        }
    } catch (Exception $e) {
        return 'error';
    }
}