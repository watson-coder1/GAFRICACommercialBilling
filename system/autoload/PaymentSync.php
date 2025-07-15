<?php

/**
 * Payment Synchronization Class
 * Syncs M-Pesa portal payments to main transactions table for dashboard visibility
 */
class PaymentSync
{
    /**
     * Sync completed M-Pesa payments to main transactions table
     */
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
    
    /**
     * Update dashboard widgets to include M-Pesa payments
     */
    public static function updateDashboardWidgets()
    {
        // This function will be called to modify dashboard widgets
        // to include M-Pesa payments directly if sync approach doesn't work
        
        // For now, we'll rely on the sync approach
        return true;
    }
    
    /**
     * Add synced_to_transactions column to tbl_mpesa_transactions if it doesn't exist
     */
    public static function addSyncColumns()
    {
        try {
            // Check if column exists
            $checkQuery = "SHOW COLUMNS FROM tbl_mpesa_transactions LIKE 'synced_to_transactions'";
            $result = ORM::for_table('tbl_mpesa_transactions')->raw_query($checkQuery);
            
            if (empty($result)) {
                // Add the column
                $alterQuery = "ALTER TABLE tbl_mpesa_transactions ADD COLUMN synced_to_transactions TINYINT(1) DEFAULT NULL";
                ORM::for_table('tbl_mpesa_transactions')->raw_execute($alterQuery);
                
                $alterQuery2 = "ALTER TABLE tbl_mpesa_transactions ADD COLUMN transaction_ref INT(11) DEFAULT NULL";
                ORM::for_table('tbl_mpesa_transactions')->raw_execute($alterQuery2);
                
                self::log("SUCCESS: Added sync columns to tbl_mpesa_transactions");
                return true;
            } else {
                self::log("INFO: Sync columns already exist in tbl_mpesa_transactions");
                return true;
            }
            
        } catch (Exception $e) {
            self::log("ERROR: Failed to add sync columns - " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Run complete payment sync process
     */
    public static function runSync()
    {
        self::log("Starting payment synchronization process...");
        
        // Step 1: Add sync columns if needed
        if (!self::addSyncColumns()) {
            return false;
        }
        
        // Step 2: Sync M-Pesa payments
        $syncedCount = self::syncMpesaPayments();
        
        if ($syncedCount !== false) {
            self::log("Payment sync completed successfully. Synced: $syncedCount payments");
            return true;
        } else {
            self::log("Payment sync failed");
            return false;
        }
    }
    
    /**
     * Log messages for debugging
     */
    private static function log($message)
    {
        $logFile = 'system/uploads/payment_sync.log';
        $timestamp = date('Y-m-d H:i:s');
        file_put_contents($logFile, "[$timestamp] $message" . PHP_EOL, FILE_APPEND);
    }
}