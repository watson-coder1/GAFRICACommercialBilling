<?php
/**
 * Simple Reseller System Installation
 * Creates basic reseller tables without complex prepared statements
 */

// Database connection
$db_host = "127.0.0.1";
$db_user = "phpnuxbill";
$db_pass = "nuxbill2025!";
$db_name = "phpnuxbill";

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name;charset=utf8", $db_user, $db_pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true
    ]);
    
    echo "=== SIMPLE RESELLER SYSTEM INSTALLATION ===\n\n";
    
    // Step 1: Create reseller tables
    echo "1. Creating reseller tables...\n";
    
    $tables = [
        // Main resellers table
        "CREATE TABLE IF NOT EXISTS `tbl_resellers` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `name` varchar(100) NOT NULL,
            `email` varchar(100) NOT NULL UNIQUE,
            `password` varchar(255) NOT NULL,
            `phone` varchar(20) DEFAULT NULL,
            `company` varchar(150) DEFAULT NULL,
            `address` text DEFAULT NULL,
            `subscription_plan` varchar(50) DEFAULT 'starter',
            `subscription_status` enum('trial','active','suspended','expired') DEFAULT 'trial',
            `max_customers` int(11) DEFAULT 50,
            `max_routers` int(11) DEFAULT 2,
            `commission_rate` decimal(5,2) DEFAULT 0.00,
            `expires_at` datetime DEFAULT NULL,
            `last_login` datetime DEFAULT NULL,
            `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            KEY `email` (`email`),
            KEY `subscription_status` (`subscription_status`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",
        
        // Reseller subscription payments
        "CREATE TABLE IF NOT EXISTS `tbl_reseller_subscription_payments` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `reseller_id` int(11) NOT NULL,
            `amount` decimal(10,2) NOT NULL,
            `payment_date` datetime NOT NULL,
            `payment_method` varchar(50) NOT NULL,
            `transaction_reference` varchar(255) DEFAULT NULL,
            `subscription_period` varchar(20) NOT NULL,
            `extends_to` date NOT NULL,
            `status` enum('pending','completed','failed') DEFAULT 'pending',
            `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            KEY `reseller_id` (`reseller_id`),
            KEY `payment_date` (`payment_date`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",
        
        // Reseller plans
        "CREATE TABLE IF NOT EXISTS `tbl_reseller_plans` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `name` varchar(50) NOT NULL,
            `price` decimal(10,2) NOT NULL,
            `max_customers` int(11) NOT NULL,
            `max_routers` int(11) NOT NULL,
            `features` text DEFAULT NULL,
            `status` enum('active','inactive') DEFAULT 'active',
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"
    ];
    
    foreach ($tables as $sql) {
        $pdo->exec($sql);
        if (preg_match('/CREATE TABLE.*?`([^`]+)`/', $sql, $matches)) {
            echo "   ✓ Created table: {$matches[1]}\n";
        }
    }
    
    // Step 2: Add reseller_id to existing tables
    echo "\n2. Adding reseller_id columns...\n";
    
    $alterTables = [
        'tbl_customers' => 'ALTER TABLE tbl_customers ADD COLUMN reseller_id INT(11) DEFAULT 1',
        'tbl_routers' => 'ALTER TABLE tbl_routers ADD COLUMN reseller_id INT(11) DEFAULT 1',
        'tbl_user_recharges' => 'ALTER TABLE tbl_user_recharges ADD COLUMN reseller_id INT(11) DEFAULT 1',
        'tbl_plans' => 'ALTER TABLE tbl_plans ADD COLUMN reseller_id INT(11) DEFAULT 1',
        'tbl_bandwidth' => 'ALTER TABLE tbl_bandwidth ADD COLUMN reseller_id INT(11) DEFAULT 1'
    ];
    
    foreach ($alterTables as $table => $sql) {
        try {
            // Check if column exists
            $check = $pdo->query("SHOW COLUMNS FROM $table LIKE 'reseller_id'")->fetch();
            if (!$check) {
                $pdo->exec($sql);
                echo "   ✓ Added reseller_id to $table\n";
            } else {
                echo "   ✓ reseller_id already exists in $table\n";
            }
        } catch (Exception $e) {
            echo "   ✗ Could not modify $table: " . $e->getMessage() . "\n";
        }
    }
    
    // Step 3: Insert default data
    echo "\n3. Inserting default data...\n";
    
    // Insert default reseller plans
    $pdo->exec("INSERT IGNORE INTO tbl_reseller_plans (name, price, max_customers, max_routers, features) VALUES
        ('Starter', 5000.00, 50, 2, 'Basic reseller plan'),
        ('Professional', 10000.00, 200, 5, 'Professional reseller plan'),
        ('Enterprise', 25000.00, 1000, 20, 'Enterprise reseller plan')
    ");
    echo "   ✓ Inserted reseller plans\n";
    
    // Insert super admin as first reseller
    $superAdminExists = $pdo->query("SELECT COUNT(*) FROM tbl_resellers WHERE id = 1")->fetchColumn();
    if (!$superAdminExists) {
        $pdo->exec("INSERT INTO tbl_resellers (id, name, email, password, subscription_plan, subscription_status, max_customers, max_routers, expires_at) VALUES
            (1, 'Glinta Africa Super Admin', 'admin@glintaafrica.com', 'system_admin', 'unlimited', 'active', 999999, 999999, '2030-12-31 23:59:59')
        ");
        echo "   ✓ Created super admin reseller record\n";
    } else {
        echo "   ✓ Super admin reseller already exists\n";
    }
    
    // Step 4: Update existing data to belong to super admin
    echo "\n4. Updating existing records...\n";
    
    $updateTables = ['tbl_customers', 'tbl_routers', 'tbl_transactions', 'tbl_user_recharges', 'tbl_plans', 'tbl_bandwidth'];
    
    foreach ($updateTables as $table) {
        try {
            $updated = $pdo->exec("UPDATE $table SET reseller_id = 1 WHERE reseller_id IS NULL OR reseller_id = 0");
            echo "   ✓ Updated $updated records in $table\n";
        } catch (Exception $e) {
            echo "   - Skipped $table (may not exist or have reseller_id)\n";
        }
    }
    
    // Step 5: Create indexes for performance
    echo "\n5. Creating performance indexes...\n";
    
    $indexes = [
        'tbl_customers' => 'CREATE INDEX idx_customer_reseller ON tbl_customers(reseller_id)',
        'tbl_routers' => 'CREATE INDEX idx_router_reseller ON tbl_routers(reseller_id)',
        'tbl_transactions' => 'CREATE INDEX idx_transaction_reseller ON tbl_transactions(reseller_id, recharged_on)',
        'tbl_user_recharges' => 'CREATE INDEX idx_recharge_reseller ON tbl_user_recharges(reseller_id, status)'
    ];
    
    foreach ($indexes as $table => $sql) {
        try {
            $pdo->exec($sql);
            echo "   ✓ Created index on $table\n";
        } catch (Exception $e) {
            if (strpos($e->getMessage(), 'Duplicate key name') !== false) {
                echo "   ✓ Index already exists on $table\n";
            } else {
                echo "   - Skipped index on $table: " . $e->getMessage() . "\n";
            }
        }
    }
    
    echo "\n=== INSTALLATION COMPLETED SUCCESSFULLY! ===\n";
    echo "\nWhat was created:\n";
    echo "✓ Reseller management tables\n";
    echo "✓ Reseller subscription payment tracking\n"; 
    echo "✓ Reseller_id columns in existing tables\n";
    echo "✓ Performance indexes\n";
    echo "✓ Default reseller plans\n";
    echo "✓ Super admin reseller account\n";
    
    echo "\nNext steps:\n";
    echo "1. Run 'php fix_payment_sync_simple.php' to sync your KSh 20 payment\n";
    echo "2. Access admin panel to create first reseller account\n";
    echo "3. Set up reseller login system\n";
    
} catch (Exception $e) {
    echo "INSTALLATION FAILED: " . $e->getMessage() . "\n";
    exit(1);
}
?>