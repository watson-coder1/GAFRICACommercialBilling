<?php
/**
 * Test specific router connection
 */

// Load configuration
require_once 'config.php';
require_once 'system/orm.php';
require_once 'system/autoload/Mikrotik.php';

echo "=== Testing Router Connection ===\n\n";

// Get the BlueRibbon router
$router = ORM::for_table('tbl_routers')
    ->where('name', 'BlueRibbon Kiganjo')
    ->find_one();

if (!$router) {
    echo "❌ Router 'BlueRibbon Kiganjo' not found in database!\n";
    
    // Show all routers
    echo "\nAll routers in database:\n";
    $all_routers = ORM::for_table('tbl_routers')->find_many();
    foreach ($all_routers as $r) {
        echo "- Name: {$r->name}, IP: {$r->ip_address}, Enabled: " . ($r->enabled ? 'Yes' : 'No') . "\n";
    }
    exit;
}

echo "✓ Router found in database:\n";
echo "  Name: {$router->name}\n";
echo "  IP: {$router->ip_address}\n";
echo "  Username: {$router->username}\n";
echo "  Password: {$router->password}\n";
echo "  Enabled: " . ($router->enabled ? 'Yes' : 'No') . "\n\n";

if (!$router->enabled) {
    echo "⚠️  Router is disabled. Enable it in admin panel.\n";
    exit;
}

// Test connection
echo "Testing connection to {$router->ip_address}...\n";

try {
    $client = Mikrotik::getClient($router->ip_address, $router->username, $router->password);
    
    if ($client) {
        echo "✓ Connection successful!\n\n";
        
        // Test getting hotspot active users
        echo "Testing hotspot active users...\n";
        try {
            $hotspotRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/print');
            $hotspotResults = $client->sendSync($hotspotRequest);
            
            $count = 0;
            echo "Active Hotspot Users:\n";
            foreach ($hotspotResults as $result) {
                $count++;
                $user = $result->getProperty('user');
                $address = $result->getProperty('address');
                echo "  {$count}. User: {$user}, IP: {$address}\n";
            }
            
            if ($count == 0) {
                echo "  No active hotspot users found.\n";
            }
            
            echo "\nTotal active hotspot users: {$count}\n";
            
        } catch (Exception $e) {
            echo "❌ Error getting hotspot users: " . $e->getMessage() . "\n";
        }
        
        // Test getting PPPoE active users
        echo "\nTesting PPPoE active users...\n";
        try {
            $pppoeRequest = new PEAR2\Net\RouterOS\Request('/ppp/active/print');
            $pppoeResults = $client->sendSync($pppoeRequest);
            
            $count = 0;
            echo "Active PPPoE Users:\n";
            foreach ($pppoeResults as $result) {
                $count++;
                $user = $result->getProperty('name');
                $address = $result->getProperty('address');
                echo "  {$count}. User: {$user}, IP: {$address}\n";
            }
            
            if ($count == 0) {
                echo "  No active PPPoE users found.\n";
            }
            
            echo "\nTotal active PPPoE users: {$count}\n";
            
        } catch (Exception $e) {
            echo "❌ Error getting PPPoE users: " . $e->getMessage() . "\n";
        }
        
        // Test router identity
        echo "\nTesting router identity...\n";
        try {
            $identityRequest = new PEAR2\Net\RouterOS\Request('/system/identity/print');
            $identityResults = $client->sendSync($identityRequest);
            
            foreach ($identityResults as $result) {
                $name = $result->getProperty('name');
                echo "  Router Identity: {$name}\n";
            }
            
        } catch (Exception $e) {
            echo "❌ Error getting router identity: " . $e->getMessage() . "\n";
        }
        
    } else {
        echo "❌ Failed to connect to router!\n";
    }
    
} catch (Exception $e) {
    echo "❌ Connection error: " . $e->getMessage() . "\n";
    
    // Common solutions
    echo "\nCommon issues:\n";
    echo "1. Check if MikroTik API is enabled: IP > Services > api (port 8728)\n";
    echo "2. Check if firewall allows API access\n";
    echo "3. Verify username/password are correct\n";
    echo "4. Check if router is reachable from this server\n";
    echo "5. Try using IP without port (remove :8728) if using default port\n";
}

echo "\n=== Test Complete ===\n";