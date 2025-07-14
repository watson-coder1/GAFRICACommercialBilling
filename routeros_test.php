<?php

require_once '/var/www/html/init.php';

echo "=== Direct RouterOS Connection Test ===\n";

$router = ORM::for_table('tbl_routers')
    ->where('enabled', 1)
    ->find_one();

if (!$router) {
    echo "❌ No router found\n";
    exit;
}

echo "Router: {$router->ip_address}\n";
echo "User: {$router->username}\n";

try {
    $iport = explode(':', $router->ip_address);
    $host = $iport[0];
    $port = $iport[1] ?? null;
    
    echo "Connecting to: $host:$port\n";
    
    require_once '/var/www/html/system/vendor/autoload.php';
    $client = new PEAR2\Net\RouterOS\Client($host, $router->username, $router->password, $port);
    
    echo "✅ RouterOS connection successful!\n";
    
    $request = new PEAR2\Net\RouterOS\Request('/system/identity/print');
    $response = $client->sendSync($request);
    
    if (!empty($response)) {
        echo "✅ RouterOS command test successful\n";
        echo "Router identity: " . ($response[0]['name'] ?? 'Unknown') . "\n";
    } else {
        echo "⚠️ RouterOS connected but command failed\n";
    }
    
} catch (Exception $e) {
    echo "❌ RouterOS connection failed: " . $e->getMessage() . "\n";
    echo "Error details: " . get_class($e) . "\n";
}

echo "\n=== Testing HotspotAutoLogin ===\n";

// Find a test session
$session = ORM::for_table('tbl_portal_sessions')
    ->where('payment_status', 'completed')
    ->where_not_null('mikrotik_user')
    ->limit(1)
    ->find_one();

if (!$session) {
    echo "❌ No test session found\n";
    exit;
}

$package = ORM::for_table('tbl_hotspot_packages')
    ->where('id', $session->package_id)
    ->find_one();

if (!$package) {
    echo "❌ Package not found\n";
    exit;
}

echo "Testing with: {$session->phone_number}, MAC: {$session->mac_address}\n";

require_once '/var/www/html/system/autoload/HotspotAutoLogin.php';
$result = HotspotAutoLogin::createAndLogin($session, $package);

echo "Result: " . ($result ? 'SUCCESS' : 'FAILED') . "\n";