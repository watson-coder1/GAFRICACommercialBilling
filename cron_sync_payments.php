<?php
/**
 * Cron Job Payment Sync Script
 * Add this to your cron jobs to run every 15 minutes:
 * */15 * * * * /usr/bin/php /path/to/your/project/cron_sync_payments.php
 */

// Include required files
require_once 'config.php';
require_once 'system/autoload/ORM.php';
require_once 'system/autoload/GUMP.php';
require_once 'system/autoload/Lang.php';
require_once 'system/autoload/PaymentSync.php';

// Initialize database
ORM::configure('mysql:host=' . $db_host . ';dbname=' . $db_name);
ORM::configure('username', $db_user);
ORM::configure('password', $db_pass);
ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));

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