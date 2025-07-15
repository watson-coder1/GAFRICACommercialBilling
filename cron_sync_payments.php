<?php
/**
 * Cron Job Payment Sync Script
 * Add this to your cron jobs to run every 15 minutes:
 * */15 * * * * /usr/bin/php /path/to/your/project/cron_sync_payments.php
 */

// Bootstrap the application - use the same loading mechanism as the main app
require_once 'system/vendor/autoload.php';
require_once 'system/boot.php';

// Include our PaymentSync class
require_once 'system/autoload/PaymentSync.php';

// Run sync silently (only log errors)
try {
    $result = PaymentSync::runSync();
    
    if ($result) {
        // Log success if any payments were synced
        $logFile = 'system/uploads/payment_sync.log';
        $timestamp = date('Y-m-d H:i:s');
        file_put_contents($logFile, "[$timestamp] CRON: Payment sync completed successfully" . PHP_EOL, FILE_APPEND);
    }
} catch (Exception $e) {
    // Log error
    $logFile = 'system/uploads/payment_sync.log';
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($logFile, "[$timestamp] CRON ERROR: " . $e->getMessage() . PHP_EOL, FILE_APPEND);
}
?>