#!/bin/bash

echo "=== DIAGNOSING MIKROTIK MISMATCH ==="

echo "1. Checking MikroTik routers in database..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';

\$routers = ORM::for_table('tbl_routers')->where('enabled', 1)->find_many();
echo 'Active routers: ' . count(\$routers) . PHP_EOL;

foreach (\$routers as \$router) {
    echo 'Router: ' . \$router->name . ' (' . \$router->ip_address . ':' . \$router->username . ')' . PHP_EOL;
}
"

echo "2. Testing MikroTik API connection..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/devices/Mikrotik.php';

\$routers = ORM::for_table('tbl_routers')->where('enabled', 1)->find_many();

foreach (\$routers as \$router) {
    echo 'Testing router: ' . \$router->name . ' (' . \$router->ip_address . ')' . PHP_EOL;
    
    \$mikrotik = new Mikrotik(\$router->ip_address, \$router->username, \$router->password);
    
    if (\$mikrotik->connect()) {
        echo '  ✓ Connection successful' . PHP_EOL;
        
        // Test PPPoE users
        \$pppoe = \$mikrotik->comm('/ppp/active/print');
        echo '  PPPoE active: ' . (is_array(\$pppoe) ? count(\$pppoe) : 'Failed') . PHP_EOL;
        
        // Test Hotspot users
        \$hotspot = \$mikrotik->comm('/ip/hotspot/active/print');
        echo '  Hotspot active: ' . (is_array(\$hotspot) ? count(\$hotspot) : 'Failed') . PHP_EOL;
        
        // Show sample data
        if (is_array(\$pppoe) && count(\$pppoe) > 0) {
            echo '  Sample PPPoE user: ' . print_r(\$pppoe[0], true) . PHP_EOL;
        }
        
        if (is_array(\$hotspot) && count(\$hotspot) > 0) {
            echo '  Sample Hotspot user: ' . print_r(\$hotspot[0], true) . PHP_EOL;
        }
        
    } else {
        echo '  ✗ Connection failed' . PHP_EOL;
    }
    
    echo PHP_EOL;
}
"

echo "3. Checking database user data..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';

// Check user_recharges table structure
\$recharges = ORM::for_table('tbl_user_recharges')->limit(3)->find_many();
echo 'Sample user_recharges data:' . PHP_EOL;
foreach (\$recharges as \$recharge) {
    echo '  User: ' . \$recharge->username . ', Status: ' . \$recharge->status . ', Expiration: ' . \$recharge->expiration . ' ' . \$recharge->time . PHP_EOL;
}

echo PHP_EOL;

// Check customers table
\$customers = ORM::for_table('tbl_customers')->limit(3)->find_many();
echo 'Sample customers data:' . PHP_EOL;
foreach (\$customers as \$customer) {
    echo '  Customer: ' . \$customer->username . ', Service: ' . \$customer->service_type . PHP_EOL;
}
"

echo "4. Checking current time vs expiration logic..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';

echo 'Current time: ' . date('Y-m-d H:i:s') . PHP_EOL;

// Test the actual query we're using
\$active = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->where_raw('CONCAT(expiration, \\' \\', time) > NOW()')
    ->find_many();

echo 'Active users found: ' . count(\$active) . PHP_EOL;

foreach (\$active as \$user) {
    \$expires = \$user->expiration . ' ' . \$user->time;
    echo '  User: ' . \$user->username . ', Expires: ' . \$expires . PHP_EOL;
}

echo PHP_EOL;

// Check if the issue is with the query
\$all_on = ORM::for_table('tbl_user_recharges')
    ->where('status', 'on')
    ->find_many();

echo 'All users with status=on: ' . count(\$all_on) . PHP_EOL;
"

echo "=== DIAGNOSIS COMPLETE ==="
echo "This will show exactly why MikroTik shows 4 users but dashboard shows 0."