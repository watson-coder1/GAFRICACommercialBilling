<?php

/**
 * Create Missing Database Tables (Safe Version)
 * Creates missing tables without duplicating existing admin users
 */

echo "=== CREATING MISSING DATABASE TABLES (SAFE VERSION) ===\n";

try {
    $dsn = "mysql:host=127.0.0.1;dbname=phpnuxbill;charset=utf8mb4";
    $pdo = new PDO($dsn, 'phpnuxbill', 'nuxbill2025!', [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
    
    echo "✓ Database connection successful!\n\n";
    
    // Check if tbl_admins exists
    $stmt = $pdo->query("SHOW TABLES LIKE 'tbl_admins'");
    $admin_exists = $stmt->fetch();
    
    if (!$admin_exists) {
        echo "Creating tbl_admins table...\n";
        
        $admin_table = "
            CREATE TABLE `tbl_admins` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `username` varchar(50) NOT NULL,
                `password` varchar(255) NOT NULL,
                `fullname` varchar(100) NOT NULL,
                `email` varchar(100) DEFAULT NULL,
                `phone` varchar(20) DEFAULT NULL,
                `user_type` enum('SuperAdmin','Admin','Sales','Support') DEFAULT 'Admin',
                `status` enum('Active','Inactive') DEFAULT 'Active',
                `last_login` datetime DEFAULT NULL,
                `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
                `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                `reseller_id` int(11) DEFAULT NULL,
                PRIMARY KEY (`id`),
                UNIQUE KEY `username` (`username`),
                KEY `user_type` (`user_type`),
                KEY `status` (`status`),
                KEY `reseller_id` (`reseller_id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        ";
        
        $pdo->exec($admin_table);
        echo "✓ Created tbl_admins table\n";
        
        // Create the existing admin user with correct credentials
        echo "Creating existing admin user with correct credentials...\n";
        
        $existing_admin = [
            'username' => 'admin',
            'password' => password_hash('glinta2025!', PASSWORD_DEFAULT),
            'fullname' => 'System Administrator',
            'email' => 'admin@glintaafrica.com',
            'phone' => '',
            'user_type' => 'SuperAdmin',
            'status' => 'Active'
        ];
        
        $stmt = $pdo->prepare("
            INSERT INTO tbl_admins (username, password, fullname, email, phone, user_type, status) 
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ");
        
        $stmt->execute([
            $existing_admin['username'],
            $existing_admin['password'],
            $existing_admin['fullname'],
            $existing_admin['email'],
            $existing_admin['phone'],
            $existing_admin['user_type'],
            $existing_admin['status']
        ]);
        
        echo "✓ Created admin user: admin / glinta2025!\n";
        
    } else {
        echo "✓ tbl_admins already exists\n";
        
        // Check existing admin users
        $admin_count = $pdo->query("SELECT COUNT(*) FROM tbl_admins")->fetchColumn();
        echo "✓ Found $admin_count existing admin user(s)\n";
        
        if ($admin_count > 0) {
            $admins = $pdo->query("SELECT username, fullname, user_type FROM tbl_admins")->fetchAll();
            foreach ($admins as $admin) {
                echo "  - {$admin['username']} ({$admin['fullname']}) - {$admin['user_type']}\n";
            }
        }
    }
    
    // Check if tbl_users exists (for customer authentication)
    $stmt = $pdo->query("SHOW TABLES LIKE 'tbl_users'");
    $users_exists = $stmt->fetch();
    
    if (!$users_exists) {
        echo "\nCreating tbl_users table...\n";
        
        $users_table = "
            CREATE TABLE `tbl_users` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `username` varchar(50) NOT NULL,
                `password` varchar(255) NOT NULL,
                `fullname` varchar(100) NOT NULL,
                `email` varchar(100) DEFAULT NULL,
                `phonenumber` varchar(20) DEFAULT NULL,
                `address` text,
                `city` varchar(50) DEFAULT NULL,
                `country` varchar(50) DEFAULT NULL,
                `balance` decimal(10,2) DEFAULT '0.00',
                `auto_renewal` tinyint(1) DEFAULT '0',
                `status` enum('Active','Inactive') DEFAULT 'Active',
                `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
                `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                `reseller_id` int(11) DEFAULT NULL,
                PRIMARY KEY (`id`),
                UNIQUE KEY `username` (`username`),
                KEY `status` (`status`),
                KEY `reseller_id` (`reseller_id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        ";
        
        $pdo->exec($users_table);
        echo "✓ Created tbl_users table\n";
    } else {
        echo "✓ tbl_users already exists\n";
    }
    
    // Verify the reseller system components
    echo "\n=== VERIFYING RESELLER SYSTEM COMPONENTS ===\n";
    
    // Check reseller admin
    $reseller_admin_count = $pdo->query("SELECT COUNT(*) FROM tbl_reseller_admins")->fetchColumn();
    echo "✓ Found $reseller_admin_count reseller admin(s)\n";
    
    if ($reseller_admin_count > 0) {
        $reseller_admins = $pdo->query("SELECT username, fullname, reseller_id FROM tbl_reseller_admins")->fetchAll();
        foreach ($reseller_admins as $admin) {
            echo "  - {$admin['username']} ({$admin['fullname']}) - Reseller ID: {$admin['reseller_id']}\n";
        }
    }
    
    // Check resellers
    $reseller_count = $pdo->query("SELECT COUNT(*) FROM tbl_resellers")->fetchColumn();
    echo "✓ Found $reseller_count reseller(s)\n";
    
    if ($reseller_count > 0) {
        $resellers = $pdo->query("SELECT id, name, subscription_status FROM tbl_resellers")->fetchAll();
        foreach ($resellers as $reseller) {
            echo "  - {$reseller['name']} (ID: {$reseller['id']}) - Status: {$reseller['subscription_status']}\n";
        }
    }
    
    // Check widgets
    $widget_count = $pdo->query("SELECT COUNT(*) FROM tbl_widgets")->fetchColumn();
    echo "✓ Found $widget_count widget(s)\n";
    
    // Check payment tracking widget
    $payment_widget = $pdo->query("SELECT * FROM tbl_widgets WHERE widget = 'payment_tracking'")->fetch();
    if ($payment_widget) {
        echo "  - Payment tracking widget: " . ($payment_widget['enabled'] ? 'Enabled' : 'Disabled') . "\n";
    } else {
        echo "  ⚠ Payment tracking widget not found (will be installed later)\n";
    }
    
    echo "\n=== TESTING SYSTEM INITIALIZATION ===\n";
    
    // Test system initialization
    require_once 'init.php';
    
    echo "✓ System initialization successful!\n";
    
    // Test ORM
    $settings_count = ORM::for_table('tbl_settings')->count();
    echo "✓ Found $settings_count settings\n";
    
    $admin_count = ORM::for_table('tbl_admins')->count();
    echo "✓ Found $admin_count admin users\n";
    
    $reseller_orm_count = ORM::for_table('tbl_resellers')->count();
    echo "✓ Found $reseller_orm_count resellers\n";
    
    echo "\n🎉 ALL REQUIRED TABLES CREATED SUCCESSFULLY!\n";
    echo "\n=== SYSTEM READY FOR USE ===\n";
    echo "Admin Dashboard: https://glintaafrica.com/admin.php\n";
    echo "  - Username: admin\n";
    echo "  - Password: glinta2025!\n";
    echo "\nReseller Dashboard: https://glintaafrica.com/reseller.php\n";
    echo "  - Username: testreseller\n";
    echo "  - Password: test123\n";
    echo "\nYou can now run:\n";
    echo "  - php install_payment_tracking_widget.php\n";
    echo "  - php verify_reseller_system.php\n";
    
} catch (PDOException $e) {
    echo "✗ Database error: " . $e->getMessage() . "\n";
} catch (Exception $e) {
    echo "✗ System error: " . $e->getMessage() . "\n";
}

echo "\n=== END MISSING TABLES CREATOR (SAFE VERSION) ===\n";

?>