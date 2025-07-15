<?php

/**
 * Database Configuration Fixer
 * Automatically detect and fix database configuration issues
 */

echo "=== DATABASE CONFIGURATION FIXER ===\n";

// Test different database configurations
$test_configs = [
    'localhost' => [
        'host' => 'localhost',
        'user' => 'root',
        'pass' => '',
        'name' => 'phpnuxbill'
    ],
    'localhost_alt' => [
        'host' => 'localhost',
        'user' => 'phpnuxbill',
        'pass' => 'nuxbill2025!',
        'name' => 'phpnuxbill'
    ],
    'local_mysql' => [
        'host' => '127.0.0.1',
        'user' => 'phpnuxbill',
        'pass' => 'nuxbill2025!',
        'name' => 'phpnuxbill'
    ],
    'glinta_mysql' => [
        'host' => 'glinta-mysql',
        'user' => 'phpnuxbill',
        'pass' => 'nuxbill2025!',
        'name' => 'phpnuxbill'
    ]
];

$working_config = null;

foreach ($test_configs as $name => $config) {
    echo "Testing $name configuration...\n";
    
    try {
        $dsn = "mysql:host={$config['host']};dbname={$config['name']};charset=utf8mb4";
        $pdo = new PDO($dsn, $config['user'], $config['pass'], [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_TIMEOUT => 5
        ]);
        
        // Test if we can query the database
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM information_schema.tables WHERE table_schema = '{$config['name']}'");
        $result = $stmt->fetch();
        
        if ($result['count'] > 0) {
            echo "✓ $name: Connection successful! Found {$result['count']} tables.\n";
            $working_config = $config;
            $working_config['name_key'] = $name;
            break;
        } else {
            echo "⚠ $name: Connected but no tables found.\n";
        }
        
    } catch (PDOException $e) {
        echo "✗ $name: " . $e->getMessage() . "\n";
    }
}

if ($working_config) {
    echo "\n=== UPDATING CONFIG.PHP ===\n";
    
    // Read current config
    $config_content = file_get_contents('config.php');
    
    // Update database settings
    $config_content = preg_replace(
        '/\$db_host\s*=\s*"[^"]*";/',
        '$db_host    = "' . $working_config['host'] . '";',
        $config_content
    );
    
    $config_content = preg_replace(
        '/\$db_user\s*=\s*"[^"]*";/',
        '$db_user    = "' . $working_config['user'] . '";',
        $config_content
    );
    
    $config_content = preg_replace(
        '/\$db_pass\s*=\s*"[^"]*";/',
        '$db_pass    = "' . $working_config['pass'] . '";',
        $config_content
    );
    
    $config_content = preg_replace(
        '/\$db_name\s*=\s*"[^"]*";/',
        '$db_name    = "' . $working_config['name'] . '";',
        $config_content
    );
    
    // Backup original config
    copy('config.php', 'config.php.backup.' . date('Y-m-d-H-i-s'));
    
    // Write new config
    file_put_contents('config.php', $config_content);
    
    echo "✓ Config updated successfully!\n";
    echo "✓ Original config backed up\n";
    echo "✓ Using: {$working_config['host']} with user {$working_config['user']}\n";
    
    // Test the new configuration
    echo "\n=== TESTING NEW CONFIGURATION ===\n";
    
    try {
        require_once 'init.php';
        
        // Test ORM connection
        $test = ORM::for_table('tbl_settings')->limit(1)->find_one();
        echo "✓ ORM connection successful!\n";
        
        // Test admin table
        $admin_count = ORM::for_table('tbl_admins')->count();
        echo "✓ Found $admin_count admin users\n";
        
        // Test reseller table
        $reseller_count = ORM::for_table('tbl_resellers')->count();
        echo "✓ Found $reseller_count resellers\n";
        
        echo "\n🎉 DATABASE CONFIGURATION FIXED!\n";
        echo "You can now run:\n";
        echo "- php install_payment_tracking_widget.php\n";
        echo "- php verify_reseller_system.php\n";
        
    } catch (Exception $e) {
        echo "✗ Error testing new configuration: " . $e->getMessage() . "\n";
    }
    
} else {
    echo "\n❌ NO WORKING DATABASE CONFIGURATION FOUND!\n";
    echo "Please check:\n";
    echo "1. Is MySQL/MariaDB running?\n";
    echo "2. Are the database credentials correct?\n";
    echo "3. Does the database exist?\n";
    echo "4. Are you running this on the correct server?\n";
    
    // Show some debugging info
    echo "\n=== DEBUG INFO ===\n";
    echo "Current directory: " . getcwd() . "\n";
    echo "Config file exists: " . (file_exists('config.php') ? 'Yes' : 'No') . "\n";
    echo "Init file exists: " . (file_exists('init.php') ? 'Yes' : 'No') . "\n";
    
    // Check if we can connect to any database at all
    echo "\n=== CHECKING DATABASE SERVICES ===\n";
    
    $services = [
        'mysql' => 3306,
        'mariadb' => 3306,
        'postgresql' => 5432
    ];
    
    foreach ($services as $service => $port) {
        $connection = @fsockopen('localhost', $port, $errno, $errstr, 1);
        if ($connection) {
            echo "✓ $service appears to be running on port $port\n";
            fclose($connection);
        } else {
            echo "✗ $service not responding on port $port\n";
        }
    }
}

echo "\n=== END DATABASE CONFIGURATION FIXER ===\n";

?>