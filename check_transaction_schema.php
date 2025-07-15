<?php
/**
 * Check transaction table schema
 */

// Database connection
$db_host = "127.0.0.1";
$db_user = "phpnuxbill";
$db_pass = "nuxbill2025!";
$db_name = "phpnuxbill";

require_once 'system/orm.php';

ORM::configure('mysql:host=' . $db_host . ';dbname=' . $db_name);
ORM::configure('username', $db_user);
ORM::configure('password', $db_pass);
ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));

echo "=== TRANSACTION TABLE SCHEMA CHECK ===\n\n";

// Check table structure
$columns = ORM::for_table('tbl_transactions')->raw_query("SHOW COLUMNS FROM tbl_transactions");

echo "Table columns:\n";
foreach ($columns as $column) {
    echo "- {$column['Field']}: {$column['Type']} ({$column['Null']}, Default: {$column['Default']})\n";
}

echo "\n=== SAMPLE EXISTING TRANSACTIONS ===\n";
$existing = ORM::for_table('tbl_transactions')->limit(3)->find_many();
if ($existing) {
    foreach ($existing as $trans) {
        echo "Sample transaction:\n";
        echo "- ID: {$trans->id}\n";
        echo "- Invoice: {$trans->invoice}\n";
        echo "- Username: {$trans->username}\n";
        echo "- Type: '{$trans->type}'\n";
        echo "- Method: '{$trans->method}'\n";
        echo "- Price: {$trans->price}\n\n";
    }
} else {
    echo "No existing transactions found.\n";
}

echo "\n=== SAMPLE M-PESA TRANSACTIONS ===\n";
$mpesa = ORM::for_table('tbl_mpesa_transactions')->limit(3)->find_many();
foreach ($mpesa as $m) {
    echo "M-Pesa transaction {$m->id}:\n";
    echo "- Session ID: {$m->session_id}\n";
    echo "- Phone: {$m->phone_number}\n";
    echo "- Amount: {$m->amount}\n";
    echo "- Status: {$m->status}\n";
    echo "- Created: {$m->created_at}\n";
    
    // Check if portal session exists
    $session = ORM::for_table('tbl_portal_sessions')
        ->where('session_id', $m->session_id)
        ->find_one();
    
    if ($session) {
        echo "- Portal session: EXISTS (Package ID: {$session->package_id})\n";
    } else {
        echo "- Portal session: NOT FOUND\n";
    }
    echo "\n";
}

echo "=== HOTSPOT PACKAGES ===\n";
$packages = ORM::for_table('tbl_hotspot_packages')->find_many();
foreach ($packages as $pkg) {
    echo "Package {$pkg->id}: {$pkg->name} - KSh {$pkg->price}\n";
}
?>