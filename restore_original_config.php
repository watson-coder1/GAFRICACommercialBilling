<?php

/**
 * Restore Original Database Configuration
 * Fixes database connection issues by testing different configurations
 */

echo "=== RESTORING ORIGINAL DATABASE CONFIGURATION ===\n";

// Test different database configurations that might work
$test_configs = [
    'docker' => [
        'host' => 'glinta-mysql',
        'user' => 'phpnuxbill',
        'pass' => 'nuxbill2025!',
        'name' => 'phpnuxbill'
    ],
    'localhost' => [
        'host' => 'localhost',
        'user' => 'phpnuxbill',
        'pass' => 'nuxbill2025!',
        'name' => 'phpnuxbill'
    ],
    'local_ip' => [
        'host' => '127.0.0.1',
        'user' => 'phpnuxbill',
        'pass' => 'nuxbill2025!',
        'name' => 'phpnuxbill'
    ],
    'root_localhost' => [
        'host' => 'localhost',
        'user' => 'root',
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
            PDO::ATTR_TIMEOUT => 3
        ]);
        
        // Test if we can query the database
        $result = $pdo->query("SELECT COUNT(*) as count FROM tbl_admins")->fetch();
        
        if ($result['count'] > 0) {
            echo "✓ $name: Connection successful! Found admin users.\n";
            $working_config = $config;
            $working_config['name_key'] = $name;
            break;
        }
        
    } catch (PDOException $e) {
        echo "✗ $name: " . $e->getMessage() . "\n";
    }
}

if ($working_config) {
    echo "\n=== UPDATING CONFIG.PHP ===\n";
    
    // Create backup
    $backup_name = 'config.php.backup.' . date('Y-m-d-H-i-s');
    copy('config.php', $backup_name);
    echo "✓ Created backup: $backup_name\n";
    
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
    
    // Write new config
    file_put_contents('config.php', $config_content);
    
    echo "✓ Config updated successfully!\n";
    echo "✓ Using: {$working_config['host']} with user {$working_config['user']}\n";
    
    // Test the website
    echo "\n=== TESTING WEBSITE ACCESS ===\n";
    
    try {
        $url = 'http://localhost/index.php';
        $context = stream_context_create([
            'http' => [
                'timeout' => 5,
                'ignore_errors' => true
            ]
        ]);
        
        $response = @file_get_contents($url, false, $context);
        
        if ($response !== false) {
            echo "✓ Website accessible locally\n";
        } else {
            echo "⚠ Website test inconclusive\n";
        }
        
    } catch (Exception $e) {
        echo "⚠ Website test failed: " . $e->getMessage() . "\n";
    }
    
    echo "\n🎉 DATABASE CONFIGURATION RESTORED!\n";
    echo "\nYour system should now work at:\n";
    echo "- Admin: https://glintaafrica.com/admin.php (admin/glinta2025!)\n";
    echo "- Reseller: https://glintaafrica.com/reseller.php (testreseller/test123)\n";
    
} else {
    echo "\n❌ NO WORKING CONFIGURATION FOUND!\n";
    echo "Please check your database service status.\n";
    
    // Show some system info
    echo "\n=== SYSTEM DEBUG INFO ===\n";
    echo "Current directory: " . getcwd() . "\n";
    echo "PHP version: " . phpversion() . "\n";
    
    // Check if MySQL is running
    exec('systemctl is-active mysql', $mysql_output, $mysql_return);
    if ($mysql_return === 0) {
        echo "MySQL service: " . implode(' ', $mysql_output) . "\n";
    } else {
        echo "MySQL service: not running or not found\n";
    }
    
    // Check if MariaDB is running
    exec('systemctl is-active mariadb', $mariadb_output, $mariadb_return);
    if ($mariadb_return === 0) {
        echo "MariaDB service: " . implode(' ', $mariadb_output) . "\n";
    } else {
        echo "MariaDB service: not running or not found\n";
    }
}

echo "\n=== END CONFIGURATION RESTORE ===\n";

?>