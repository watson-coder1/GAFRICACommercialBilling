<?php
/**
 * Add reseller_id field to M-Pesa transactions table
 */

// Database connection
$db_host = "127.0.0.1";
$db_user = "phpnuxbill";
$db_pass = "nuxbill2025!";
$db_name = "phpnuxbill";

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name;charset=utf8", $db_user, $db_pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);
    
    echo "=== ADDING RESELLER_ID TO M-PESA TRANSACTIONS ===\n\n";
    
    // Check if reseller_id column exists
    $check = $pdo->query("SHOW COLUMNS FROM tbl_mpesa_transactions LIKE 'reseller_id'")->fetch();
    
    if (!$check) {
        // Add reseller_id column
        $pdo->exec("ALTER TABLE tbl_mpesa_transactions ADD COLUMN reseller_id INT(11) DEFAULT 1");
        echo "✓ Added reseller_id column to tbl_mpesa_transactions\n";
        
        // Create index for performance
        $pdo->exec("CREATE INDEX idx_mpesa_reseller ON tbl_mpesa_transactions(reseller_id)");
        echo "✓ Created index for reseller_id\n";
        
        // Update existing records to belong to system admin
        $updated = $pdo->exec("UPDATE tbl_mpesa_transactions SET reseller_id = 1 WHERE reseller_id IS NULL");
        echo "✓ Updated $updated existing M-Pesa transactions to belong to system admin\n";
        
    } else {
        echo "✓ reseller_id column already exists in tbl_mpesa_transactions\n";
    }
    
    // Verify the structure
    echo "\nTable structure verification:\n";
    $columns = $pdo->query("SHOW COLUMNS FROM tbl_mpesa_transactions")->fetchAll();
    foreach ($columns as $column) {
        if ($column['Field'] == 'reseller_id') {
            echo "✓ reseller_id: {$column['Type']} (Default: {$column['Default']})\n";
        }
    }
    
    echo "\nSUCCESS: M-Pesa transactions table updated for multi-tenancy support!\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
    exit(1);
}
?>