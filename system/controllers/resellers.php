<?php

/**
 * Reseller Management Controller
 * Handles reseller CRUD operations, subscriptions, and payments
 */

_admin();

$action = $routes['1'] ?? 'list';
$ui->assign('_title', 'Reseller Management');
$ui->assign('_system_menu', 'resellers');

switch ($action) {
    case 'list':
        handleResellerList();
        break;
    case 'add':
        handleResellerAdd();
        break;
    case 'edit':
        handleResellerEdit();
        break;
    case 'delete':
        handleResellerDelete();
        break;
    case 'view':
        handleResellerView();
        break;
    case 'payments':
        handleResellerPayments();
        break;
    case 'plans':
        handleResellerPlans();
        break;
    default:
        r2(getUrl('resellers'), 'e', 'Invalid action');
}

function handleResellerList()
{
    global $ui;
    
    $search = _post('search');
    $status = _post('status');
    
    $query = ORM::for_table('tbl_resellers')
        ->select('tbl_resellers.*')
        ->select_expr('COUNT(tbl_customers.id)', 'customer_count')
        ->select_expr('COUNT(tbl_routers.id)', 'router_count')
        ->left_outer_join('tbl_customers', array('tbl_resellers.id', '=', 'tbl_customers.reseller_id'))
        ->left_outer_join('tbl_routers', array('tbl_resellers.id', '=', 'tbl_routers.reseller_id'))
        ->group_by('tbl_resellers.id');
    
    if ($search) {
        $query->where_raw("(tbl_resellers.name LIKE '%$search%' OR tbl_resellers.email LIKE '%$search%' OR tbl_resellers.company LIKE '%$search%')");
    }
    
    if ($status) {
        $query->where('tbl_resellers.status', $status);
    }
    
    $resellers = $query->order_by_desc('tbl_resellers.created_at')->find_many();
    
    // Get subscription info for each reseller
    foreach ($resellers as $reseller) {
        $subscription = ORM::for_table('tbl_reseller_subscriptions')
            ->where('reseller_id', $reseller->id)
            ->where('status', 'active')
            ->order_by_desc('created_at')
            ->find_one();
        
        $reseller->current_subscription = $subscription;
        
        // Calculate total revenue from this reseller
        $revenue = ORM::for_table('tbl_transactions')
            ->where('reseller_id', $reseller->id)
            ->sum('price');
        
        $reseller->total_revenue = $revenue ?: 0;
    }
    
    $ui->assign('resellers', $resellers);
    $ui->assign('search', $search);
    $ui->assign('status', $status);
    $ui->display('resellers/list.tpl');
}

function handleResellerAdd()
{
    global $ui;
    
    if (_post('save')) {
        $name = _post('name');
        $email = _post('email');
        $password = _post('password');
        $phone = _post('phone');
        $company = _post('company');
        $address = _post('address');
        $plan = _post('plan');
        $max_customers = _post('max_customers');
        $max_routers = _post('max_routers');
        $commission_rate = _post('commission_rate');
        
        // Validation
        if (empty($name) || empty($email) || empty($password)) {
            r2(getUrl('resellers/add'), 'e', 'Name, email, and password are required');
        }
        
        // Check if email already exists
        $existing = ORM::for_table('tbl_resellers')
            ->where('email', $email)
            ->find_one();
        
        if ($existing) {
            r2(getUrl('resellers/add'), 'e', 'Email already exists');
        }
        
        // Create reseller
        $reseller = ORM::for_table('tbl_resellers')->create();
        $reseller->name = $name;
        $reseller->email = $email;
        $reseller->password = password_hash($password, PASSWORD_DEFAULT);
        $reseller->phone = $phone;
        $reseller->company = $company;
        $reseller->address = $address;
        $reseller->subscription_plan = $plan;
        $reseller->max_customers = $max_customers;
        $reseller->max_routers = $max_routers;
        $reseller->commission_rate = $commission_rate;
        $reseller->status = 'active';
        $reseller->expires_at = date('Y-m-d H:i:s', strtotime('+30 days'));
        $reseller->save();
        
        // Create initial subscription
        $subscription = ORM::for_table('tbl_reseller_subscriptions')->create();
        $subscription->reseller_id = $reseller->id;
        $subscription->plan_name = $plan;
        $subscription->price = getResellerPlanPrice($plan);
        $subscription->starts_at = date('Y-m-d H:i:s');
        $subscription->expires_at = date('Y-m-d H:i:s', strtotime('+30 days'));
        $subscription->status = 'active';
        $subscription->save();
        
        r2(getUrl('resellers'), 's', 'Reseller created successfully');
    }
    
    $plans = ORM::for_table('tbl_reseller_plans')
        ->where('status', 'active')
        ->order_by_asc('price')
        ->find_many();
    
    $ui->assign('plans', $plans);
    $ui->display('resellers/add.tpl');
}

function handleResellerEdit()
{
    global $ui;
    
    $id = $routes['2'] ?? 0;
    $reseller = ORM::for_table('tbl_resellers')->find_one($id);
    
    if (!$reseller) {
        r2(getUrl('resellers'), 'e', 'Reseller not found');
    }
    
    if (_post('save')) {
        $reseller->name = _post('name');
        $reseller->phone = _post('phone');
        $reseller->company = _post('company');
        $reseller->address = _post('address');
        $reseller->subscription_plan = _post('plan');
        $reseller->max_customers = _post('max_customers');
        $reseller->max_routers = _post('max_routers');
        $reseller->commission_rate = _post('commission_rate');
        $reseller->status = _post('status');
        
        if (_post('expires_at')) {
            $reseller->expires_at = _post('expires_at');
        }
        
        $reseller->save();
        
        r2(getUrl('resellers'), 's', 'Reseller updated successfully');
    }
    
    $plans = ORM::for_table('tbl_reseller_plans')
        ->where('status', 'active')
        ->order_by_asc('price')
        ->find_many();
    
    $ui->assign('reseller', $reseller);
    $ui->assign('plans', $plans);
    $ui->display('resellers/edit.tpl');
}

function handleResellerView()
{
    global $ui;
    
    $id = $routes['2'] ?? 0;
    $reseller = ORM::for_table('tbl_resellers')->find_one($id);
    
    if (!$reseller) {
        r2(getUrl('resellers'), 'e', 'Reseller not found');
    }
    
    // Get reseller statistics
    $stats = [];
    $stats['customers'] = ORM::for_table('tbl_customers')->where('reseller_id', $id)->count();
    $stats['routers'] = ORM::for_table('tbl_routers')->where('reseller_id', $id)->count();
    $stats['active_plans'] = ORM::for_table('tbl_user_recharges')
        ->where('reseller_id', $id)
        ->where('status', 'on')
        ->count();
    
    $stats['total_revenue'] = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $id)
        ->sum('price') ?: 0;
    
    $stats['monthly_revenue'] = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $id)
        ->where_gte('recharged_on', date('Y-m-01'))
        ->sum('price') ?: 0;
    
    // Get recent transactions
    $transactions = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $id)
        ->order_by_desc('recharged_on')
        ->limit(10)
        ->find_many();
    
    // Get subscription history
    $subscriptions = ORM::for_table('tbl_reseller_subscriptions')
        ->where('reseller_id', $id)
        ->order_by_desc('created_at')
        ->find_many();
    
    $ui->assign('reseller', $reseller);
    $ui->assign('stats', $stats);
    $ui->assign('transactions', $transactions);
    $ui->assign('subscriptions', $subscriptions);
    $ui->display('resellers/view.tpl');
}

function handleResellerDelete()
{
    global $routes;
    
    $id = $routes['2'] ?? 0;
    $reseller = ORM::for_table('tbl_resellers')->find_one($id);
    
    if (!$reseller) {
        r2(getUrl('resellers'), 'e', 'Reseller not found');
    }
    
    // Check if reseller has customers
    $customers = ORM::for_table('tbl_customers')->where('reseller_id', $id)->count();
    
    if ($customers > 0) {
        r2(getUrl('resellers'), 'e', 'Cannot delete reseller with active customers');
    }
    
    $reseller->delete();
    r2(getUrl('resellers'), 's', 'Reseller deleted successfully');
}

function handleResellerPayments()
{
    global $ui;
    
    $payments = ORM::for_table('tbl_reseller_payments')
        ->select('tbl_reseller_payments.*')
        ->select('tbl_resellers.name', 'reseller_name')
        ->join('tbl_resellers', array('tbl_reseller_payments.reseller_id', '=', 'tbl_resellers.id'))
        ->order_by_desc('tbl_reseller_payments.created_at')
        ->find_many();
    
    $ui->assign('payments', $payments);
    $ui->display('resellers/payments.tpl');
}

function handleResellerPlans()
{
    global $ui;
    
    $plans = ORM::for_table('tbl_reseller_plans')
        ->order_by_asc('price')
        ->find_many();
    
    $ui->assign('plans', $plans);
    $ui->display('resellers/plans.tpl');
}

function getResellerPlanPrice($planName)
{
    $plan = ORM::for_table('tbl_reseller_plans')
        ->where('name', $planName)
        ->find_one();
    
    return $plan ? $plan->price : 0;
}