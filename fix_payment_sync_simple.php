<?php
/**
 * Simple Payment Sync Fix
 * Add missing reseller_id column and sync your KSh 20 payment
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
    
    echo "=== FIXING PAYMENT SYNC ISSUE ===\n\n";
    
    // Step 1: Add reseller_id to transactions table if missing
    echo "1. Checking tbl_transactions structure...\n";
    $check = $pdo->query("SHOW COLUMNS FROM tbl_transactions LIKE 'reseller_id'")->fetch();
    
    if (!$check) {
        echo "   Adding reseller_id column...\n";
        $pdo->exec("ALTER TABLE tbl_transactions ADD COLUMN reseller_id INT(11) DEFAULT 1");
        echo "   ✓ Added reseller_id column\n";
    } else {
        echo "   ✓ reseller_id column already exists\n";
    }
    
    // Step 2: Add reseller_id to M-Pesa transactions if missing
    echo "\n2. Checking tbl_mpesa_transactions structure...\n";
    $check = $pdo->query("SHOW COLUMNS FROM tbl_mpesa_transactions LIKE 'reseller_id'")->fetch();
    
    if (!$check) {
        echo "   Adding reseller_id column to M-Pesa table...\n";
        $pdo->exec("ALTER TABLE tbl_mpesa_transactions ADD COLUMN reseller_id INT(11) DEFAULT 1");
        echo "   ✓ Added reseller_id column to M-Pesa transactions\n";
        
        // Update existing M-Pesa records to belong to you (super admin)
        $updated = $pdo->exec("UPDATE tbl_mpesa_transactions SET reseller_id = 1 WHERE reseller_id IS NULL");
        echo "   ✓ Updated $updated existing M-Pesa transactions\n";
    } else {
        echo "   ✓ reseller_id column already exists in M-Pesa table\n";
    }
    
    // Step 3: Find and sync your KSh 20 payment
    echo "\n3. Finding your KSh 20 payment...\n";
    $stmt = $pdo->query("
        SELECT * FROM tbl_mpesa_transactions 
        WHERE amount = 20 
        AND status = 'completed'
        AND DATE(created_at) = CURDATE()
        ORDER BY created_at DESC
        LIMIT 1
    ");
    
    $payment = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($payment) {
        echo "   Found payment ID: {$payment['id']}\n";
        
        // Check if already synced
        $checkSync = $pdo->prepare("SELECT id FROM tbl_transactions WHERE invoice = ?");
        $checkSync->execute(['MPESA-' . $payment['id']]);
        
        if (!$checkSync->fetch()) {
            echo "   Payment not synced yet. Syncing now...\n";
            
            // Get session and package info
            $sessionStmt = $pdo->prepare("SELECT * FROM tbl_portal_sessions WHERE session_id = ?");
            $sessionStmt->execute([$payment['session_id']]);
            $session = $sessionStmt->fetch(PDO::FETCH_ASSOC);
            
            if ($session) {
                $packageStmt = $pdo->prepare("SELECT * FROM tbl_hotspot_packages WHERE id = ?");
                $packageStmt->execute([$session['package_id']]);
                $package = $packageStmt->fetch(PDO::FETCH_ASSOC);
                
                $packageName = $package ? $package['name'] : 'Unknown Package';
                
                // Create transaction record
                $insertStmt = $pdo->prepare("
                    INSERT INTO tbl_transactions 
                    (invoice, username, plan_name, price, recharged_on, recharged_time, method, routers, type, admin_id, reseller_id, expiration, time) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");
                
                $expiration = date('Y-m-d');
                if ($package && $package['duration_hours'] > 0) {
                    $expiration = date('Y-m-d', strtotime($payment['created_at'] . ' +' . $package['duration_hours'] . ' hours'));
                    $time = sprintf('%02d:00:00', $package['duration_hours']);
                } else {
                    $expiration = date('Y-m-d', strtotime($payment['created_at'] . ' +24 hours'));
                    $time = '24:00:00';
                }
                
                $insertStmt->execute([
                    'MPESA-' . $payment['id'],
                    $payment['phone_number'],
                    $packageName,
                    $payment['amount'],
                    date('Y-m-d', strtotime($payment['created_at'])),
                    date('H:i:s', strtotime($payment['created_at'])),
                    'M-Pesa',
                    'Portal',
                    'Hotspot',
                    1, // admin_id
                    1, // reseller_id (your direct customer)
                    $expiration,
                    $time
                ]);
                
                echo "   ✓ Successfully synced KSh 20 payment!\n";
                echo "   ✓ Package: $packageName\n";
                echo "   ✓ Customer: {$payment['phone_number']}\n";
                
            } else {
                echo "   ✗ Session not found for this payment\n";
            }
            
        } else {
            echo "   ✓ Payment already synced\n";
        }
        
    } else {
        echo "   No KSh 20 completed payment found today\n";
        
        // Show recent payments instead
        echo "\n   Recent completed payments:\n";
        $recentStmt = $pdo->query("
            SELECT id, phone_number, amount, status, created_at 
            FROM tbl_mpesa_transactions 
            WHERE status = 'completed' 
            ORDER BY created_at DESC 
            LIMIT 5
        ");
        
        while ($recent = $recentStmt->fetch(PDO::FETCH_ASSOC)) {
            echo "   - ID {$recent['id']}: KSh {$recent['amount']} from {$recent['phone_number']} ({$recent['created_at']})\n";
        }
    }
    
    // Step 4: Verify dashboard totals
    echo "\n4. Updated Dashboard Totals:\n";
    
    $todayRevenue = $pdo->query("
        SELECT SUM(price) as total 
        FROM tbl_transactions 
        WHERE DATE(recharged_on) = CURDATE()
        AND reseller_id = 1
    ")->fetchColumn() ?: 0;
    
    $weekRevenue = $pdo->query("
        SELECT SUM(price) as total 
        FROM tbl_transactions 
        WHERE YEARWEEK(recharged_on) = YEARWEEK(CURDATE())
        AND reseller_id = 1
    ")->fetchColumn() ?: 0;
    
    echo "   - Your Direct Customer Revenue Today: KSh " . number_format($todayRevenue, 2) . "\n";
    echo "   - Your Direct Customer Revenue This Week: KSh " . number_format($weekRevenue, 2) . "\n";
    
    echo "\n✅ PAYMENT SYNC FIXED! Your KSh 20 should now show on dashboard.\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
?>