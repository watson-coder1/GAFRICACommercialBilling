<?php
/**
 * Database Host Detection Script
 * This script helps identify the correct database host for your environment
 */

echo "=== DATABASE HOST DETECTION ===\n\n";

// Check if we're in a Docker environment
if (file_exists('/.dockerenv')) {
    echo "Docker environment detected.\n";
    $in_docker = true;
} else {
    echo "Not in Docker environment.\n";
    $in_docker = false;
}

// Try different database hosts
$possible_hosts = [
    'localhost',
    '127.0.0.1',
    'glinta-mysql',
    'mysql',
    'db'
];

$db_user = "phpnuxbill";
$db_pass = "nuxbill2025!";
$db_name = "phpnuxbill";

echo "Trying different database hosts...\n\n";

foreach ($possible_hosts as $host) {
    echo "Testing connection to: $host\n";
    
    try {
        $dsn = "mysql:host=$host;dbname=$db_name;charset=utf8";
        $pdo = new PDO($dsn, $db_user, $db_pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_TIMEOUT => 5
        ]);
        
        // Test query
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM tbl_transactions");
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        echo "✓ SUCCESS: Connected to $host\n";
        echo "  - Found {$result['count']} transactions in database\n";
        
        // Test M-Pesa table
        try {
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM tbl_mpesa_transactions");
            $mpesa_result = $stmt->fetch(PDO::FETCH_ASSOC);
            echo "  - Found {$mpesa_result['count']} M-Pesa transactions\n";
        } catch (Exception $e) {
            echo "  - M-Pesa table not found or error: " . $e->getMessage() . "\n";
        }
        
        echo "\n** USE THIS HOST: $host **\n\n";
        
        // Generate the correct sync script
        echo "To fix the sync script, edit sync_payments_standalone.php and change:\n";
        echo "\$db_host = \"localhost\";\n";
        echo "to:\n";
        echo "\$db_host = \"$host\";\n\n";
        
        exit(0);
        
    } catch (Exception $e) {
        echo "✗ FAILED: " . $e->getMessage() . "\n\n";
    }
}

echo "No working database host found. Please check:\n";
echo "1. MySQL service is running\n";
echo "2. Database credentials are correct\n";
echo "3. Database name 'phpnuxbill' exists\n";
echo "4. User 'phpnuxbill' has access to the database\n";
?>