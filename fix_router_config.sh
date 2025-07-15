#!/bin/bash

echo "=== FIXING MIKROTIK ROUTER CONFIGURATION ==="

echo "1. Current router configuration:"
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
\$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (\$router) {
    echo 'Router: ' . \$router->name . PHP_EOL;
    echo 'IP: ' . \$router->ip_address . PHP_EOL;
    echo 'Username: ' . \$router->username . PHP_EOL;
    echo 'Current API Port: ' . \$router->api_port . PHP_EOL;
} else {
    echo 'No routers found' . PHP_EOL;
}
"

echo "2. Updating router to use correct MikroTik API port (8728)..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
\$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (\$router) {
    \$router->api_port = 8728;
    \$router->save();
    echo '✓ Updated router API port to 8728' . PHP_EOL;
} else {
    echo '✗ No router found to update' . PHP_EOL;
}
"

echo "3. Testing connection with correct port..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/devices/Mikrotik.php';

\$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (\$router) {
    echo 'Testing connection to: ' . \$router->ip_address . ':8728' . PHP_EOL;
    
    \$mikrotik = new Mikrotik(\$router->ip_address, \$router->username, \$router->password);
    
    if (\$mikrotik->connect()) {
        echo '✓ Connection successful!' . PHP_EOL;
        
        // Test PPPoE
        \$pppoe = \$mikrotik->comm('/ppp/active/print');
        echo 'PPPoE active: ' . (is_array(\$pppoe) ? count(\$pppoe) : 'Failed') . PHP_EOL;
        
        // Test Hotspot
        \$hotspot = \$mikrotik->comm('/ip/hotspot/active/print');
        echo 'Hotspot active: ' . (is_array(\$hotspot) ? count(\$hotspot) : 'Failed') . PHP_EOL;
        
    } else {
        echo '✗ Connection still failed' . PHP_EOL;
    }
}
"

echo "4. Checking database users status..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';

echo 'All user_recharges records:' . PHP_EOL;
\$all = ORM::for_table('tbl_user_recharges')->find_many();
foreach (\$all as \$user) {
    echo '  ' . \$user->username . ' - Status: ' . \$user->status . ' - Type: ' . \$user->type . ' - Expires: ' . \$user->expiration . ' ' . \$user->time . PHP_EOL;
}

echo PHP_EOL . 'Total records: ' . count(\$all) . PHP_EOL;
"

echo "=== ROUTER CONFIG FIX COMPLETE ==="