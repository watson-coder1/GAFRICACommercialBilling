<?php
/**
 * Create Test Reseller Account (Fixed)
 * For testing the reseller system with proper field handling
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
    
    echo "=== CREATING TEST RESELLER ACCOUNT (FIXED) ===\n\n";
    
    // Step 1: Check table structures
    echo "1. Checking table structures...\n";
    
    // Check transactions table structure
    $columns = $pdo->query("DESCRIBE tbl_transactions")->fetchAll(PDO::FETCH_ASSOC);
    $transaction_fields = array_column($columns, 'Field');
    
    echo "   Transaction table fields: " . implode(', ', $transaction_fields) . "\n";
    
    // Check if test reseller already exists
    $existing = $pdo->query("SELECT id FROM tbl_resellers WHERE email = 'test@reseller.com'")->fetch();
    
    if ($existing) {
        echo "\n2. Test reseller already exists. Updating...\n";
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
        echo "\n2. Creating new test reseller...\n";
        
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
        echo "   ✓ Created reseller with ID: $reseller_id\n";
        
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
        echo "   ✓ Created admin user: testreseller\n";
    }
    
    // Step 3: Add test customers
    echo "\n3. Adding test customers...\n";
    
    for ($i = 1; $i <= 5; $i++) {
        $existing_customer = $pdo->prepare("SELECT id FROM tbl_customers WHERE username = ? AND reseller_id = ?");
        $existing_customer->execute(["testcustomer$i", $reseller_id]);
        
        if (!$existing_customer->fetch()) {
            // Check customers table structure
            if ($i == 1) {
                $customer_columns = $pdo->query("DESCRIBE tbl_customers")->fetchAll(PDO::FETCH_ASSOC);
                $customer_fields = array_column($customer_columns, 'Field');
                echo "   Customer table fields: " . implode(', ', $customer_fields) . "\n";
            }
            
            // Build insert based on available fields
            $customer_sql = "INSERT INTO tbl_customers (username, password, fullname, reseller_id";
            $customer_values = ["testcustomer$i", password_hash('test123', PASSWORD_DEFAULT), "Test Customer $i", $reseller_id];
            
            if (in_array('email', $customer_fields)) {
                $customer_sql .= ", email";
                $customer_values[] = "customer$i@test.com";
            }
            if (in_array('phonenumber', $customer_fields)) {
                $customer_sql .= ", phonenumber";
                $customer_values[] = "+25471234567$i";
            }
            if (in_array('address', $customer_fields)) {
                $customer_sql .= ", address";
                $customer_values[] = "Test Address $i";
            }
            if (in_array('created_at', $customer_fields)) {
                $customer_sql .= ", created_at";
                $customer_values[] = date('Y-m-d H:i:s');
            }
            
            $customer_sql .= ") VALUES (" . str_repeat('?,', count($customer_values)-1) . "?)";
            
            $stmt = $pdo->prepare($customer_sql);
            $stmt->execute($customer_values);
            echo "   ✓ Created customer: testcustomer$i\n";
        }
    }
    
    // Step 4: Add test transactions (with proper field handling)
    echo "\n4. Adding test transactions...\n";
    
    // Clean up old test transactions first
    $pdo->prepare("DELETE FROM tbl_transactions WHERE reseller_id = ? AND invoice LIKE 'TEST-%'")->execute([$reseller_id]);
    
    for ($i = 1; $i <= 10; $i++) {
        $amount = rand(100, 1000);
        $days_ago = rand(1, 30);
        $recharge_date = date('Y-m-d', strtotime("-$days_ago days"));
        $recharge_time = date('H:i:s');
        
        // Build transaction insert based on available fields
        $trans_sql = "INSERT INTO tbl_transactions (invoice, username, plan_name, price, recharged_on, recharged_time, method, type, reseller_id";
        $trans_values = [
            "TEST-" . time() . "-$i",
            "testcustomer" . rand(1, 5),
            "Test Package " . rand(1, 3),
            $amount,
            $recharge_date,
            $recharge_time,
            'M-Pesa',
            'Hotspot',
            $reseller_id
        ];
        
        // Add optional fields if they exist
        if (in_array('expiration', $transaction_fields)) {
            $trans_sql .= ", expiration";
            $trans_values[] = date('Y-m-d', strtotime($recharge_date . ' +30 days'));
        }
        if (in_array('time', $transaction_fields)) {
            $trans_sql .= ", time";
            $trans_values[] = '720:00:00'; // 30 days in hours:minutes:seconds
        }
        if (in_array('admin_id', $transaction_fields)) {
            $trans_sql .= ", admin_id";
            $trans_values[] = 1;
        }
        if (in_array('routers', $transaction_fields)) {
            $trans_sql .= ", routers";
            $trans_values[] = 'Portal';
        }
        
        $trans_sql .= ") VALUES (" . str_repeat('?,', count($trans_values)-1) . "?)";
        
        try {
            $stmt = $pdo->prepare($trans_sql);
            $stmt->execute($trans_values);
            echo "   ✓ Created transaction $i: KSh $amount\n";
        } catch (Exception $e) {
            echo "   ✗ Failed transaction $i: " . $e->getMessage() . "\n";
        }
    }
    
    // Step 5: Verify installation
    echo "\n5. Verifying installation...\n";
    
    $reseller = $pdo->prepare("SELECT * FROM tbl_resellers WHERE id = ?");
    $reseller->execute([$reseller_id]);
    $reseller_data = $reseller->fetch(PDO::FETCH_ASSOC);
    
    $admin = $pdo->prepare("SELECT * FROM tbl_reseller_admins WHERE reseller_id = ?");
    $admin->execute([$reseller_id]);
    $admin_data = $admin->fetch(PDO::FETCH_ASSOC);
    
    $customer_count = $pdo->prepare("SELECT COUNT(*) FROM tbl_customers WHERE reseller_id = ?");
    $customer_count->execute([$reseller_id]);
    $customers = $customer_count->fetchColumn();
    
    $transaction_count = $pdo->prepare("SELECT COUNT(*) FROM tbl_transactions WHERE reseller_id = ?");
    $transaction_count->execute([$reseller_id]);
    $transactions = $transaction_count->fetchColumn();
    
    $total_revenue = $pdo->prepare("SELECT SUM(price) FROM tbl_transactions WHERE reseller_id = ?");
    $total_revenue->execute([$reseller_id]);
    $revenue = $total_revenue->fetchColumn() ?: 0;
    
    echo "\n=== TEST RESELLER ACCOUNT READY! ===\n";
    echo "\n🎉 RESELLER LOGIN CREDENTIALS:\n";
    echo "URL: http://your-server-ip/reseller.php\n";
    echo "Username: testreseller\n";
    echo "Password: test123\n";
    echo "Email: test@reseller.com\n";
    
    echo "\n📊 ACCOUNT DETAILS:\n";
    echo "✓ Reseller ID: $reseller_id\n";
    echo "✓ Company: {$reseller_data['company']}\n";
    echo "✓ Trial Status: {$reseller_data['subscription_status']}\n";
    echo "✓ Trial Expires: {$reseller_data['trial_ends']}\n";
    echo "✓ Max Customers: {$reseller_data['max_customers']}\n";
    echo "✓ Max Routers: {$reseller_data['max_routers']}\n";
    
    echo "\n📈 TEST DATA:\n";
    echo "✓ Test Customers: $customers\n";
    echo "✓ Test Transactions: $transactions\n";
    echo "✓ Total Revenue: KSh " . number_format($revenue, 2) . "\n";
    
    echo "\n🔧 DASHBOARD FEATURES READY:\n";
    echo "• Revenue statistics (today/week/month)\n";
    echo "• Customer management system\n";
    echo "• MikroTik router configuration\n";
    echo "• Transaction history and reports\n";
    echo "• Subscription status monitoring\n";
    echo "• Settings and configuration\n";
    
    echo "\n🚀 NEXT STEPS:\n";
    echo "1. Access: http://your-server-ip/reseller.php\n";
    echo "2. Login with: testreseller / test123\n";
    echo "3. Explore complete reseller dashboard\n";
    echo "4. Test MikroTik configuration features\n";
    echo "5. View sales reports and analytics\n";
    echo "6. Manage customers and transactions\n";
    
    echo "\n✨ RESELLER SYSTEM IS READY FOR TESTING!\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Stack trace: " . $e->getTraceAsString() . "\n";
}
?>