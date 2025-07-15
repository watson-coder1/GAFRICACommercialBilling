#!/bin/bash

echo "=== FIXING MIKROTIK API PORT TO 8728 ==="

echo "1. MikroTik service list shows API on port 8728"
echo "   api      8728  0.0.0.0/0               main            20"

echo "2. Updating database router configuration..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
\$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (\$router) {
    echo 'Old IP: ' . \$router->ip_address . PHP_EOL;
    \$router->ip_address = '10.0.0.2:8728';
    \$router->save();
    echo 'Updated IP: ' . \$router->ip_address . PHP_EOL;
} else {
    echo 'No router found to update' . PHP_EOL;
}
"

echo "3. Testing connection to correct API port 8728..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/devices/Mikrotik.php';

\$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (\$router) {
    echo 'Testing connection to: ' . \$router->ip_address . PHP_EOL;
    echo 'Username: ' . \$router->username . PHP_EOL;
    
    \$mikrotik = new Mikrotik(\$router->ip_address, \$router->username, \$router->password);
    
    if (\$mikrotik->connect()) {
        echo '✓ Connection successful to MikroTik API!' . PHP_EOL;
        
        // Test PPPoE active sessions
        \$pppoe = \$mikrotik->comm('/ppp/active/print');
        echo 'PPPoE active sessions: ' . (is_array(\$pppoe) ? count(\$pppoe) : 'Failed') . PHP_EOL;
        
        // Test Hotspot active sessions
        \$hotspot = \$mikrotik->comm('/ip/hotspot/active/print');
        echo 'Hotspot active sessions: ' . (is_array(\$hotspot) ? count(\$hotspot) : 'Failed') . PHP_EOL;
        
        // Show sample PPPoE data
        if (is_array(\$pppoe) && count(\$pppoe) > 0) {
            echo PHP_EOL . 'Sample PPPoE session:' . PHP_EOL;
            foreach (\$pppoe[0] as \$key => \$value) {
                echo '  ' . \$key . ': ' . \$value . PHP_EOL;
            }
        }
        
        // Show sample Hotspot data
        if (is_array(\$hotspot) && count(\$hotspot) > 0) {
            echo PHP_EOL . 'Sample Hotspot session:' . PHP_EOL;
            foreach (\$hotspot[0] as \$key => \$value) {
                echo '  ' . \$key . ': ' . \$value . PHP_EOL;
            }
        }
        
        // Total active users from MikroTik
        \$total_active = (is_array(\$pppoe) ? count(\$pppoe) : 0) + (is_array(\$hotspot) ? count(\$hotspot) : 0);
        echo PHP_EOL . 'Total active users from MikroTik: ' . \$total_active . PHP_EOL;
        
    } else {
        echo '✗ Connection failed to MikroTik API' . PHP_EOL;
    }
}
"

echo "4. Now checking why database shows 0 active users..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';

echo 'Database analysis:' . PHP_EOL;

// Check all user recharges
\$all_recharges = ORM::for_table('tbl_user_recharges')->find_many();
echo 'Total user_recharges records: ' . count(\$all_recharges) . PHP_EOL;

if (count(\$all_recharges) > 0) {
    echo PHP_EOL . 'Sample user_recharges data:' . PHP_EOL;
    foreach (\$all_recharges as \$i => \$recharge) {
        if (\$i < 3) {
            echo '  User: ' . \$recharge->username . PHP_EOL;
            echo '  Status: ' . \$recharge->status . PHP_EOL;
            echo '  Type: ' . \$recharge->type . PHP_EOL;
            echo '  Expiration: ' . \$recharge->expiration . ' ' . \$recharge->time . PHP_EOL;
            echo '  ---' . PHP_EOL;
        }
    }
}

// Check for any status='on' records
\$on_records = ORM::for_table('tbl_user_recharges')->where('status', 'on')->find_many();
echo 'Records with status=on: ' . count(\$on_records) . PHP_EOL;

// Check all status values
\$statuses = ORM::for_table('tbl_user_recharges')->select('status')->group_by('status')->find_many();
echo 'All status values in database: ';
foreach (\$statuses as \$status) {
    echo \$status->status . ' ';
}
echo PHP_EOL;
"

echo "=== MIKROTIK API PORT FIX COMPLETE ==="
echo ""
echo "If MikroTik connection now works, the issue is that:"
echo "1. MikroTik API shows real active users (the 4 you mentioned)"
echo "2. Database has no users with status='on' (hence dashboard shows 0)"
echo "3. Need to sync MikroTik users with database or fix user status"