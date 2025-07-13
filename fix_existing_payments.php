<?php
/**
 * Fix all existing completed payments that don't have MikroTik users
 */

require_once 'config.php';
require_once 'system/boot.php';

echo "=== Fixing Existing Completed Payments ===\n\n";

// Find all completed sessions without MikroTik users
$completedSessions = ORM::for_table('tbl_portal_sessions')
    ->where('payment_status', 'completed')
    ->where_null('mikrotik_user')
    ->find_many();

if (empty($completedSessions)) {
    echo "✅ No sessions found that need fixing\n";
    exit;
}

echo "Found " . count($completedSessions) . " completed payments without MikroTik users:\n\n";

foreach ($completedSessions as $session) {
    echo "Processing Session: {$session->session_id}\n";
    echo "Phone: {$session->phone_number}\n";
    echo "MAC: {$session->mac_address}\n";
    echo "Package ID: {$session->package_id}\n";
    
    // Get package details
    $package = ORM::for_table('tbl_hotspot_packages')
        ->where('id', $session->package_id)
        ->find_one();
        
    if (!$package) {
        echo "❌ Package not found, skipping...\n\n";
        continue;
    }
    
    echo "Package: {$package->name} - KSh {$package->price}\n";
    
    try {
        // Create unique username
        $username = 'hs_' . substr(str_replace(':', '', $session->mac_address), -6) . '_' . time();
        $password = substr(md5($username . time()), 0, 8);
        
        echo "Creating user: $username\n";
        
        // Get router information
        $router = ORM::for_table('tbl_routers')
            ->where('enabled', 1)
            ->find_one();
            
        if (!$router) {
            echo "❌ No enabled router found\n\n";
            continue;
        }
        
        echo "Router: {$router->name} ({$router->ip_address})\n";
        
        // Load MikroTik device handler
        require_once 'system/devices/MikrotikHotspot.php';
        $device = new MikrotikHotspot();
        
        // Create customer and plan data
        $customer = [
            'username' => $username,
            'password' => $password,
            'mac_address' => $session->mac_address
        ];
        
        $plan = [
            'name_plan' => $package->name,
            'typebp' => 'Limited',
            'limit_type' => 'Time_Limit',
            'time_limit' => $package->duration_hours,
            'time_unit' => 'Hrs',
            'shared_users' => 1,
            'routers' => $router->id
        ];
        
        // Add user to MikroTik hotspot
        $device->add_customer($customer, $plan);
        
        // Update session with MikroTik user
        $session->mikrotik_user = $username;
        $session->save();
        
        // Log success
        file_put_contents('system/uploads/hotspot_users.log', 
            date('Y-m-d H:i:s') . ' - FIXED: Created user: ' . $username . ' for MAC: ' . $session->mac_address . ' - Package: ' . $package->name . PHP_EOL, FILE_APPEND);
        
        echo "✅ Successfully created MikroTik user: $username\n";
        echo "Password: $password\n";
        echo "Session updated with mikrotik_user\n\n";
        
    } catch (Exception $e) {
        echo "❌ Error: " . $e->getMessage() . "\n";
        file_put_contents('system/uploads/hotspot_users.log', 
            date('Y-m-d H:i:s') . ' - FIXING ERROR for session ' . $session->session_id . ': ' . $e->getMessage() . PHP_EOL, FILE_APPEND);
        echo "\n";
    }
}

echo "=== Summary ===\n";
echo "Processed " . count($completedSessions) . " existing payments\n";
echo "Check system/uploads/hotspot_users.log for detailed logs\n";
echo "Users should now have internet access!\n\n";

echo "You can delete this file after use: rm fix_existing_payments.php\n";
?>