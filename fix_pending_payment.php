<?php
/**
 * Fix pending payment that was already paid
 * This will manually process the successful M-Pesa payment
 */

require_once 'config.php';
require_once 'system/boot.php';

echo "=== Fixing Pending Payment ===\n\n";

// Find the pending session for phone 254711503023
$session = ORM::for_table('tbl_portal_sessions')
    ->where('phone_number', '254711503023')
    ->where('payment_status', 'pending')
    ->find_one();

if (!$session) {
    echo "❌ No pending session found for 254711503023\n";
    exit;
}

echo "✅ Found pending session: {$session->session_id}\n";
echo "Package ID: {$session->package_id}\n";
echo "MAC Address: {$session->mac_address}\n";

// Get package details
$package = ORM::for_table('tbl_hotspot_packages')
    ->where('id', $session->package_id)
    ->find_one();

if (!$package) {
    echo "❌ Package not found\n";
    exit;
}

echo "Package: {$package->name} - KSh {$package->price}\n";

// Update session to completed
$session->payment_status = 'completed';
$session->expires_at = date('Y-m-d H:i:s', strtotime('+' . $package->duration_hours . ' hours'));
$session->save();

echo "✅ Session updated to completed\n";
echo "Expires at: {$session->expires_at}\n";

// Create M-Pesa transaction record for the successful payment
$transaction = ORM::for_table('tbl_mpesa_transactions')->create();
$transaction->transaction_id = 'ws_CO_1752398069992711503023'; // From callback log
$transaction->phone_number = '254711503023';
$transaction->amount = $package->price;
$transaction->session_id = $session->session_id;
$transaction->status = 'completed';
$transaction->mpesa_receipt_number = 'TGD8SFSLO2'; // From callback log
$transaction->callback_response = '{"Body":{"stkCallback":{"ResultCode":0,"ResultDesc":"The service request is processed successfully"}}}';
$transaction->save();

echo "✅ Transaction record created\n";
echo "Receipt: TGD8SFSLO2\n";

// Try to create MikroTik user
echo "\n=== Creating Hotspot User ===\n";

try {
    // Get router
    $router = ORM::for_table('tbl_routers')
        ->where('enabled', 1)
        ->find_one();
        
    if (!$router) {
        echo "❌ No enabled router found\n";
        exit;
    }
    
    echo "Router: {$router->name} ({$router->ip_address})\n";
    
    // Create username and password
    $username = 'hs_' . substr($session->mac_address, -6) . '_' . time();
    $password = substr(md5($session->session_id . time()), 0, 8);
    
    echo "Username: $username\n";
    echo "Password: $password\n";
    
    // For now, just log this - actual MikroTik integration would go here
    file_put_contents('system/uploads/hotspot_users.log', 
        date('Y-m-d H:i:s') . " - MANUAL FIX: Created user: $username for MAC: {$session->mac_address} - Package: {$package->name}\n", 
        FILE_APPEND);
    
    echo "✅ User creation logged\n";
    echo "\n=== IMPORTANT ===\n";
    echo "You need to manually create this hotspot user on your MikroTik router:\n";
    echo "Username: $username\n";
    echo "Password: $password\n";
    echo "Profile: {$package->name}\n";
    echo "Time Limit: {$package->duration_hours} hours\n";
    echo "MAC Address: {$session->mac_address}\n";
    
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}

echo "\n✅ Payment processing completed!\n";
echo "The user should now be able to access WiFi (if MikroTik user is created).\n";
?>