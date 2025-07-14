<?php
require_once '/var/www/html/init.php';

echo "=== RouterOS API Connection Test ===\n";

$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (!$router) {
    die("❌ No router config found\n");
}

echo "Router: {$router->ip_address}\n";
echo "User: {$router->username}\n";

// Use the same method as MikrotikHotspot class
require_once '/var/www/html/system/devices/MikrotikHotspot.php';
$device = new MikrotikHotspot();

try {
    $client = $device->getClient($router->ip_address, $router->username, $router->password);
    
    if (!$client) {
        echo "❌ Failed to create RouterOS client\n";
        exit;
    }
    
    echo "✅ RouterOS Client created successfully\n";
    
    // Test with a simple identity request
    $request = new PEAR2\Net\RouterOS\Request('/system/identity/print');
    $response = $client->sendSync($request);
    
    echo "✅ API Connected successfully\n";
    echo "Router Identity: " . ($response[0]['name'] ?? 'Unknown') . "\n";
    
    // Test hotspot user listing
    $userRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/user/print');
    $users = $client->sendSync($userRequest);
    echo "Hotspot users found: " . count($users) . "\n";
    
} catch (Throwable $e) {
    echo "❌ API connection failed: " . $e->getMessage() . "\n";
    echo "Error class: " . get_class($e) . "\n";
    echo "Error trace: " . $e->getTraceAsString() . "\n";
}

echo "=== Test Complete ===\n";