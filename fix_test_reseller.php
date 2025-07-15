<?php

/**
 * Fix Test Reseller Subscription Data
 * Updates the test reseller to have correct expiry fields
 */

require_once 'init.php';

echo "=== FIXING TEST RESELLER SUBSCRIPTION ===\n";

try {
    // Find test reseller
    $reseller = ORM::for_table('tbl_resellers')
        ->where('name', 'Test Reseller')
        ->find_one();
    
    if (!$reseller) {
        echo "✗ Test reseller not found. Please run create_test_reseller_user.php first.\n";
        exit;
    }
    
    // Update with correct expiry fields
    $reseller->expires_at = date('Y-m-d H:i:s', strtotime('+30 days'));
    $reseller->subscription_status = 'trial';
    $reseller->save();
    
    echo "✓ Updated test reseller (ID: {$reseller->id})\n";
    echo "✓ Subscription status: {$reseller->subscription_status}\n";
    echo "✓ Expires at: {$reseller->expires_at}\n";
    
    // Verify subscription check
    require_once 'system/autoload/ResellerAuth.php';
    $check = ResellerAuth::checkSubscription($reseller->id);
    
    echo "\n=== SUBSCRIPTION CHECK RESULT ===\n";
    echo "Active: " . ($check['active'] ? 'YES' : 'NO') . "\n";
    echo "Status: " . $check['status'] . "\n";
    if (isset($check['expires_in'])) {
        echo "Expires in: " . $check['expires_in'] . " days\n";
    }
    if (isset($check['message'])) {
        echo "Message: " . $check['message'] . "\n";
    }
    
    if ($check['active']) {
        echo "\n🎉 TEST RESELLER SUBSCRIPTION FIXED!\n";
        echo "You can now login at: https://glintaafrica.com/reseller.php\n";
        echo "Username: testreseller\n";
        echo "Password: test123\n";
    } else {
        echo "\n❌ Subscription check still failing!\n";
    }
    
} catch (Exception $e) {
    echo "✗ Error: " . $e->getMessage() . "\n";
}

echo "\n=== END FIX ===\n";

?>