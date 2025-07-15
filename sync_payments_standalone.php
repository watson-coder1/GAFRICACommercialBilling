<?php
/**
 * Standalone Payment Sync Script
 * This version can run outside Docker containers
 */

// Direct database connection for standalone use
// Updated to use the correct database host
$db_host = "127.0.0.1"; // Digital Ocean database host
$db_port = "3306";
$db_user = "phpnuxbill";
$db_pass = "nuxbill2025!";
$db_name = "phpnuxbill";

// Auto-detect database host from environment or use localhost as fallback
if (isset($_ENV['DB_HOST']) && !empty($_ENV['DB_HOST'])) {
    $db_host = $_ENV['DB_HOST'];
} elseif (file_exists('/etc/hostname')) {
    // On Digital Ocean, try to use the internal database if available
    $hostname = trim(file_get_contents('/etc/hostname'));
    if (strpos($hostname, 'mysql') !== false || strpos($hostname, 'db') !== false) {
        $db_host = $hostname;
    }
}

// Minimal ORM setup
require_once 'system/orm.php';

// Configure database connection
ORM::configure('mysql:host=' . $db_host . ';dbname=' . $db_name);
ORM::configure('username', $db_user);
ORM::configure('password', $db_pass);
ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));

// Simple PaymentSync class implementation
class PaymentSync
{
    public static function syncMpesaPayments()
    {
        try {
            // Get all completed M-Pesa payments that haven't been synced yet
            $mpesaPayments = ORM::for_table('tbl_mpesa_transactions')
                ->where('status', 'completed')
                ->where_null('synced_to_transactions')
                ->find_many();
            
            $syncedCount = 0;
            
            foreach ($mpesaPayments as $mpesaPayment) {
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
                    $transaction->type = 'Credit';
                    $transaction->admin_id = 1; // System admin
                    $transaction->save();
                    
                    // Mark M-Pesa payment as synced
                    $mpesaPayment->synced_to_transactions = 1;
                    $mpesaPayment->transaction_ref = $transaction->id;
                    $mpesaPayment->save();
                    
                    $syncedCount++;
                    
                    self::log("SYNC: M-Pesa payment {$mpesaPayment->id} synced to transaction {$transaction->id}");
                } else {
                    self::log("ERROR: No portal session found for M-Pesa payment {$mpesaPayment->id}");
                }
            }
            
            if ($syncedCount > 0) {
                self::log("SUCCESS: Synced $syncedCount M-Pesa payments to main transactions table");
            }
            
            return $syncedCount;
            
        } catch (Exception $e) {
            self::log("ERROR: Payment sync failed - " . $e->getMessage());
            return false;
        }
    }
    
    public static function addSyncColumns()
    {
        try {
            // Add sync columns if they don't exist
            $alterQuery = "ALTER TABLE tbl_mpesa_transactions ADD COLUMN IF NOT EXISTS synced_to_transactions TINYINT(1) DEFAULT NULL";
            ORM::for_table('tbl_mpesa_transactions')->raw_execute($alterQuery);
            
            $alterQuery2 = "ALTER TABLE tbl_mpesa_transactions ADD COLUMN IF NOT EXISTS transaction_ref INT(11) DEFAULT NULL";
            ORM::for_table('tbl_mpesa_transactions')->raw_execute($alterQuery2);
            
            self::log("SUCCESS: Added sync columns to tbl_mpesa_transactions");
            return true;
            
        } catch (Exception $e) {
            self::log("INFO: Sync columns may already exist - " . $e->getMessage());
            return true; // Continue even if columns exist
        }
    }
    
    public static function runSync()
    {
        self::log("Starting payment synchronization process...");
        
        // Step 1: Add sync columns if needed
        self::addSyncColumns();
        
        // Step 2: Sync M-Pesa payments
        $syncedCount = self::syncMpesaPayments();
        
        if ($syncedCount !== false) {
            self::log("Payment sync completed successfully. Synced: $syncedCount payments");
            return $syncedCount;
        } else {
            self::log("Payment sync failed");
            return false;
        }
    }
    
    private static function log($message)
    {
        echo "[" . date('Y-m-d H:i:s') . "] $message\n";
    }
}

echo "=== GLINTA AFRICA PAYMENT SYNC UTILITY (Standalone) ===\n";
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

// Check for completed M-Pesa payments
try {
    $completed_mpesa = ORM::for_table('tbl_mpesa_transactions')
        ->where('status', 'completed')
        ->count();
    
    $unsynced_mpesa = ORM::for_table('tbl_mpesa_transactions')
        ->where('status', 'completed')
        ->where_null('synced_to_transactions')
        ->count();
    
    echo "Completed M-Pesa payments: $completed_mpesa\n";
    echo "Unsynced M-Pesa payments: $unsynced_mpesa\n\n";
    
    if ($unsynced_mpesa == 0) {
        echo "No M-Pesa payments to sync. All payments are already synchronized.\n";
        exit(0);
    }
    
} catch (Exception $e) {
    echo "ERROR checking M-Pesa payments: " . $e->getMessage() . "\n";
    exit(1);
}

// Run the sync
echo "Starting payment synchronization...\n";
$result = PaymentSync::runSync();

if ($result !== false) {
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
    echo "Please check the error messages above for details.\n";
}

echo "\nScript completed.\n";
?>