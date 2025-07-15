<?php

/**
 * Create Test Reseller User
 * Creates the testreseller/test123 user for testing
 */

require_once 'init.php';

echo "=== CREATING TEST RESELLER USER ===\n";

try {
    // Check if test reseller already exists
    $existing_reseller = ORM::for_table('tbl_resellers')
        ->where('name', 'Test Reseller')
        ->find_one();
    
    if (!$existing_reseller) {
        // Create test reseller company
        $reseller = ORM::for_table('tbl_resellers')->create();
        $reseller->name = 'Test Reseller';
        $reseller->email = 'test@glintaafrica.com';
        $reseller->phone = '+254700000000';
        $reseller->address = 'Nairobi, Kenya';
        $reseller->subscription_status = 'trial';
        $reseller->trial_start = date('Y-m-d');
        $reseller->trial_end = date('Y-m-d', strtotime('+30 days'));
        $reseller->expires_at = date('Y-m-d H:i:s', strtotime('+30 days'));
        $reseller->status = 'active';
        $reseller->created_at = date('Y-m-d H:i:s');
        $reseller->save();
        
        echo "✓ Created test reseller company (ID: {$reseller->id})\n";
    } else {
        $reseller = $existing_reseller;
        echo "✓ Test reseller company already exists (ID: {$reseller->id})\n";
    }
    
    // Check if test reseller admin already exists
    $existing_admin = ORM::for_table('tbl_reseller_admins')
        ->where('username', 'testreseller')
        ->find_one();
    
    if (!$existing_admin) {
        // Create test reseller admin user
        $admin = ORM::for_table('tbl_reseller_admins')->create();
        $admin->username = 'testreseller';
        $admin->password = password_hash('test123', PASSWORD_DEFAULT);
        $admin->fullname = 'Test Reseller Admin';
        $admin->email = 'admin@testreseller.com';
        $admin->phone = '+254700000001';
        $admin->reseller_id = $reseller->id;
        $admin->status = 'active';
        $admin->role = 'owner';
        $admin->created_at = date('Y-m-d H:i:s');
        $admin->save();
        
        echo "✓ Created test reseller admin user\n";
        echo "✓ Username: testreseller\n";
        echo "✓ Password: test123\n";
        echo "✓ Linked to reseller ID: {$reseller->id}\n";
    } else {
        echo "✓ Test reseller admin already exists\n";
        echo "✓ Username: testreseller\n";
        echo "✓ Password: test123\n";
    }
    
    // Verify the setup
    echo "\n=== VERIFICATION ===\n";
    
    $verify_admin = ORM::for_table('tbl_reseller_admins')
        ->where('username', 'testreseller')
        ->find_one();
    
    if ($verify_admin) {
        echo "✓ Test admin found: {$verify_admin->fullname}\n";
        echo "✓ Status: {$verify_admin->status}\n";
        echo "✓ Reseller ID: {$verify_admin->reseller_id}\n";
        
        $verify_reseller = ORM::for_table('tbl_resellers')->find_one($verify_admin->reseller_id);
        if ($verify_reseller) {
            echo "✓ Reseller company: {$verify_reseller->name}\n";
            echo "✓ Subscription: {$verify_reseller->subscription_status}\n";
            echo "✓ Trial end: {$verify_reseller->trial_end}\n";
        }
    }
    
    echo "\n🎉 TEST RESELLER USER CREATED SUCCESSFULLY!\n";
    echo "\nYou can now login at: https://glintaafrica.com/reseller.php\n";
    echo "Username: testreseller\n";
    echo "Password: test123\n";
    
} catch (Exception $e) {
    echo "✗ Error: " . $e->getMessage() . "\n";
    echo "Make sure the database tables exist:\n";
    echo "- tbl_resellers\n";
    echo "- tbl_reseller_admins\n";
}

echo "\n=== END TEST RESELLER CREATION ===\n";

?>