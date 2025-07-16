<?php
/**
 * Direct cleanup with hardcoded database connection
 */

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "Direct cleanup script...\n";

try {
    // Direct database connection
    $db_host = 'glinta-mysql';
    $db_name = 'phpnuxbill';
    $db_user = 'phpnuxbill';
    $db_pass = 'nuxbill2025!';
    
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "Database connected successfully\n\n";
    
    // Count fake customers
    $stmt = $pdo->query("SELECT COUNT(*) FROM tbl_customers WHERE username LIKE 'testcustomer%'");
    $fake_count = $stmt->fetchColumn();
    echo "Found $fake_count fake customers\n";
    
    if ($fake_count > 0) {
        // Show fake customers
        $stmt = $pdo->query("SELECT username FROM tbl_customers WHERE username LIKE 'testcustomer%'");
        $customers = $stmt->fetchAll(PDO::FETCH_COLUMN);
        echo "Fake customers: " . implode(', ', $customers) . "\n\n";
        
        // Delete fake customers
        echo "Deleting fake customers...\n";
        $stmt = $pdo->exec("DELETE FROM tbl_customers WHERE username LIKE 'testcustomer%'");
        echo "Deleted customers\n";
        
        // Delete fake transactions
        echo "Deleting fake transactions...\n";
        $stmt = $pdo->query("SELECT COUNT(*) FROM tbl_transactions WHERE username LIKE 'testcustomer%'");
        $trans_count = $stmt->fetchColumn();
        echo "Found $trans_count fake transactions\n";
        
        $stmt = $pdo->exec("DELETE FROM tbl_transactions WHERE username LIKE 'testcustomer%'");
        echo "Deleted transactions\n";
        
        // Delete fake recharges
        echo "Deleting fake recharges...\n";
        $stmt = $pdo->query("SELECT COUNT(*) FROM tbl_user_recharges WHERE username LIKE 'testcustomer%'");
        $recharge_count = $stmt->fetchColumn();
        echo "Found $recharge_count fake recharges\n";
        
        $stmt = $pdo->exec("DELETE FROM tbl_user_recharges WHERE username LIKE 'testcustomer%'");
        echo "Deleted recharges\n";
        
        // Delete Test Package plans
        echo "\nDeleting Test Package plans...\n";
        $stmt = $pdo->query("SELECT COUNT(*) FROM tbl_plans WHERE name_plan LIKE 'Test Package%'");
        $plan_count = $stmt->fetchColumn();
        echo "Found $plan_count test plans\n";
        
        $stmt = $pdo->exec("DELETE FROM tbl_plans WHERE name_plan LIKE 'Test Package%'");
        echo "Deleted test plans\n";
    }
    
    // Show final counts
    echo "\nFINAL COUNTS:\n";
    $stmt = $pdo->query("SELECT COUNT(*) FROM tbl_customers");
    echo "Total customers: " . $stmt->fetchColumn() . "\n";
    
    $stmt = $pdo->query("SELECT COUNT(*) FROM tbl_transactions");
    echo "Total transactions: " . $stmt->fetchColumn() . "\n";
    
    $stmt = $pdo->query("SELECT SUM(price) FROM tbl_transactions");
    $revenue = $stmt->fetchColumn();
    echo "Total revenue: KES " . number_format($revenue ?: 0, 2) . "\n";
    
    echo "\n✅ Cleanup complete!\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
?>