<?php

require_once '/var/www/html/init.php';
require_once '/var/www/html/system/vendor/autoload.php';

echo "=== Simple RouterOS Test ===\n";

$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();

if (!$router) {
    echo "No router found\n";
    exit;
}

echo "Router: " . $router->ip_address . "\n";
echo "User: " . $router->username . "\n";

$parts = explode(':', $router->ip_address);
$host = $parts[0];
$port = isset($parts[1]) ? (int)$parts[1] : 8728;

echo "Host: $host, Port: $port\n";

try {
    $client = new PEAR2\Net\RouterOS\Client($host, $router->username, $router->password, $port);
    echo "SUCCESS: Connected to RouterOS\n";
    
    $request = new PEAR2\Net\RouterOS\Request('/system/identity/print');
    $response = $client->sendSync($request);
    
    if (!empty($response)) {
        echo "SUCCESS: Command executed\n";
        if (isset($response[0]['name'])) {
            echo "Router name: " . $response[0]['name'] . "\n";
        }
    }
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Class: " . get_class($e) . "\n";
}

echo "Done.\n";