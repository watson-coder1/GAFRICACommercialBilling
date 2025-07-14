<?php
/**
 * Fix Existing Paid Users
 * Processes all users who paid but aren't logged into the hotspot
 */

// Handle CLI environment
if (php_sapi_name() === 'cli') {
    $_SERVER['HTTP_HOST'] = 'glintaafrica.com';
    $_SERVER['SERVER_PORT'] = '80';
    $_SERVER['SCRIPT_NAME'] = '/index.php';
    $_SERVER['HTTPS'] = 'off';
}

require_once 'config.php';
require_once 'system/boot.php';

echo "=== FIXING EXISTING PAID USERS ===\n";
echo "Date: " . date('Y-m-d H:i:s') . "\n\n";

try {
    // Find all users who paid but don't have MikroTik users created
    $paidSessions = ORM::for_table('tbl_portal_sessions')
        ->where('payment_status', 'completed')
        ->where_null('mikrotik_user')
        ->order_by_desc('created_at')
        ->find_many();
    
    echo "Found " . count($paidSessions) . " paid users without MikroTik accounts\n\n";
    
    if (count($paidSessions) == 0) {
        echo "✅ No users need fixing - all paid users already have MikroTik accounts\n";
        exit;
    }
    
    $fixed = 0;
    $errors = 0;
    
    foreach ($paidSessions as $session) {
        echo "Processing: {$session->phone_number} (Session: {$session->session_id})\n";
        echo "  Payment: {$session->payment_status} | Created: {$session->created_at}\n";
        
        try {
            // Get package details
            $package = ORM::for_table('tbl_hotspot_packages')
                ->where('id', $session->package_id)
                ->find_one();
            
            if (!$package) {
                echo "  ❌ Package not found - skipping\n\n";
                $errors++;
                continue;
            }
            
            echo "  Package: {$package->name} - KES {$package->price} ({$package->duration_hours}h)\n";
            
            // Generate MAC address if missing
            if (empty($session->mac_address)) {
                $phone = preg_replace('/[^0-9]/', '', $session->phone_number);
                $phone = substr($phone, -8);
                $phone = str_pad($phone, 8, '0', STR_PAD_LEFT);
                $mac = '02:' . substr($phone, 0, 2) . ':' . substr($phone, 2, 2) . ':' . substr($phone, 4, 2) . ':' . substr($phone, 6, 2) . ':' . substr($phone, -2);
                
                $session->mac_address = $mac;
                echo "  Generated MAC: $mac\n";
            }
            
            // Generate IP address if missing
            if (empty($session->ip_address)) {
                $session->ip_address = '10.0.1.' . (100 + ($session->id % 150));
                echo "  Generated IP: {$session->ip_address}\n";
            }
            
            // Set expiry if missing
            if (empty($session->expires_at)) {
                $session->expires_at = date('Y-m-d H:i:s', strtotime('+' . $package->duration_hours . ' hours'));
                echo "  Set expiry: {$session->expires_at}\n";
            }
            
            $session->save();
            
            // Now create MikroTik user and auto-login
            require_once 'system/autoload/HotspotAutoLogin.php';
            $result = HotspotAutoLogin::createAndLogin($session, $package);
            
            if ($result) {
                echo "  ✅ SUCCESS: MikroTik user created and logged in\n";
                echo "  Username: {$session->mikrotik_user}\n";
                $fixed++;
            } else {
                echo "  ❌ FAILED: Could not create MikroTik user\n";
                $errors++;
            }
            
        } catch (Exception $e) {
            echo "  ❌ ERROR: " . $e->getMessage() . "\n";
            $errors++;
        }
        
        echo "\n";
    }
    
    echo "🎯 SUMMARY:\n";
    echo "Total processed: " . count($paidSessions) . "\n";
    echo "✅ Successfully fixed: $fixed\n";
    echo "❌ Errors: $errors\n";
    
    if ($fixed > 0) {
        echo "\n🎉 $fixed users have been fixed!\n";
        echo "These users should now have internet access automatically.\n";
        echo "They should appear in MikroTik Active Users list.\n";
    }
    
    if ($errors > 0) {
        echo "\n⚠️  $errors users had errors - check logs for details\n";
    }
    
    echo "\n📋 Next Steps:\n";
    echo "1. Check MikroTik → IP → Hotspot → Active to see logged in users\n";
    echo "2. Check logs: system/uploads/hotspot_autologin.log\n";
    echo "3. Users should now get internet access when they connect to WiFi\n";
    
} catch (Exception $e) {
    echo "❌ Script failed: " . $e->getMessage() . "\n";
    echo "Stack trace:\n" . $e->getTraceAsString() . "\n";
}

echo "\n✅ Fix completed at: " . date('Y-m-d H:i:s') . "\n";