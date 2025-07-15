<?php
// Quick payment check script
require_once 'config.php';
require_once 'system/autoload/ORM.php';
require_once 'system/autoload/GUMP.php';
require_once 'system/autoload/Lang.php';

// Initialize database
ORM::configure('mysql:host=' . $db_host . ';dbname=' . $db_name);
ORM::configure('username', $db_user);
ORM::configure('password', $db_pass);
ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));

echo "=== PAYMENT DATA ANALYSIS ===\n\n";

// Check M-Pesa transactions
try {
    $mpesa_total = ORM::for_table('tbl_mpesa_transactions')
        ->where('status', 'completed')
        ->count();
    
    $mpesa_amount = ORM::for_table('tbl_mpesa_transactions')
        ->where('status', 'completed')
        ->sum('amount');
    
    echo "M-Pesa Transactions (tbl_mpesa_transactions):\n";
    echo "- Completed payments: $mpesa_total\n";
    echo "- Total amount: KSh " . number_format($mpesa_amount, 2) . "\n\n";
    
    // Recent M-Pesa payments
    $recent_mpesa = ORM::for_table('tbl_mpesa_transactions')
        ->where('status', 'completed')
        ->order_by_desc('created_at')
        ->limit(5)
        ->find_many();
    
    echo "Recent M-Pesa Payments:\n";
    foreach ($recent_mpesa as $payment) {
        echo "- {$payment->created_at}: KSh {$payment->amount} ({$payment->phone_number})\n";
    }
    echo "\n";
    
} catch (Exception $e) {
    echo "M-Pesa table error: " . $e->getMessage() . "\n\n";
}

// Check portal sessions
try {
    $portal_total = ORM::for_table('tbl_portal_sessions')
        ->where('payment_status', 'completed')
        ->count();
    
    echo "Portal Sessions (tbl_portal_sessions):\n";
    echo "- Completed sessions: $portal_total\n";
    
    // Recent portal sessions
    $recent_portal = ORM::for_table('tbl_portal_sessions')
        ->where('payment_status', 'completed')
        ->order_by_desc('created_at')
        ->limit(5)
        ->find_many();
    
    echo "Recent Portal Sessions:\n";
    foreach ($recent_portal as $session) {
        echo "- {$session->created_at}: {$session->phone_number} (Package: {$session->package_id})\n";
    }
    echo "\n";
    
} catch (Exception $e) {
    echo "Portal sessions table error: " . $e->getMessage() . "\n\n";
}

// Check main transactions
try {
    $main_total = ORM::for_table('tbl_transactions')->count();
    $main_amount = ORM::for_table('tbl_transactions')->sum('price');
    
    echo "Main Transactions (tbl_transactions):\n";
    echo "- Total transactions: $main_total\n";
    echo "- Total amount: KSh " . number_format($main_amount, 2) . "\n\n";
    
    // Recent main transactions
    $recent_main = ORM::for_table('tbl_transactions')
        ->order_by_desc('recharged_on')
        ->limit(5)
        ->find_many();
    
    echo "Recent Main Transactions:\n";
    foreach ($recent_main as $transaction) {
        echo "- {$transaction->recharged_on}: KSh {$transaction->price} ({$transaction->method})\n";
    }
    echo "\n";
    
} catch (Exception $e) {
    echo "Main transactions table error: " . $e->getMessage() . "\n\n";
}

echo "=== DASHBOARD ISSUE ANALYSIS ===\n\n";

// Check what dashboard widgets are trying to query
echo "Dashboard queries tbl_transactions table for:\n";
echo "- Daily income: SUM(price) WHERE recharged_on = today\n";
echo "- Monthly income: SUM(price) WHERE recharged_on >= start_of_month\n\n";

echo "Issue: M-Pesa payments are in tbl_mpesa_transactions, not tbl_transactions\n";
echo "Solution: Need to sync M-Pesa payments to tbl_transactions OR modify dashboard widgets\n";
?>