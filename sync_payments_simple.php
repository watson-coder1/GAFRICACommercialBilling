<?php
/**
 * Simple Payment Sync Script
 * Just syncs M-Pesa payments to main transactions table without column modifications
 */

// Database connection
$db_host = "127.0.0.1";
$db_user = "phpnuxbill";
$db_pass = "nuxbill2025!";
$db_name = "phpnuxbill";

// Minimal ORM setup
require_once 'system/orm.php';

// Configure database connection
ORM::configure('mysql:host=' . $db_host . ';dbname=' . $db_name);
ORM::configure('username', $db_user);
ORM::configure('password', $db_pass);
ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));

echo "=== SIMPLE M-PESA PAYMENT SYNC ===\n\n";

// Check current state
$mpesa_completed = ORM::for_table('tbl_mpesa_transactions')
    ->where('status', 'completed')
    ->count();

$main_transactions = ORM::for_table('tbl_transactions')->count();

echo "Completed M-Pesa payments: $mpesa_completed\n";
echo "Main transactions: $main_transactions\n\n";

// Get all completed M-Pesa payments
$mpesaPayments = ORM::for_table('tbl_mpesa_transactions')
    ->where('status', 'completed')
    ->find_many();

$syncedCount = 0;

echo "Starting sync process...\n";

foreach ($mpesaPayments as $mpesaPayment) {
    // Check if this payment is already synced by looking for existing transaction
    $existingTransaction = ORM::for_table('tbl_transactions')
        ->where('invoice', 'MPESA-' . $mpesaPayment->id)
        ->find_one();
    
    if ($existingTransaction) {
        echo "- Payment {$mpesaPayment->id} already synced (transaction {$existingTransaction->id})\n";
        continue;
    }
    
    // Skip payments without session_id
    if (empty($mpesaPayment->session_id)) {
        echo "- Payment {$mpesaPayment->id} skipped (no session_id)\n";
        continue;
    }
    
    // Get the corresponding portal session for package info
    $portalSession = ORM::for_table('tbl_portal_sessions')
        ->where('session_id', $mpesaPayment->session_id)
        ->find_one();
    
    if ($portalSession) {
        // Get package information
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $portalSession->package_id)
            ->find_one();
        
        $packageName = $package ? $package->name : 'Unknown Package';
        
        // Create transaction record in main transactions table
        $transaction = ORM::for_table('tbl_transactions')->create();
        $transaction->invoice = 'MPESA-' . $mpesaPayment->id;
        $transaction->username = $mpesaPayment->phone_number;
        $transaction->plan_name = $packageName;
        $transaction->price = $mpesaPayment->amount;
        $transaction->recharged_on = date('Y-m-d', strtotime($mpesaPayment->created_at));
        $transaction->recharged_time = date('Y-m-d H:i:s', strtotime($mpesaPayment->created_at));
        $transaction->method = 'M-Pesa STK Push';
        $transaction->routers = 'Hotspot Portal';
        $transaction->admin_id = 1; // System admin
        
        // Try the correct enum values for type column
        $typeValues = ['Hotspot', 'PPPOE', 'Balance'];
        $saved = false;
        
        foreach ($typeValues as $typeValue) {
            try {
                $transaction->type = $typeValue;
                $transaction->save();
                $syncedCount++;
                echo "✓ Synced payment {$mpesaPayment->id} -> transaction {$transaction->id} (KSh {$mpesaPayment->amount}) [type: '$typeValue']\n";
                $saved = true;
                break;
            } catch (Exception $e) {
                // Try next type value
                continue;
            }
        }
        
        if (!$saved) {
            echo "✗ Failed to sync payment {$mpesaPayment->id}: All type values failed\n";
        }
    } else {
        echo "- Payment {$mpesaPayment->id} skipped (no portal session for session_id: {$mpesaPayment->session_id})\n";
    }
}

echo "\n=== SYNC COMPLETED ===\n";
echo "Total M-Pesa payments synced: $syncedCount\n";

// Show final counts
$new_main_count = ORM::for_table('tbl_transactions')->count();
echo "Main transactions after sync: $new_main_count\n";
echo "Added transactions: " . ($new_main_count - $main_transactions) . "\n\n";

if ($syncedCount > 0) {
    echo "SUCCESS: Dashboard should now show M-Pesa payments in income statistics!\n";
} else {
    echo "INFO: No new payments to sync. All payments may already be synchronized.\n";
}

echo "Script completed.\n";
?>