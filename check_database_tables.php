<?php

/**
 * Database Tables Checker and Fixer
 * Check for missing tables and create them if needed
 */

echo "=== DATABASE TABLES CHECKER ===\n";

try {
    $dsn = "mysql:host=127.0.0.1;dbname=phpnuxbill;charset=utf8mb4";
    $pdo = new PDO($dsn, 'phpnuxbill', 'nuxbill2025!', [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
    
    echo "✓ Database connection successful!\n\n";
    
    // Get all existing tables
    $stmt = $pdo->query("SHOW TABLES");
    $existing_tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    echo "=== EXISTING TABLES (" . count($existing_tables) . ") ===\n";
    foreach ($existing_tables as $table) {
        echo "✓ $table\n";
    }
    
    // Check for required tables
    $required_tables = [
        'tbl_settings',
        'tbl_admins',
        'tbl_resellers',
        'tbl_reseller_admins',
        'tbl_reseller_subscription_payments',
        'tbl_routers',
        'tbl_customers',
        'tbl_transactions',
        'tbl_user_recharges',
        'tbl_plans',
        'tbl_widgets',
        'tbl_logs'
    ];
    
    echo "\n=== CHECKING REQUIRED TABLES ===\n";
    $missing_tables = [];
    
    foreach ($required_tables as $table) {
        if (in_array($table, $existing_tables)) {
            echo "✓ $table exists\n";
        } else {
            echo "✗ $table MISSING\n";
            $missing_tables[] = $table;
        }
    }
    
    // Create missing tables
    if (!empty($missing_tables)) {
        echo "\n=== CREATING MISSING TABLES ===\n";
        
        $table_schemas = [
            'tbl_settings' => "
                CREATE TABLE `tbl_settings` (
                    `id` int(11) NOT NULL AUTO_INCREMENT,
                    `setting` varchar(255) NOT NULL,
                    `value` text,
                    PRIMARY KEY (`id`),
                    UNIQUE KEY `setting` (`setting`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ",
            'tbl_logs' => "
                CREATE TABLE `tbl_logs` (
                    `id` int(11) NOT NULL AUTO_INCREMENT,
                    `date` datetime NOT NULL,
                    `type` varchar(50) NOT NULL,
                    `description` text,
                    `user_id` int(11) DEFAULT NULL,
                    `ip_address` varchar(45) DEFAULT NULL,
                    PRIMARY KEY (`id`),
                    KEY `date` (`date`),
                    KEY `type` (`type`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            "
        ];
        
        foreach ($missing_tables as $table) {
            if (isset($table_schemas[$table])) {
                try {
                    $pdo->exec($table_schemas[$table]);
                    echo "✓ Created $table\n";
                } catch (PDOException $e) {
                    echo "✗ Failed to create $table: " . $e->getMessage() . "\n";
                }
            } else {
                echo "⚠ Schema for $table not defined\n";
            }
        }
        
        // Insert default settings if tbl_settings was created
        if (in_array('tbl_settings', $missing_tables)) {
            echo "\n=== INSERTING DEFAULT SETTINGS ===\n";
            
            $default_settings = [
                ['CompanyName', 'Glinta Africa'],
                ['timezone', 'Africa/Nairobi'],
                ['language', 'english'],
                ['currency_code', 'KES'],
                ['web_url', 'https://glintaafrica.com'],
                ['version', '2.0.0'],
                ['reset_day', '1']
            ];
            
            $stmt = $pdo->prepare("INSERT INTO tbl_settings (setting, value) VALUES (?, ?) ON DUPLICATE KEY UPDATE value = VALUES(value)");
            
            foreach ($default_settings as $setting) {
                try {
                    $stmt->execute($setting);
                    echo "✓ Added setting: {$setting[0]} = {$setting[1]}\n";
                } catch (PDOException $e) {
                    echo "✗ Failed to add setting {$setting[0]}: " . $e->getMessage() . "\n";
                }
            }
        }
    }
    
    echo "\n=== TESTING SYSTEM INITIALIZATION ===\n";
    
    // Test system initialization
    try {
        require_once 'init.php';
        echo "✓ System initialization successful!\n";
        
        // Test ORM
        $settings_count = ORM::for_table('tbl_settings')->count();
        echo "✓ Found $settings_count settings\n";
        
        $admin_count = ORM::for_table('tbl_admins')->count();
        echo "✓ Found $admin_count admin users\n";
        
        if ($admin_count > 0) {
            $admin = ORM::for_table('tbl_admins')->find_one();
            echo "✓ First admin: " . $admin->username . "\n";
        }
        
        $reseller_count = ORM::for_table('tbl_resellers')->count();
        echo "✓ Found $reseller_count resellers\n";
        
        if ($reseller_count > 0) {
            $reseller = ORM::for_table('tbl_resellers')->find_one();
            echo "✓ First reseller: " . $reseller->name . "\n";
        }
        
        echo "\n🎉 DATABASE IS NOW READY!\n";
        echo "You can now run:\n";
        echo "- php install_payment_tracking_widget.php\n";
        echo "- php verify_reseller_system.php\n";
        echo "- Access: https://glintaafrica.com/reseller.php\n";
        
    } catch (Exception $e) {
        echo "✗ System initialization failed: " . $e->getMessage() . "\n";
        echo "This might be normal if some tables are still missing.\n";
    }
    
} catch (PDOException $e) {
    echo "✗ Database connection failed: " . $e->getMessage() . "\n";
}

echo "\n=== END DATABASE TABLES CHECKER ===\n";

?>