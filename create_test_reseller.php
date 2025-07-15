<?php
/**
 * Create Test Reseller Account
 * For testing the reseller system
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
    
    echo "=== CREATING TEST RESELLER ACCOUNT ===\n\n";
    
    // Check if test reseller already exists
    $existing = $pdo->query("SELECT id FROM tbl_resellers WHERE email = 'test@reseller.com'")->fetch();
    
    if ($existing) {
        echo "Test reseller already exists. Updating...\n";
        $reseller_id = $existing['id'];
        
        // Update reseller
        $pdo->prepare("UPDATE tbl_resellers SET 
            name = ?, password = ?, trial_ends = ?, expires_at = ?, subscription_status = 'trial'
            WHERE id = ?")->execute([
            'Test Reseller',
            password_hash('test123', PASSWORD_DEFAULT),
            date('Y-m-d H:i:s', strtotime('+30 days')),
            date('Y-m-d H:i:s', strtotime('+30 days')),
            $reseller_id
        ]);
        
        // Update admin user
        $pdo->prepare("UPDATE tbl_reseller_admins SET 
            password = ?
            WHERE reseller_id = ?")->execute([
            password_hash('test123', PASSWORD_DEFAULT),
            $reseller_id
        ]);
        
    } else {
        echo "Creating new test reseller...\n";
        
        // Create test reseller
        $stmt = $pdo->prepare("INSERT INTO tbl_resellers 
            (name, email, password, phone, company, address, subscription_plan, subscription_status, 
             trial_starts, trial_ends, max_customers, max_routers, expires_at) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        
        $stmt->execute([
            'Test Reseller',
            'test@reseller.com', 
            password_hash('test123', PASSWORD_DEFAULT),
            '+254712345678',
            'Test Reseller Company',
            '123 Test Street, Nairobi',
            'starter',
            'trial',
            date('Y-m-d H:i:s'),
            date('Y-m-d H:i:s', strtotime('+30 days')),
            50,
            2,
            date('Y-m-d H:i:s', strtotime('+30 days'))
        ]);
        
        $reseller_id = $pdo->lastInsertId();
        
        // Create admin user for test reseller
        $stmt = $pdo->prepare("INSERT INTO tbl_reseller_admins 
            (reseller_id, username, password, fullname, email, phone, role, status) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        
        $stmt->execute([
            $reseller_id,
            'testreseller',
            password_hash('test123', PASSWORD_DEFAULT),
            'Test Reseller',
            'test@reseller.com',
            '+254712345678',
            'owner',
            'active'
        ]);
    }
    
    // Add some test customers for the reseller
    echo "Adding test customers...\n";
    
    for ($i = 1; $i <= 5; $i++) {
        $existing_customer = $pdo->prepare("SELECT id FROM tbl_customers WHERE username = ? AND reseller_id = ?");
        $existing_customer->execute(["testcustomer$i", $reseller_id]);
        
        if (!$existing_customer->fetch()) {
            $stmt = $pdo->prepare("INSERT INTO tbl_customers 
                (username, password, fullname, email, phonenumber, address, reseller_id, created_at) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            
            $stmt->execute([
                "testcustomer$i",
                password_hash('test123', PASSWORD_DEFAULT),
                "Test Customer $i",
                "customer$i@test.com",
                "+25471234567$i",
                "Test Address $i",
                $reseller_id,
                date('Y-m-d H:i:s')
            ]);
        }
    }
    
    // Add some test transactions
    echo "Adding test transactions...\n";
    
    for ($i = 1; $i <= 10; $i++) {
        $amount = rand(100, 1000);
        $days_ago = rand(1, 30);
        
        $recharge_date = date('Y-m-d', strtotime("-$days_ago days"));
        $expiration_date = date('Y-m-d', strtotime($recharge_date . ' +30 days'));
        
        $stmt = $pdo->prepare("INSERT INTO tbl_transactions 
            (invoice, username, plan_name, price, recharged_on, recharged_time, method, type, reseller_id, expiration, time, admin_id) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        
        $stmt->execute([
            "TEST-" . time() . "-$i",
            "testcustomer" . rand(1, 5),
            "Test Package " . rand(1, 3),
            $amount,
            $recharge_date,
            date('H:i:s'),
            'M-Pesa',
            'Hotspot',
            $reseller_id,
            $expiration_date,
            '30:00:00', // 30 hours validity
            1 // admin_id
        ]);
    }
    
    echo "\n=== TEST RESELLER ACCOUNT CREATED! ===\n";
    echo "\n🎉 RESELLER LOGIN CREDENTIALS:\n";
    echo "URL: http://yourdomain.com/reseller.php\n";
    echo "Username: testreseller\n";
    echo "Password: test123\n";
    echo "Email: test@reseller.com\n";
    
    echo "\n📊 TEST DATA INCLUDED:\n";
    echo "✓ Reseller ID: $reseller_id\n";
    echo "✓ Trial Status: Active (30 days)\n";
    echo "✓ Max Customers: 50\n";
    echo "✓ Max Routers: 2\n";
    echo "✓ Test Customers: 5\n";
    echo "✓ Test Transactions: 10\n";
    
    echo "\n🔧 RESELLER CAPABILITIES:\n";
    echo "• Dashboard with sales reports\n";
    echo "• Add/configure MikroTik routers\n";
    echo "• Manage customers\n";
    echo "• View transaction history\n";
    echo "• Monitor subscription status\n";
    echo "• Configure payment settings\n";
    
    echo "\n🚀 NEXT STEPS:\n";
    echo "1. Access: http://yourdomain.com/reseller.php\n";
    echo "2. Login with: testreseller / test123\n";
    echo "3. Explore complete reseller dashboard\n";
    echo "4. Test MikroTik configuration\n";
    echo "5. View sales reports and customer management\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
?>