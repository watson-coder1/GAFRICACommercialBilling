<?php

/**
 * Reseller Reports and Analytics
 * Revenue reports and customer analytics for resellers
 */

// Ensure reseller is logged in
if (!isset($_SESSION['reseller_admin_id'])) {
    header('Location: ' . RESELLER_URL . '/login');
    exit;
}

$admin_id = $_SESSION['reseller_admin_id'];
$reseller_id = $_SESSION['reseller_id'];

$action = $routes[1] ?? 'dashboard';

switch ($action) {
    case 'dashboard':
        handleReportsDashboard();
        break;
    case 'revenue':
        handleRevenueReport();
        break;
    case 'transactions':
        handleTransactionReport();
        break;
    case 'customers':
        handleCustomerReport();
        break;
    default:
        handleReportsDashboard();
}

function handleReportsDashboard() {
    global $ui, $reseller_id;
    
    // Get date range
    $from = $_GET['from'] ?? date('Y-m-01');
    $to = $_GET['to'] ?? date('Y-m-d');
    
    // Revenue statistics
    $totalRevenue = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', $from)
        ->where_lte('recharged_on', $to)
        ->sum('price') ?: 0;
    
    $todayRevenue = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where('recharged_on', date('Y-m-d'))
        ->sum('price') ?: 0;
    
    $weekRevenue = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', date('Y-m-d', strtotime('-7 days')))
        ->sum('price') ?: 0;
    
    $monthRevenue = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', date('Y-m-01'))
        ->sum('price') ?: 0;
    
    // Customer statistics
    $totalCustomers = ORM::for_table('tbl_customers')
        ->where('reseller_id', $reseller_id)
        ->count();
    
    $activeCustomers = ORM::for_table('tbl_user_recharges')
        ->table_alias('ur')
        ->join('tbl_customers', 'ur.username = c.username', 'c')
        ->where('c.reseller_id', $reseller_id)
        ->where_gte('ur.expiration', date('Y-m-d H:i:s'))
        ->count();
    
    // Recent transactions
    $recentTransactions = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->order_by_desc('id')
        ->limit(10)
        ->find_many();
    
    // Daily revenue chart data (last 30 days)
    $chartData = [];
    for ($i = 29; $i >= 0; $i--) {
        $date = date('Y-m-d', strtotime("-$i days"));
        $revenue = ORM::for_table('tbl_transactions')
            ->where('reseller_id', $reseller_id)
            ->where('recharged_on', $date)
            ->sum('price') ?: 0;
        $chartData[] = [
            'date' => $date,
            'revenue' => $revenue
        ];
    }
    
    $ui->assign('totalRevenue', $totalRevenue);
    $ui->assign('todayRevenue', $todayRevenue);
    $ui->assign('weekRevenue', $weekRevenue);
    $ui->assign('monthRevenue', $monthRevenue);
    $ui->assign('totalCustomers', $totalCustomers);
    $ui->assign('activeCustomers', $activeCustomers);
    $ui->assign('recentTransactions', $recentTransactions);
    $ui->assign('chartData', $chartData);
    $ui->assign('from', $from);
    $ui->assign('to', $to);
    $ui->assign('_title', 'Reports Dashboard');
    $ui->assign('_system_menu', 'reports');
    $ui->display('reports/dashboard.tpl');
}

function handleRevenueReport() {
    global $ui, $reseller_id;
    
    $from = $_GET['from'] ?? date('Y-m-01');
    $to = $_GET['to'] ?? date('Y-m-d');
    
    // Revenue by plan
    $revenueByPlan = ORM::for_table('tbl_transactions')
        ->select('plan_name')
        ->select_expr('COUNT(*)', 'count')
        ->select_expr('SUM(price)', 'total')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', $from)
        ->where_lte('recharged_on', $to)
        ->group_by('plan_name')
        ->order_by_desc('total')
        ->find_many();
    
    // Daily revenue
    $dailyRevenue = ORM::for_table('tbl_transactions')
        ->select('recharged_on')
        ->select_expr('COUNT(*)', 'count')
        ->select_expr('SUM(price)', 'total')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', $from)
        ->where_lte('recharged_on', $to)
        ->group_by('recharged_on')
        ->order_by_desc('recharged_on')
        ->find_many();
    
    $ui->assign('revenueByPlan', $revenueByPlan);
    $ui->assign('dailyRevenue', $dailyRevenue);
    $ui->assign('from', $from);
    $ui->assign('to', $to);
    $ui->assign('_title', 'Revenue Report');
    $ui->assign('_system_menu', 'reports');
    $ui->display('reports/revenue.tpl');
}

function handleTransactionReport() {
    global $ui, $reseller_id;
    
    $from = $_GET['from'] ?? date('Y-m-01');
    $to = $_GET['to'] ?? date('Y-m-d');
    $plan = $_GET['plan'] ?? '';
    $customer = $_GET['customer'] ?? '';
    
    $query = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', $from)
        ->where_lte('recharged_on', $to);
    
    if (!empty($plan)) {
        $query->where('plan_name', $plan);
    }
    
    if (!empty($customer)) {
        $query->where_like('username', '%' . $customer . '%');
    }
    
    $transactions = $query->order_by_desc('id')->find_many();
    
    // Get unique plans for filter
    $plans = ORM::for_table('tbl_transactions')
        ->select('plan_name')
        ->where('reseller_id', $reseller_id)
        ->group_by('plan_name')
        ->find_many();
    
    $ui->assign('transactions', $transactions);
    $ui->assign('plans', $plans);
    $ui->assign('from', $from);
    $ui->assign('to', $to);
    $ui->assign('plan', $plan);
    $ui->assign('customer', $customer);
    $ui->assign('_title', 'Transaction Report');
    $ui->assign('_system_menu', 'reports');
    $ui->display('reports/transactions.tpl');
}

function handleCustomerReport() {
    global $ui, $reseller_id;
    
    // Customer growth
    $customerGrowth = ORM::for_table('tbl_customers')
        ->select_expr('DATE(created_at)', 'date')
        ->select_expr('COUNT(*)', 'count')
        ->where('reseller_id', $reseller_id)
        ->where_gte('created_at', date('Y-m-d', strtotime('-30 days')))
        ->group_by_expr('DATE(created_at)')
        ->order_by('date')
        ->find_many();
    
    // Top customers by revenue
    $topCustomers = ORM::for_table('tbl_transactions')
        ->select('username')
        ->select_expr('COUNT(*)', 'transaction_count')
        ->select_expr('SUM(price)', 'total_spent')
        ->where('reseller_id', $reseller_id)
        ->group_by('username')
        ->order_by_desc('total_spent')
        ->limit(20)
        ->find_many();
    
    $ui->assign('customerGrowth', $customerGrowth);
    $ui->assign('topCustomers', $topCustomers);
    $ui->assign('_title', 'Customer Report');
    $ui->assign('_system_menu', 'reports');
    $ui->display('reports/customers.tpl');
}