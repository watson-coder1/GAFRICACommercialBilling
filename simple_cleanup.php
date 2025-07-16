<?php
/**
 * Simple cleanup script with better error handling
 */

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "Starting cleanup script...\n";

try {
    require_once 'config.php';
    echo "Config loaded\n";
    
    require_once 'system/orm.php';
    echo "ORM loaded\n";
    
    // Test database connection
    echo "Testing database connection...\n";
    $test = ORM::for_table('tbl_customers')->find_one();
    echo "Database connection OK\n\n";
    
    // Count fake customers
    echo "Counting fake test customers...\n";
    $fake_count = ORM::for_table('tbl_customers')
        ->where_like('username', 'testcustomer%')
        ->count();
    echo "Found $fake_count fake customers\n";
    
    if ($fake_count > 0) {
        // Delete fake customers
        echo "Deleting fake customers...\n";
        $deleted = ORM::for_table('tbl_customers')
            ->where_like('username', 'testcustomer%')
            ->delete_many();
        echo "Deleted customers\n";
        
        // Delete fake transactions
        echo "Deleting fake transactions...\n";
        $deleted = ORM::for_table('tbl_transactions')
            ->where_like('username', 'testcustomer%')
            ->delete_many();
        echo "Deleted transactions\n";
        
        // Delete fake recharges
        echo "Deleting fake recharges...\n";
        $deleted = ORM::for_table('tbl_user_recharges')
            ->where_like('username', 'testcustomer%')
            ->delete_many();
        echo "Deleted recharges\n";
    }
    
    echo "\nCleanup complete!\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "File: " . $e->getFile() . "\n";
    echo "Line: " . $e->getLine() . "\n";
}
?>