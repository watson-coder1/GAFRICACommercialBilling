<?php
/**
 * Debug MikroTik User Creation Issues
 * This script will help identify why users aren't being created automatically
 */

require_once 'config.php';
require_once 'system/boot.php';

echo "=== DEBUGGING MIKROTIK USER CREATION ===\n";
echo "Date: " . date('Y-m-d H:i:s') . "\n\n";

// 1. Check completed payments without MikroTik users
echo "=== STEP 1: Check Recent Completed Payments ===\n";
$recentPayments = ORM::for_table('tbl_portal_sessions')
    ->where('payment_status', 'completed')
    ->order_by_desc('created_at')
    ->limit(10)
    ->find_many();

echo "Recent completed payments:\n";
foreach ($recentPayments as $session) {
    echo "- Session: {$session->session_id}\n";
    echo "  Phone: {$session->phone_number}\n";
    echo "  MAC: {$session->mac_address}\n";
    echo "  MikroTik User: " . ($session->mikrotik_user ?: 'NONE') . "\n";
    echo "  Created: {$session->created_at}\n\n";
}

// 2. Check MikroTik router connection
echo "=== STEP 2: Test MikroTik Connection ===\n";
$router = ORM::for_table('tbl_routers')
    ->where('enabled', 1)
    ->find_one();

if (!$router) {
    echo "❌ CRITICAL: No enabled router found!\n";
    exit;
}

echo "Router: {$router->name}\n";
echo "IP: {$router->ip_address}\n";
echo "Username: {$router->username}\n";

try {
    require_once 'system/devices/MikrotikHotspot.php';
    $device = new MikrotikHotspot();
    $client = $device->getClient($router->ip_address, $router->username, $router->password);
    
    if ($client) {
        echo "✅ MikroTik connection: SUCCESS\n";
        
        // Test listing existing users
        $printRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/print');
        $printRequest->setArgument('.proplist', 'name,profile,comment');
        $users = $client->sendSync($printRequest);
        
        echo "Current hotspot users:\n";
        $userCount = 0;
        foreach ($users as $user) {
            $userCount++;
            $name = $user->getProperty('name');
            $profile = $user->getProperty('profile');
            $comment = $user->getProperty('comment');
            echo "  $userCount. $name (Profile: $profile) - $comment\n";
        }
        echo "Total users: $userCount\n\n";
        
    } else {
        echo "❌ MikroTik connection: FAILED\n";
        exit;
    }
} catch (Exception $e) {
    echo "❌ MikroTik connection error: " . $e->getMessage() . "\n";
    exit;
}

// 3. Check hotspot packages
echo "=== STEP 3: Check Hotspot Packages ===\n";
$packages = ORM::for_table('tbl_hotspot_packages')
    ->where('status', 'active')
    ->find_many();

if (count($packages) == 0) {
    echo "❌ No active packages found!\n";
} else {
    echo "Active packages:\n";
    foreach ($packages as $package) {
        echo "  - {$package->name}: KSh {$package->price} ({$package->duration_hours}hrs)\n";
    }
}

// 4. Test manual user creation
echo "\n=== STEP 4: Test Manual User Creation ===\n";
$testSession = $recentPayments[0] ?? null;

if ($testSession && !$testSession->mikrotik_user) {
    echo "Testing user creation for session: {$testSession->session_id}\n";
    
    $package = ORM::for_table('tbl_hotspot_packages')
        ->where('id', $testSession->package_id)
        ->find_one();
        
    if (!$package) {
        echo "❌ Package not found for session\n";
    } else {
        echo "Package: {$package->name}\n";
        
        try {
            // Test the exact same process as MpesaIntegration
            $username = 'test_' . substr(str_replace(':', '', $testSession->mac_address), -6) . '_' . time();
            $password = substr(md5($username . time()), 0, 8);
            
            echo "Test username: $username\n";
            echo "Test password: $password\n";
            
            // Create customer data
            $customer = [
                'username' => $username,
                'password' => $password,
                'mac_address' => $testSession->mac_address,
                'fullname' => 'Test User',
                'email' => 'test@example.com',
                'id' => 0
            ];
            
            // Create plan data
            $plan = [
                'name_plan' => $package->name,
                'typebp' => 'Limited',
                'limit_type' => 'Time_Limit',
                'time_limit' => $package->duration_hours,
                'time_unit' => 'Hrs',
                'shared_users' => 1,
                'routers' => $router->id
            ];
            
            echo "Creating test user...\n";
            
            // Try to create the user
            $device->add_customer($customer, $plan);
            
            echo "✅ Test user created successfully!\n";
            echo "You should see user '$username' in MikroTik now.\n";
            
        } catch (Exception $e) {
            echo "❌ Error creating test user: " . $e->getMessage() . "\n";
            
            // Check if it's a profile issue
            try {
                echo "Checking if profile '{$package->name}' exists...\n";
                $profileRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/profile/print');
                $profileRequest->setQuery(PEAR2\Net\RouterOS\Query::where('name', $package->name));
                $profiles = $client->sendSync($profileRequest);
                
                $profileExists = false;
                foreach ($profiles as $profile) {
                    $profileExists = true;
                    break;
                }
                
                if (!$profileExists) {
                    echo "❌ Profile '{$package->name}' does not exist in MikroTik!\n";
                    echo "Creating profile...\n";
                    
                    $addProfileRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/profile/add');
                    $client->sendSync(
                        $addProfileRequest
                            ->setArgument('name', $package->name)
                            ->setArgument('shared-users', 1)
                    );
                    
                    echo "✅ Profile created, try user creation again.\n";
                } else {
                    echo "✅ Profile exists.\n";
                }
                
            } catch (Exception $e2) {
                echo "❌ Profile check error: " . $e2->getMessage() . "\n";
            }
        }
    }
}

// 5. Check callback processing
echo "\n=== STEP 5: Check M-Pesa Callbacks ===\n";
$callbacks = glob('system/uploads/mpesa_callbacks.log');
if ($callbacks) {
    echo "Recent M-Pesa callbacks:\n";
    $lines = file('system/uploads/mpesa_callbacks.log');
    $recentLines = array_slice($lines, -10);
    foreach ($recentLines as $line) {
        echo "  " . trim($line) . "\n";
    }
} else {
    echo "❌ No M-Pesa callback log found\n";
}

// 6. Check hotspot user logs
echo "\n=== STEP 6: Check Hotspot User Logs ===\n";
$userLogs = glob('system/uploads/hotspot_users.log');
if ($userLogs) {
    echo "Recent hotspot user creation attempts:\n";
    $lines = file('system/uploads/hotspot_users.log');
    $recentLines = array_slice($lines, -10);
    foreach ($recentLines as $line) {
        echo "  " . trim($line) . "\n";
    }
} else {
    echo "❌ No hotspot user log found\n";
}

echo "\n=== RECOMMENDATIONS ===\n";
if (count($recentPayments) > 0) {
    $sessionsWithoutUsers = 0;
    foreach ($recentPayments as $session) {
        if (!$session->mikrotik_user) $sessionsWithoutUsers++;
    }
    
    if ($sessionsWithoutUsers > 0) {
        echo "🔧 Run fix_internet_access.php to create missing users\n";
    }
}

echo "📋 Check MikroTik profiles match package names exactly\n";
echo "🔍 Review logs above for specific error messages\n";
echo "⚡ Test connectivity: router IP, username, password\n";

echo "\nDebugging completed.\n";
?>