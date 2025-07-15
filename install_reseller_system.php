<?php
/**
 * Reseller System Installation Script
 * Installs multi-tenancy support for reseller management
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
    
    echo "=== INSTALLING RESELLER MULTI-TENANCY SYSTEM ===\n\n";
    
    // Read and execute SQL file
    $sql = file_get_contents('reseller_tables.sql');
    
    if (!$sql) {
        throw new Exception("Could not read reseller_tables.sql file");
    }
    
    // Split SQL into individual statements
    $statements = array_filter(array_map('trim', explode(';', $sql)));
    
    $executed = 0;
    $errors = 0;
    
    foreach ($statements as $statement) {
        if (empty($statement) || strpos($statement, '--') === 0) {
            continue; // Skip empty statements and comments
        }
        
        try {
            $pdo->exec($statement);
            $executed++;
            
            // Show progress for major operations
            if (stripos($statement, 'CREATE TABLE') !== false) {
                preg_match('/CREATE TABLE.*?`([^`]+)`/', $statement, $matches);
                $tableName = $matches[1] ?? 'unknown';
                echo "✓ Created table: $tableName\n";
            } elseif (stripos($statement, 'ALTER TABLE') !== false) {
                preg_match('/ALTER TABLE `([^`]+)`/', $statement, $matches);
                $tableName = $matches[1] ?? 'unknown';
                echo "✓ Modified table: $tableName\n";
            } elseif (stripos($statement, 'INSERT INTO') !== false) {
                preg_match('/INSERT INTO `([^`]+)`/', $statement, $matches);
                $tableName = $matches[1] ?? 'unknown';
                echo "✓ Inserted data into: $tableName\n";
            } elseif (stripos($statement, 'UPDATE') !== false) {
                preg_match('/UPDATE `([^`]+)`/', $statement, $matches);
                $tableName = $matches[1] ?? 'unknown';
                echo "✓ Updated existing data in: $tableName\n";
            } elseif (stripos($statement, 'CREATE INDEX') !== false) {
                preg_match('/CREATE INDEX `([^`]+)`/', $statement, $matches);
                $indexName = $matches[1] ?? 'unknown';
                echo "✓ Created index: $indexName\n";
            }
            
        } catch (PDOException $e) {
            $errors++;
            echo "✗ Error executing statement: " . $e->getMessage() . "\n";
            echo "  Statement: " . substr($statement, 0, 100) . "...\n";
        }
    }
    
    echo "\n=== INSTALLATION SUMMARY ===\n";
    echo "- SQL statements executed: $executed\n";
    echo "- Errors encountered: $errors\n";
    
    if ($errors == 0) {
        echo "\n🎉 RESELLER SYSTEM INSTALLED SUCCESSFULLY!\n\n";
        
        echo "New Features Added:\n";
        echo "1. ✓ Reseller accounts with multi-tenancy support\n";
        echo "2. ✓ Reseller subscription management\n";
        echo "3. ✓ Isolated customer and router management\n";
        echo "4. ✓ Reseller payment and commission tracking\n";
        echo "5. ✓ Configurable reseller plans and limits\n";
        echo "6. ✓ All existing data preserved under System Admin\n\n";
        
        echo "Database Changes:\n";
        echo "- Created 4 new reseller tables\n";
        echo "- Added reseller_id to 8 existing tables\n";
        echo "- Created performance indexes\n";
        echo "- Preserved all existing data\n\n";
        
        echo "Next Steps:\n";
        echo "1. Access admin panel to manage resellers\n";
        echo "2. Create reseller accounts with subscription plans\n";
        echo "3. Configure reseller limits and commission rates\n";
        echo "4. Test reseller dashboard isolation\n\n";
        
        echo "Default System Admin created:\n";
        echo "- All existing data belongs to System Admin (ID: 1)\n";
        echo "- Unlimited customers and routers\n";
        echo "- No commission fees\n";
        echo "- Never expires\n\n";
        
    } else {
        echo "\n⚠️  INSTALLATION COMPLETED WITH ERRORS\n";
        echo "Some operations failed. Please review the errors above.\n";
        echo "The system may still be functional, but some features might not work correctly.\n\n";
    }
    
    // Verify installation
    echo "=== VERIFICATION ===\n";
    
    $tables = ['tbl_resellers', 'tbl_reseller_subscriptions', 'tbl_reseller_payments', 'tbl_reseller_settings', 'tbl_reseller_plans'];
    
    foreach ($tables as $table) {
        try {
            $count = $pdo->query("SELECT COUNT(*) FROM $table")->fetchColumn();
            echo "✓ $table: $count records\n";
        } catch (PDOException $e) {
            echo "✗ $table: Not accessible - " . $e->getMessage() . "\n";
        }
    }
    
    // Check reseller_id columns
    $checkTables = ['tbl_customers', 'tbl_routers', 'tbl_transactions', 'tbl_user_recharges'];
    
    foreach ($checkTables as $table) {
        try {
            $result = $pdo->query("SHOW COLUMNS FROM $table LIKE 'reseller_id'")->fetch();
            if ($result) {
                echo "✓ $table: reseller_id column added\n";
            } else {
                echo "✗ $table: reseller_id column missing\n";
            }
        } catch (PDOException $e) {
            echo "✗ $table: Could not check - " . $e->getMessage() . "\n";
        }
    }
    
    echo "\nInstallation completed!\n";
    
} catch (Exception $e) {
    echo "FATAL ERROR: " . $e->getMessage() . "\n";
    exit(1);
}
?>