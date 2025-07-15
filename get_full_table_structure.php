<?php
/**
 * Get complete table structure for tbl_transactions
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
    
    echo "=== COMPLETE TABLE STRUCTURE FOR tbl_transactions ===\n\n";
    
    $stmt = $pdo->query("SHOW COLUMNS FROM tbl_transactions");
    $columns = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo "All columns:\n";
    foreach ($columns as $col) {
        $required = ($col['Null'] === 'NO' && $col['Default'] === null && $col['Extra'] !== 'auto_increment') ? ' [REQUIRED]' : '';
        echo "- {$col['Field']}: {$col['Type']} (Null: {$col['Null']}, Default: '{$col['Default']}', Extra: '{$col['Extra']}')$required\n";
    }
    
    echo "\n=== REQUIRED FIELDS (no default, not null, not auto_increment) ===\n";
    $required_fields = [];
    foreach ($columns as $col) {
        if ($col['Null'] === 'NO' && $col['Default'] === null && $col['Extra'] !== 'auto_increment') {
            $required_fields[] = $col['Field'];
            echo "- {$col['Field']}: {$col['Type']}\n";
        }
    }
    
    echo "\n=== SAMPLE EXISTING TRANSACTION (if any) ===\n";
    $sample = $pdo->query("SELECT * FROM tbl_transactions LIMIT 1")->fetch(PDO::FETCH_ASSOC);
    if ($sample) {
        foreach ($sample as $field => $value) {
            echo "- $field: '$value'\n";
        }
    } else {
        echo "No existing transactions found.\n";
    }
    
    echo "\n=== RECOMMENDED FIELD VALUES ===\n";
    echo "Based on the schema, here are the required fields and suggested values:\n";
    foreach ($required_fields as $field) {
        switch ($field) {
            case 'time':
                echo "- time: '24:00:00' (24 hours in HH:MM:SS format)\n";
                break;
            case 'expiration':
                echo "- expiration: date('Y-m-d H:i:s', strtotime('+24 hours'))\n";
                break;
            case 'type':
                echo "- type: 'Hotspot' (enum: Hotspot, PPPOE, Balance)\n";
                break;
            default:
                echo "- $field: [needs value]\n";
        }
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>