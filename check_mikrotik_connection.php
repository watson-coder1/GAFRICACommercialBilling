<?php
/**
 * MikroTik Connection and Statistics Debug Script
 * This script helps diagnose why statistics aren't showing on the dashboard
 */

// Load configuration
require_once 'config.php';
require_once 'system/orm.php';
require_once 'system/autoload/Mikrotik.php';
require_once 'system/devices/MikrotikHotspot.php';

echo "=== MikroTik Connection and Statistics Debug ===\n\n";

// First check WireGuard connectivity
echo "0. WIREGUARD CONNECTIVITY CHECK:\n";
echo str_repeat("-", 50) . "\n";

$wg_status = shell_exec("wg show 2>&1");
if (!empty($wg_status)) {
    echo "✓ WireGuard is running:\n";
    echo $wg_status . "\n";
} else {
    echo "❌ WireGuard is not running\n";
}

// Test ping to MikroTik
echo "\nTesting ping to 10.0.0.2...\n";
$ping_result = shell_exec("ping -c 2 10.0.0.2 2>&1");
if (strpos($ping_result, "bytes from") !== false) {
    echo "✓ Ping successful - MikroTik is reachable\n";
} else {
    echo "❌ Ping failed - MikroTik not reachable\n";
    echo "Ping output: " . substr($ping_result, 0, 200) . "\n";
}

// Test API port
echo "\nTesting API port 8728...\n";
$socket = @fsockopen("10.0.0.2", 8728, $errno, $errstr, 5);
if ($socket) {
    echo "✓ API port 8728 is accessible\n";
    fclose($socket);
} else {
    echo "❌ Cannot connect to API port 8728 - Error: $errstr\n";
}

echo "\n";

// 1. Check router configuration
echo "1. ROUTER CONFIGURATION:\n";
echo str_repeat("-", 50) . "\n";

$routers = ORM::for_table('tbl_routers')->find_many();
if (!$routers) {
    echo "❌ No routers found in database!\n";
    echo "   Please add routers in the admin panel.\n";
} else {
    echo "✓ Found " . count($routers) . " router(s) in database:\n\n";
    
    foreach ($routers as $router) {
        echo "Router: {$router->name}\n";
        echo "  IP Address: {$router->ip_address}\n";
        echo "  Username: {$router->username}\n";
        echo "  Password: " . str_repeat("*", strlen($router->password)) . " (hidden)\n";
        echo "  Enabled: " . ($router->enabled ? "Yes" : "No") . "\n";
        echo "  Description: {$router->description}\n";
        
        // Show actual password for debugging
        echo "  Actual Password: {$router->password}\n";
        
        echo "\n";
    }
}

// 2. Test MikroTik connections
echo "\n2. TESTING MIKROTIK CONNECTIONS:\n";
echo str_repeat("-", 50) . "\n";

foreach ($routers as $router) {
    if (!$router->enabled) {
        echo "⚠️  Router '{$router->name}' is disabled, skipping...\n";
        continue;
    }
    
    echo "\nTesting connection to '{$router->name}' ({$router->ip_address})...\n";
    
    try {
        $device = new MikrotikHotspot();
        $client = $device->getClient($router->ip_address, $router->username, $router->password);
        
        if ($client) {
            echo "✓ Connection successful!\n";
            
            // Get router identity
            try {
                $identity = $client->sendSync(new PEAR2\Net\RouterOS\Request('/system/identity/print'));
                $routerName = $identity->getProperty('name');
                echo "  Router Identity: $routerName\n";
            } catch (Exception $e) {
                echo "  Could not get router identity\n";
            }
            
            // Get hotspot active users
            try {
                $activeUsers = $client->sendSync(new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/print'));
                $count = 0;
                foreach ($activeUsers as $user) {
                    $count++;
                }
                echo "  Active Hotspot Users: $count\n";
            } catch (Exception $e) {
                echo "  Error getting active users: " . $e->getMessage() . "\n";
            }
            
            // Get PPPoE active users
            try {
                $pppoeUsers = $client->sendSync(new PEAR2\Net\RouterOS\Request('/ppp/active/print'));
                $count = 0;
                foreach ($pppoeUsers as $user) {
                    $count++;
                }
                echo "  Active PPPoE Users: $count\n";
            } catch (Exception $e) {
                echo "  Error getting PPPoE users: " . $e->getMessage() . "\n";
            }
            
        } else {
            echo "❌ Connection failed!\n";
        }
    } catch (Exception $e) {
        echo "❌ Connection error: " . $e->getMessage() . "\n";
        
        // Common connection issues
        if (strpos($e->getMessage(), 'Authentication failed') !== false) {
            echo "   → Wrong username or password\n";
        } elseif (strpos($e->getMessage(), 'Unable to connect') !== false) {
            echo "   → Cannot reach router (check IP and firewall)\n";
        } elseif (strpos($e->getMessage(), 'Connection refused') !== false) {
            echo "   → API service not enabled on router\n";
        }
    }
}

// 3. Check database statistics
echo "\n\n3. DATABASE STATISTICS:\n";
echo str_repeat("-", 50) . "\n";

// Hotspot statistics
$hotspot_active = ORM::for_table('tbl_user_recharges')
    ->where('type', 'Hotspot')
    ->where('status', 'on')
    ->where_raw("CONCAT(expiration, ' ', time) > NOW()")
    ->count();

$hotspot_expired = ORM::for_table('tbl_user_recharges')
    ->where('type', 'Hotspot')
    ->where('status', 'on')
    ->where_raw("CONCAT(expiration, ' ', time) <= NOW()")
    ->count();

$hotspot_disabled = ORM::for_table('tbl_user_recharges')
    ->where('type', 'Hotspot')
    ->where('status', 'off')
    ->count();

$hotspot_total = ORM::for_table('tbl_customers')
    ->where('service_type', 'Hotspot')
    ->count();

echo "Hotspot Users:\n";
echo "  Active (not expired): $hotspot_active\n";
echo "  Expired: $hotspot_expired\n";
echo "  Disabled: $hotspot_disabled\n";
echo "  Total Customers: $hotspot_total\n";

// Portal sessions
try {
    $logged_out = ORM::for_table('tbl_portal_sessions')
        ->where('payment_status', 'completed')
        ->where_lt('expires_at', date('Y-m-d H:i:s'))
        ->count();
    echo "  Logged Out (expired sessions): $logged_out\n";
} catch (Exception $e) {
    echo "  Portal sessions table not found\n";
}

// 4. Troubleshooting tips
echo "\n\n4. TROUBLESHOOTING TIPS:\n";
echo str_repeat("-", 50) . "\n";

echo "If statistics are not showing on dashboard:\n\n";

echo "1. Router Connection Issues:\n";
echo "   - Ensure API service is enabled on MikroTik (IP > Services > api)\n";
echo "   - Check firewall rules allow API access (port 8728)\n";
echo "   - Verify router IP is correct and reachable\n";
echo "   - Confirm username/password are correct\n\n";

echo "2. To view router passwords:\n";
echo "   - Add ?show_pass=yes to this URL\n";
echo "   - Check in database: SELECT * FROM tbl_routers;\n\n";

echo "3. Common MikroTik API Issues:\n";
echo "   - API service disabled: Enable in IP > Services\n";
echo "   - API-SSL required: Use port 8729 instead of 8728\n";
echo "   - User permissions: Ensure API user has full permissions\n\n";

echo "4. Dashboard Widget Issues:\n";
echo "   - Check error logs in system/logs/\n";
echo "   - Verify widget files exist in system/widgets/\n";
echo "   - Check PHP error reporting is enabled\n\n";

echo "5. To reset MikroTik password via terminal:\n";
echo "   - Physical access: Press reset button during boot\n";
echo "   - Serial console: /user set admin password=newpassword\n";
echo "   - If you have backup: Restore configuration\n";

echo "\n=== Debug Complete ===\n";