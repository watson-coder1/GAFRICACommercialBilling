<?php
/**
 * Fix Internet Access for All Paying Customers
 * This script creates MikroTik users for all completed payments and troubleshoots issues
 */

require_once 'config.php';
require_once 'system/boot.php';

echo "=== FIXING INTERNET ACCESS FOR ALL CUSTOMERS ===\n";
echo "Date: " . date('Y-m-d H:i:s') . "\n\n";

// Step 1: Verify MikroTik connection
echo "=== STEP 1: Verify MikroTik Connection ===\n";
$router = ORM::for_table('tbl_routers')
    ->where('enabled', 1)
    ->find_one();

if (!$router) {
    echo "❌ CRITICAL: No enabled MikroTik router found!\n";
    echo "Please add a router in the admin panel first.\n";
    exit;
}

echo "✅ Router: {$router->name} ({$router->ip_address})\n";

try {
    require_once 'system/devices/MikrotikHotspot.php';
    $device = new MikrotikHotspot();
    $client = $device->getClient($router->ip_address, $router->username, $router->password);
    
    if (!$client) {
        echo "❌ Cannot connect to MikroTik router\n";
        echo "Please check router IP, username, and password\n";
        exit;
    }
    
    echo "✅ MikroTik connection successful\n";
    
} catch (Exception $e) {
    echo "❌ MikroTik connection error: " . $e->getMessage() . "\n";
    exit;
}

// Step 2: Check and create hotspot profiles
echo "\n=== STEP 2: Check Hotspot Profiles ===\n";
$packages = ORM::for_table('tbl_hotspot_packages')
    ->where('status', 'active')
    ->find_many();

$profilesNeeded = [];
foreach ($packages as $package) {
    $profilesNeeded[] = $package->name;
}

try {
    $printRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/profile/print');
    $profiles = $client->sendSync($printRequest);
    $existingProfiles = [];
    
    foreach ($profiles as $profile) {
        $existingProfiles[] = $profile->getProperty('name');
    }
    
    echo "Existing profiles: " . implode(', ', $existingProfiles) . "\n";
    echo "Needed profiles: " . implode(', ', $profilesNeeded) . "\n";
    
    // Create missing profiles
    foreach ($profilesNeeded as $profileName) {
        if (!in_array($profileName, $existingProfiles)) {
            echo "Creating profile: $profileName\n";
            $addRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/profile/add');
            $client->sendSync(
                $addRequest
                    ->setArgument('name', $profileName)
                    ->setArgument('shared-users', 1)
            );
        }
    }
    
} catch (Exception $e) {
    echo "❌ Profile check error: " . $e->getMessage() . "\n";
}

// Step 3: Fix all completed payments without MikroTik users
echo "\n=== STEP 3: Create Missing MikroTik Users ===\n";
$completedSessions = ORM::for_table('tbl_portal_sessions')
    ->where('payment_status', 'completed')
    ->where_null('mikrotik_user')
    ->find_many();

if (empty($completedSessions)) {
    echo "✅ No sessions need fixing - all have MikroTik users\n";
} else {
    echo "Found " . count($completedSessions) . " completed payments without MikroTik users\n\n";
    
    $successCount = 0;
    $errorCount = 0;
    
    foreach ($completedSessions as $session) {
        echo "Processing Session: {$session->session_id}\n";
        echo "Phone: {$session->phone_number}\n";
        echo "MAC: {$session->mac_address}\n";
        
        // Get package
        $package = ORM::for_table('tbl_hotspot_packages')
            ->where('id', $session->package_id)
            ->find_one();
            
        if (!$package) {
            echo "❌ Package not found, skipping...\n\n";
            $errorCount++;
            continue;
        }
        
        echo "Package: {$package->name} - KSh {$package->price} - {$package->duration_hours}hrs\n";
        
        try {
            // Create unique username and password
            $username = 'hs_' . substr(str_replace(':', '', $session->mac_address), -6) . '_' . time();
            $password = substr(md5($username . time()), 0, 8);
            
            echo "Creating user: $username\n";
            
            // Create MikroTik user
            $addRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/add');
            
            if ($package->duration_hours > 0) {
                // Time-limited package
                $timelimit = $package->duration_hours . ":00:00";
                $client->sendSync(
                    $addRequest
                        ->setArgument('name', $username)
                        ->setArgument('profile', $package->name)
                        ->setArgument('password', $password)
                        ->setArgument('comment', "Auto-created for {$session->phone_number}")
                        ->setArgument('limit-uptime', $timelimit)
                );
            } else {
                // Unlimited package
                $client->sendSync(
                    $addRequest
                        ->setArgument('name', $username)
                        ->setArgument('profile', $package->name)
                        ->setArgument('password', $password)
                        ->setArgument('comment', "Auto-created for {$session->phone_number}")
                );
            }
            
            // Update session
            $session->mikrotik_user = $username;
            $session->save();
            
            // Log success
            file_put_contents('system/uploads/hotspot_users.log', 
                date('Y-m-d H:i:s') . ' - FIXED: Created user: ' . $username . ' for MAC: ' . $session->mac_address . ' - Package: ' . $package->name . PHP_EOL, FILE_APPEND);
            
            echo "✅ Successfully created MikroTik user: $username\n";
            echo "Password: $password\n";
            echo "Time limit: " . ($package->duration_hours > 0 ? $package->duration_hours . " hours" : "Unlimited") . "\n\n";
            
            $successCount++;
            
            // Small delay to prevent overwhelming MikroTik
            usleep(500000); // 0.5 second delay
            
        } catch (Exception $e) {
            echo "❌ Error creating user: " . $e->getMessage() . "\n\n";
            $errorCount++;
            
            file_put_contents('system/uploads/hotspot_users.log', 
                date('Y-m-d H:i:s') . ' - FIXING ERROR for session ' . $session->session_id . ': ' . $e->getMessage() . PHP_EOL, FILE_APPEND);
        }
    }
    
    echo "=== SUMMARY ===\n";
    echo "Successfully created: $successCount users\n";
    echo "Errors: $errorCount\n";
}

// Step 4: Check current hotspot users
echo "\n=== STEP 4: Current Hotspot Users on MikroTik ===\n";
try {
    $printRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/print');
    $users = $client->sendSync($printRequest);
    $userCount = 0;
    
    foreach ($users as $user) {
        $userCount++;
        $username = $user->getProperty('name');
        $profile = $user->getProperty('profile');
        $comment = $user->getProperty('comment');
        echo "$userCount. $username (Profile: $profile) - $comment\n";
    }
    
    echo "\nTotal hotspot users: $userCount\n";
    
} catch (Exception $e) {
    echo "❌ Error listing users: " . $e->getMessage() . "\n";
}

// Step 5: Test customer authentication
echo "\n=== STEP 5: Customer Authentication Test ===\n";
$testSessions = ORM::for_table('tbl_portal_sessions')
    ->where('payment_status', 'completed')
    ->where_not_null('mikrotik_user')
    ->limit(3)
    ->find_many();

foreach ($testSessions as $session) {
    try {
        // Check if user exists on MikroTik
        $printRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/print');
        $printRequest->setQuery(PEAR2\Net\RouterOS\Query::where('name', $session->mikrotik_user));
        $userInfo = $client->sendSync($printRequest);
        
        if ($userInfo->getProperty('.id')) {
            echo "✅ User {$session->mikrotik_user} exists on MikroTik\n";
            echo "   MAC: {$session->mac_address} | Phone: {$session->phone_number}\n";
        } else {
            echo "❌ User {$session->mikrotik_user} NOT found on MikroTik\n";
        }
        
    } catch (Exception $e) {
        echo "❌ Error checking user: " . $e->getMessage() . "\n";
    }
}

echo "\n=== NEXT STEPS ===\n";
echo "1. 🧪 TEST: Connect a device to the hotspot WiFi\n";
echo "2. 🌐 BROWSE: Open a browser and go to any website\n";
echo "3. 🔐 LOGIN: Use the generated username/password to authenticate\n";
echo "4. 📋 CHECK: system/uploads/hotspot_users.log for detailed logs\n";
echo "5. 🔍 MONITOR: Watch for new customer payments and auto-creation\n";

echo "\nInternet access fix completed!\n";
?>