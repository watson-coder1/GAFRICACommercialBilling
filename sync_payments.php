<?php
/**
 * Manual Payment Sync Script
 * Run this script to sync existing M-Pesa payments to the main transactions table
 */

// Bootstrap the application - use the same loading mechanism as the main app
require_once 'system/vendor/autoload.php';
require_once 'system/boot.php';

// Include our PaymentSync class
require_once 'system/autoload/PaymentSync.php';

echo "=== GLINTA AFRICA PAYMENT SYNC UTILITY ===\n";
echo "This script will sync M-Pesa payments to the main transactions table\n";
echo "for proper dashboard visibility.\n\n";

// Check if tables exist
try {
    $mpesa_count = ORM::for_table('tbl_mpesa_transactions')->count();
    echo "Found $mpesa_count M-Pesa transactions in database.\n";
} catch (Exception $e) {
    echo "ERROR: Cannot access M-Pesa transactions table: " . $e->getMessage() . "\n";
    exit(1);
}

try {
    $main_count = ORM::for_table('tbl_transactions')->count();
    echo "Found $main_count main transactions in database.\n\n";
} catch (Exception $e) {
    echo "ERROR: Cannot access main transactions table: " . $e->getMessage() . "\n";
    exit(1);
}

// Run the sync
echo "Starting payment synchronization...\n";
$result = PaymentSync::runSync();

if ($result) {
    echo "\n=== SYNC COMPLETED SUCCESSFULLY ===\n";
    
    // Show updated counts
    $completed_mpesa = ORM::for_table('tbl_mpesa_transactions')
        ->where('status', 'completed')
        ->count();
    
    $synced_mpesa = ORM::for_table('tbl_mpesa_transactions')
        ->where('status', 'completed')
        ->where_not_null('synced_to_transactions')
        ->count();
    
    $new_main_count = ORM::for_table('tbl_transactions')->count();
    
    echo "- Completed M-Pesa payments: $completed_mpesa\n";
    echo "- Synced M-Pesa payments: $synced_mpesa\n";
    echo "- Total main transactions: $new_main_count\n";
    echo "- Added transactions: " . ($new_main_count - $main_count) . "\n\n";
    
    echo "Dashboard should now show M-Pesa payments in income statistics.\n";
    echo "Check the admin dashboard to verify the payments are visible.\n";
} else {
    echo "\n=== SYNC FAILED ===\n";
    echo "Please check the payment_sync.log file for details.\n";
}

echo "\nScript completed.\n";
?>