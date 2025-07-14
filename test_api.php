<?php
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/vendor/autoload.php';

echo "=== RouterOS API Connection Test ===\n";

$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (!$router) {
    die("❌ No router config found\n");
}

echo "Router: {$router->ip_address}\n";
echo "User: {$router->username}\n";

list($h, $p) = explode(':', $router->ip_address);
echo "Connecting to: $h:$p\n";

try {
    $client = new RouterOS\Client([
        'host' => $h,
        'user' => $router->username,
        'pass' => $router->password,
        'port' => (int)$p,
    ]);
    
    echo "✅ RouterOS Client created successfully\n";
    
    $resp = $client->query(new RouterOS\Query('/system/identity/print'))->read();
    
    echo "✅ API Connected successfully\n";
    echo "Router Identity: " . ($resp[0]['name'] ?? 'Unknown') . "\n";
    
    // Test hotspot user listing
    $users = $client->query(new RouterOS\Query('/ip/hotspot/user/print'))->read();
    echo "Hotspot users found: " . count($users) . "\n";
    
} catch (Throwable $e) {
    echo "❌ API connection failed: " . $e->getMessage() . "\n";
    echo "Error class: " . get_class($e) . "\n";
}

echo "=== Test Complete ===\n";