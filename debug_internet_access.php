<?php
/**
 * Debug Internet Access Issue
 * This script will help identify why paying customers can't access internet
 */

require_once 'config.php';
require_once 'system/boot.php';

echo "=== DEBUGGING INTERNET ACCESS ISSUE ===\n";
echo "Date: " . date('Y-m-d H:i:s') . "\n\n";

// 1. Check completed payments without MikroTik users
echo "=== STEP 1: Check Completed Payments ===\n";
$completedSessions = ORM::for_table('tbl_portal_sessions')
    ->where('payment_status', 'completed')
    ->find_many();

echo "Total completed sessions: " . count($completedSessions) . "\n";

$sessionsWithoutUsers = 0;
$sessionsWithUsers = 0;

foreach ($completedSessions as $session) {
    if (empty($session->mikrotik_user)) {
        $sessionsWithoutUsers++;
        echo "❌ Session {$session->session_id} - MAC: {$session->mac_address} - NO MikroTik user\n";
    } else {
        $sessionsWithUsers++;
        echo "✅ Session {$session->session_id} - MAC: {$session->mac_address} - User: {$session->mikrotik_user}\n";
    }
}

echo "\nSummary:\n";
echo "- Sessions WITH MikroTik users: $sessionsWithUsers\n";
echo "- Sessions WITHOUT MikroTik users: $sessionsWithoutUsers\n\n";

// 2. Check MikroTik router connectivity
echo "=== STEP 2: Check MikroTik Router ===\n";
$router = ORM::for_table('tbl_routers')
    ->where('enabled', 1)
    ->find_one();

if (!$router) {
    echo "❌ CRITICAL: No enabled MikroTik router found!\n";
    echo "   → Add a router in admin panel\n\n";
} else {
    echo "✅ Router found: {$router->name}\n";
    echo "   IP: {$router->ip_address}\n";
    echo "   Username: {$router->username}\n";
    echo "   Enabled: " . ($router->enabled ? 'Yes' : 'No') . "\n";
    
    // Test connectivity
    try {
        require_once 'system/devices/MikrotikHotspot.php';
        $device = new MikrotikHotspot();
        $client = $device->getClient($router->ip_address, $router->username, $router->password);
        
        if ($client) {
            echo "✅ MikroTik connection: SUCCESS\n";
            
            // Get current hotspot users
            $printRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/print');
            $users = $client->sendSync($printRequest);
            $userCount = 0;
            
            foreach ($users as $user) {
                $userCount++;
                $username = $user->getProperty('name');
                $profile = $user->getProperty('profile');
                echo "   User: $username (Profile: $profile)\n";
            }
            
            echo "   Total hotspot users on MikroTik: $userCount\n";
            
        } else {
            echo "❌ MikroTik connection: FAILED\n";
            echo "   → Check router IP, username, password\n";
        }
    } catch (Exception $e) {
        echo "❌ MikroTik connection error: " . $e->getMessage() . "\n";
    }
}

echo "\n=== STEP 3: Check Hotspot Packages ===\n";
$packages = ORM::for_table('tbl_hotspot_packages')
    ->where('status', 'active')
    ->find_many();

if (count($packages) == 0) {
    echo "❌ CRITICAL: No active packages found!\n";
} else {
    foreach ($packages as $package) {
        echo "✅ Package: {$package->name} - KSh {$package->price} - {$package->duration_hours}hrs\n";
    }
}

echo "\n=== STEP 4: Check M-Pesa Callbacks ===\n";
$mpesaTransactions = ORM::for_table('tbl_mpesa_transactions')
    ->where('status', 'completed')
    ->order_by_desc('id')
    ->limit(5)
    ->find_many();

if (count($mpesaTransactions) == 0) {
    echo "❌ No completed M-Pesa transactions found\n";
} else {
    echo "Recent completed M-Pesa transactions:\n";
    foreach ($mpesaTransactions as $txn) {
        echo "   📱 {$txn->phone_number} - KSh {$txn->amount} - Session: {$txn->session_id}\n";
        
        // Check if session exists and has MikroTik user
        $session = ORM::for_table('tbl_portal_sessions')
            ->where('session_id', $txn->session_id)
            ->find_one();
            
        if ($session) {
            echo "      Session status: {$session->payment_status}\n";
            echo "      MikroTik user: " . ($session->mikrotik_user ?: 'NONE') . "\n";
        }
    }
}

echo "\n=== STEP 5: MikroTik Integration Analysis ===\n";

// Check if the MpesaIntegration createMikroTikUser method is working
try {
    $mpesa = new MpesaIntegration();
    echo "✅ MpesaIntegration class loaded successfully\n";
    
    if ($mpesa->isConfigured()) {
        echo "✅ M-Pesa is configured\n";
    } else {
        echo "❌ M-Pesa is not configured\n";
    }
} catch (Exception $e) {
    echo "❌ MpesaIntegration error: " . $e->getMessage() . "\n";
}

echo "\n=== STEP 6: Identify Root Cause ===\n";

if ($sessionsWithoutUsers > 0) {
    echo "🔥 PRIMARY ISSUE: $sessionsWithoutUsers completed payments don't have MikroTik users\n";
    echo "   SOLUTION: Run fix_existing_payments.php\n\n";
}

if (!$router) {
    echo "🔥 CRITICAL ISSUE: No MikroTik router configured\n";
    echo "   SOLUTION: Add router in admin panel\n\n";
}

// Check if hotspot profiles exist on MikroTik
if ($router && isset($client)) {
    try {
        $printRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/profile/print');
        $profiles = $client->sendSync($printRequest);
        $profileCount = 0;
        
        foreach ($profiles as $profile) {
            $profileCount++;
            $profileName = $profile->getProperty('name');
            echo "   Profile: $profileName\n";
        }
        
        if ($profileCount == 0) {
            echo "🔥 ISSUE: No hotspot profiles found on MikroTik\n";
            echo "   SOLUTION: Create hotspot profiles matching package names\n\n";
        } else {
            echo "✅ Found $profileCount hotspot profiles\n";
        }
        
    } catch (Exception $e) {
        echo "❌ Could not check profiles: " . $e->getMessage() . "\n";
    }
}

echo "\n=== RECOMMENDED ACTIONS ===\n";
echo "1. 🚀 IMMEDIATE: Run fix_existing_payments.php to create missing users\n";
echo "2. 🔧 CHECK: Verify MikroTik hotspot profiles match package names\n";
echo "3. 🌐 TEST: Try connecting a device and check if it gets redirected\n";
echo "4. 📊 MONITOR: Check system/uploads/hotspot_users.log for errors\n";

echo "\nDebugging completed.\n";
?>