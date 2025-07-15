<?php
/**
 * Check Latest Payment Status
 * Diagnostic script to find and sync recent payments
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
    
    echo "=== CHECKING LATEST PAYMENTS ===\n\n";
    
    // 1. Check latest M-Pesa transactions
    echo "1. Latest M-Pesa Transactions:\n";
    $stmt = $pdo->query("
        SELECT id, phone_number, amount, status, created_at, 
               TIMESTAMPDIFF(MINUTE, created_at, NOW()) as minutes_ago
        FROM tbl_mpesa_transactions 
        ORDER BY created_at DESC 
        LIMIT 5
    ");
    
    $mpesaPayments = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($mpesaPayments as $payment) {
        echo sprintf("   - ID: %d | Phone: %s | Amount: KSh %s | Status: %s | %d minutes ago\n",
            $payment['id'],
            $payment['phone_number'],
            $payment['amount'],
            $payment['status'],
            $payment['minutes_ago']
        );
    }
    
    // 2. Check if these are synced to main transactions
    echo "\n2. Checking Sync Status:\n";
    $unsyncedCount = 0;
    foreach ($mpesaPayments as $payment) {
        if ($payment['status'] == 'completed') {
            $check = $pdo->prepare("SELECT id FROM tbl_transactions WHERE invoice = ?");
            $check->execute(['MPESA-' . $payment['id']]);
            if (!$check->fetch()) {
                echo "   ✗ Payment ID {$payment['id']} (KSh {$payment['amount']}) NOT SYNCED!\n";
                $unsyncedCount++;
            } else {
                echo "   ✓ Payment ID {$payment['id']} already synced\n";
            }
        }
    }
    
    // 3. Show dashboard totals
    echo "\n3. Dashboard Revenue Totals:\n";
    
    // Today's revenue
    $todayRevenue = $pdo->query("
        SELECT SUM(price) as total 
        FROM tbl_transactions 
        WHERE DATE(recharged_on) = CURDATE()
    ")->fetchColumn() ?: 0;
    
    // This week's revenue
    $weekRevenue = $pdo->query("
        SELECT SUM(price) as total 
        FROM tbl_transactions 
        WHERE YEARWEEK(recharged_on) = YEARWEEK(CURDATE())
    ")->fetchColumn() ?: 0;
    
    // This month's revenue
    $monthRevenue = $pdo->query("
        SELECT SUM(price) as total 
        FROM tbl_transactions 
        WHERE YEAR(recharged_on) = YEAR(CURDATE()) 
        AND MONTH(recharged_on) = MONTH(CURDATE())
    ")->fetchColumn() ?: 0;
    
    echo "   - Today: KSh " . number_format($todayRevenue, 2) . "\n";
    echo "   - This Week: KSh " . number_format($weekRevenue, 2) . "\n";
    echo "   - This Month: KSh " . number_format($monthRevenue, 2) . "\n";
    
    // 4. Find the specific KSh 20 payment
    echo "\n4. Looking for KSh 20 payment:\n";
    $stmt = $pdo->query("
        SELECT * FROM tbl_mpesa_transactions 
        WHERE amount = 20 
        AND DATE(created_at) = CURDATE()
        ORDER BY created_at DESC
    ");
    
    $twentyPayments = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if ($twentyPayments) {
        foreach ($twentyPayments as $payment) {
            echo "   Found: ID {$payment['id']} | Phone: {$payment['phone_number']} | Status: {$payment['status']}\n";
            
            // Check if synced
            $check = $pdo->prepare("SELECT id FROM tbl_transactions WHERE invoice = ?");
            $check->execute(['MPESA-' . $payment['id']]);
            if (!$check->fetch() && $payment['status'] == 'completed') {
                echo "   >>> This payment needs to be synced!\n";
                
                // Get session info
                $session = $pdo->prepare("SELECT * FROM tbl_portal_sessions WHERE session_id = ?");
                $session->execute([$payment['session_id']]);
                $sessionData = $session->fetch(PDO::FETCH_ASSOC);
                
                if ($sessionData) {
                    echo "   >>> Session found: Package ID {$sessionData['package_id']}\n";
                } else {
                    echo "   >>> WARNING: No session found for this payment!\n";
                }
            }
        }
    } else {
        echo "   No KSh 20 payments found today\n";
    }
    
    echo "\n=== DIAGNOSIS COMPLETE ===\n";
    
    if ($unsyncedCount > 0) {
        echo "\nACTION REQUIRED: Run 'php sync_payments_minimal.php' to sync {$unsyncedCount} payments!\n";
    } else {
        echo "\nAll payments appear to be synced.\n";
    }
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
?>