<?php
/**
 * Verify Database Connection Script
 * Check if we're connecting to the same database as the web application
 */

echo "=== DATABASE VERIFICATION ===\n\n";

// Test different database hosts
$hosts_to_test = [
    'localhost',
    '127.0.0.1',
    'glinta-mysql',
    'mysql',
    'db-mysql-fra1-01'
];

$db_user = "phpnuxbill";
$db_pass = "nuxbill2025!";
$db_name = "phpnuxbill";

foreach ($hosts_to_test as $host) {
    echo "Testing host: $host\n";
    
    try {
        $dsn = "mysql:host=$host;dbname=$db_name;charset=utf8";
        $pdo = new PDO($dsn, $db_user, $db_pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_TIMEOUT => 5
        ]);
        
        // Check if this database has the same data as expected
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM tbl_mpesa_transactions WHERE status='completed'");
        $mpesa_count = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
        
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM tbl_transactions");
        $trans_count = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
        
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM tbl_portal_sessions");
        $portal_count = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
        
        echo "✓ SUCCESS: Connected to $host\n";
        echo "  - M-Pesa transactions: $mpesa_count\n";
        echo "  - Main transactions: $trans_count\n";
        echo "  - Portal sessions: $portal_count\n";
        
        // Check recent M-Pesa payment
        $stmt = $pdo->query("SELECT phone_number, amount, created_at FROM tbl_mpesa_transactions WHERE status='completed' ORDER BY created_at DESC LIMIT 1");
        $recent = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($recent) {
            echo "  - Recent M-Pesa: {$recent['phone_number']} - KSh {$recent['amount']} on {$recent['created_at']}\n";
        }
        
        // Check table structure for 'type' column
        $stmt = $pdo->query("SHOW COLUMNS FROM tbl_transactions LIKE 'type'");
        $typeCol = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($typeCol) {
            echo "  - Type column: {$typeCol['Type']} (Null: {$typeCol['Null']}, Default: {$typeCol['Default']})\n";
        }
        
        echo "\n";
        
    } catch (Exception $e) {
        echo "✗ FAILED: " . $e->getMessage() . "\n\n";
    }
}

echo "=== RECOMMENDATION ===\n";
echo "Use the host that shows the same M-Pesa transaction count (16) as your web application.\n";
echo "If multiple hosts work, use the one that matches your web application's database.\n";
?>