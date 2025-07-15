<?php

/**
 * Reseller Subscription Management
 * Handle subscription payments and status
 */

// Ensure reseller is logged in
if (!isset($_SESSION['reseller_admin_id'])) {
    header('Location: ' . RESELLER_URL . '/login');
    exit;
}

$admin_id = $_SESSION['reseller_admin_id'];
$reseller_id = $_SESSION['reseller_id'];

$action = $routes[1] ?? 'status';

switch ($action) {
    case 'status':
        handleSubscriptionStatus();
        break;
    case 'renew':
        handleSubscriptionRenewal();
        break;
    case 'payment':
        handlePaymentProcess();
        break;
    case 'history':
        handlePaymentHistory();
        break;
    case 'invoice':
        handleInvoiceGeneration();
        break;
    default:
        handleSubscriptionStatus();
}

function handleSubscriptionStatus() {
    global $ui, $reseller_id;
    
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    // Check subscription status
    $subscriptionCheck = ResellerAuth::checkSubscription($reseller_id);
    
    // Calculate revenue for commission
    $monthlyRevenue = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', date('Y-m-01'))
        ->sum('price') ?: 0;
    
    $commission = $monthlyRevenue * 0.005; // 0.5%
    
    // Get next payment due
    $nextPaymentDue = strtotime($reseller->next_payment_due ?: $reseller->expires_at);
    $daysUntilDue = ceil(($nextPaymentDue - time()) / 86400);
    
    // Get recent payments
    $recentPayments = ORM::for_table('tbl_reseller_subscription_payments')
        ->where('reseller_id', $reseller_id)
        ->order_by_desc('id')
        ->limit(5)
        ->find_many();
    
    $ui->assign('reseller', $reseller);
    $ui->assign('subscriptionCheck', $subscriptionCheck);
    $ui->assign('monthlyRevenue', $monthlyRevenue);
    $ui->assign('commission', $commission);
    $ui->assign('daysUntilDue', $daysUntilDue);
    $ui->assign('recentPayments', $recentPayments);
    $ui->assign('_title', 'Subscription Status');
    $ui->assign('_system_menu', 'subscription');
    $ui->display('subscription/status.tpl');
}

function handleSubscriptionRenewal() {
    global $ui, $reseller_id;
    
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    // Calculate commission amount
    $monthlyRevenue = ORM::for_table('tbl_transactions')
        ->where('reseller_id', $reseller_id)
        ->where_gte('recharged_on', date('Y-m-01'))
        ->sum('price') ?: 0;
    
    $baseCommission = $monthlyRevenue * 0.005; // 0.5%
    $minimumPayment = 100; // Minimum payment in KSh
    $commissionAmount = max($baseCommission, $minimumPayment);
    
    // Subscription plans
    $plans = [
        'monthly' => [
            'name' => 'Monthly Subscription',
            'period' => 'monthly',
            'duration' => '1 Month',
            'amount' => $commissionAmount,
            'savings' => 0
        ],
        'quarterly' => [
            'name' => 'Quarterly Subscription',
            'period' => 'quarterly', 
            'duration' => '3 Months',
            'amount' => $commissionAmount * 3 * 0.9, // 10% discount
            'savings' => $commissionAmount * 3 * 0.1
        ],
        'yearly' => [
            'name' => 'Annual Subscription',
            'period' => 'yearly',
            'duration' => '12 Months', 
            'amount' => $commissionAmount * 12 * 0.8, // 20% discount
            'savings' => $commissionAmount * 12 * 0.2
        ]
    ];
    
    $ui->assign('reseller', $reseller);
    $ui->assign('plans', $plans);
    $ui->assign('monthlyRevenue', $monthlyRevenue);
    $ui->assign('commissionAmount', $commissionAmount);
    $ui->assign('_title', 'Renew Subscription');
    $ui->assign('_system_menu', 'subscription');
    $ui->display('subscription/renew.tpl');
}

function handlePaymentProcess() {
    global $reseller_id;
    
    if ($_POST) {
        $plan = $_POST['plan'] ?? 'monthly';
        $phone = $_POST['phone'] ?? '';
        
        if (empty($phone)) {
            r2(RESELLER_URL . '/subscription/renew', 'e', 'Phone number is required for M-Pesa payment');
        }
        
        // Calculate amount based on plan
        $monthlyRevenue = ORM::for_table('tbl_transactions')
            ->where('reseller_id', $reseller_id)
            ->where_gte('recharged_on', date('Y-m-01'))
            ->sum('price') ?: 0;
        
        $baseCommission = $monthlyRevenue * 0.005;
        $minimumPayment = 100;
        $baseAmount = max($baseCommission, $minimumPayment);
        
        switch ($plan) {
            case 'quarterly':
                $amount = $baseAmount * 3 * 0.9;
                break;
            case 'yearly':
                $amount = $baseAmount * 12 * 0.8;
                break;
            default:
                $amount = $baseAmount;
        }
        
        // Format phone number
        $phone = preg_replace('/[^0-9]/', '', $phone);
        if (substr($phone, 0, 1) === '0') {
            $phone = '254' . substr($phone, 1);
        } elseif (substr($phone, 0, 3) !== '254') {
            $phone = '254' . $phone;
        }
        
        // Initialize M-Pesa STK Push
        require_once 'system/paymentgateway/mpesa.php';
        
        try {
            $mpesa = new MpesaGateway();
            $mpesa->stkpush([
                'amount' => ceil($amount),
                'phone' => $phone,
                'description' => 'Reseller Subscription - ' . ucfirst($plan),
                'callback_url' => $config['web_url'] . '/callback/reseller_subscription',
                'reference' => 'RESELLER_' . $reseller_id . '_' . strtoupper($plan) . '_' . time()
            ]);
            
            // Store pending payment
            $payment = ORM::for_table('tbl_reseller_subscription_payments')->create();
            $payment->reseller_id = $reseller_id;
            $payment->amount = ceil($amount);
            $payment->subscription_period = $plan;
            $payment->payment_method = 'M-Pesa';
            $payment->phone_number = $phone;
            $payment->status = 'pending';
            $payment->created_at = date('Y-m-d H:i:s');
            $payment->save();
            
            r2(RESELLER_URL . '/subscription/status', 's', 'STK Push sent to your phone. Please complete the payment.');
            
        } catch (Exception $e) {
            r2(RESELLER_URL . '/subscription/renew', 'e', 'Payment initiation failed: ' . $e->getMessage());
        }
    }
    
    r2(RESELLER_URL . '/subscription/renew', 'e', 'Invalid payment request');
}

function handlePaymentHistory() {
    global $ui, $reseller_id;
    
    $payments = ORM::for_table('tbl_reseller_subscription_payments')
        ->where('reseller_id', $reseller_id)
        ->order_by_desc('id')
        ->find_many();
    
    $ui->assign('payments', $payments);
    $ui->assign('_title', 'Payment History');
    $ui->assign('_system_menu', 'subscription');
    $ui->display('subscription/history.tpl');
}

function handleInvoiceGeneration() {
    global $ui, $reseller_id, $routes;
    
    $payment_id = $routes[2] ?? 0;
    
    $payment = ORM::for_table('tbl_reseller_subscription_payments')
        ->where('id', $payment_id)
        ->where('reseller_id', $reseller_id)
        ->find_one();
    
    if (!$payment) {
        r2(RESELLER_URL . '/subscription/history', 'e', 'Payment not found');
    }
    
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    $ui->assign('payment', $payment);
    $ui->assign('reseller', $reseller);
    $ui->assign('_title', 'Invoice');
    $ui->display('subscription/invoice.tpl');
}