<?php
/**
 * M-Pesa Database Tables Installation Script
 * Run this file once to create M-Pesa tables
 */

// Include the application configuration
require_once 'config.php';
require_once 'system/boot.php';

echo "Installing M-Pesa Database Tables...\n\n";

try {
    // Read SQL file
    $sql_content = file_get_contents('mpesa_tables.sql');
    
    if (!$sql_content) {
        die("Error: Could not read mpesa_tables.sql file\n");
    }
    
    // Split SQL into individual statements
    $statements = explode(';', $sql_content);
    
    $success_count = 0;
    $error_count = 0;
    
    foreach ($statements as $statement) {
        $statement = trim($statement);
        
        // Skip empty statements and comments
        if (empty($statement) || strpos($statement, '--') === 0) {
            continue;
        }
        
        try {
            // Execute the statement using the application's database connection
            $result = ORM::raw_execute($statement);
            
            if (strpos($statement, 'CREATE TABLE') !== false) {
                preg_match('/CREATE TABLE.*?`([^`]+)`/', $statement, $matches);
                $table_name = $matches[1] ?? 'unknown';
                echo "✓ Created table: $table_name\n";
            } elseif (strpos($statement, 'INSERT') !== false) {
                preg_match('/INSERT.*?INTO.*?`([^`]+)`/', $statement, $matches);
                $table_name = $matches[1] ?? 'unknown';
                echo "✓ Inserted data into: $table_name\n";
            }
            
            $success_count++;
            
        } catch (Exception $e) {
            echo "✗ Error executing statement: " . $e->getMessage() . "\n";
            echo "Statement: " . substr($statement, 0, 100) . "...\n\n";
            $error_count++;
        }
    }
    
    echo "\n=== Installation Summary ===\n";
    echo "Successful operations: $success_count\n";
    echo "Failed operations: $error_count\n";
    
    if ($error_count == 0) {
        echo "\n🎉 M-Pesa tables installed successfully!\n";
        echo "You can now configure M-Pesa settings in Admin → Settings → Miscellaneous\n";
    } else {
        echo "\n⚠️  Installation completed with some errors. Please check the output above.\n";
    }
    
    // Test if tables were created
    echo "\n=== Verifying Tables ===\n";
    
    $tables_to_check = [
        'tbl_mpesa_transactions',
        'tbl_portal_sessions', 
        'tbl_hotspot_packages'
    ];
    
    foreach ($tables_to_check as $table) {
        try {
            $result = ORM::raw_execute("SHOW TABLES LIKE '$table'");
            if ($result) {
                echo "✓ Table $table exists\n";
            } else {
                echo "✗ Table $table not found\n";
            }
        } catch (Exception $e) {
            echo "✗ Error checking table $table: " . $e->getMessage() . "\n";
        }
    }
    
} catch (Exception $e) {
    echo "Fatal error: " . $e->getMessage() . "\n";
    exit(1);
}

echo "\n✅ Installation script completed.\n";
echo "You can now delete this file: rm install_mpesa_tables.php\n";
?>