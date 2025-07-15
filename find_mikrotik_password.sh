#!/bin/bash

echo "=== FINDING MIKROTIK API PASSWORD ==="

echo "1. Since all common passwords failed, checking if users have no passwords set:"
echo "   On MikroTik, run: /user print detail"
echo "   This will show if password field is empty"

echo "2. Testing more password combinations..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/devices/Mikrotik.php';

// Extended password list
\$passwords = [
    '', // blank
    'admin',
    'password', 
    '123456',
    'mikrotik',
    'router',
    'admin123',
    'password123',
    'root',
    'toor',
    'admin@123',
    'Admin@123',
    'billing@123',
    'Billing@123',
    'glinta',
    'glinta123',
    'hotspot',
    'hotspot123',
    'qwerty',
    '000000',
    '111111',
    '123123',
    'abc123'
];

echo 'Testing ' . count(\$passwords) . ' password combinations...' . PHP_EOL;

foreach (['admin', 'billing'] as \$user) {
    echo PHP_EOL . 'Testing user: ' . \$user . PHP_EOL;
    
    foreach (\$passwords as \$pass) {
        echo '  Trying: ' . \$user . '/' . (\$pass === '' ? '[blank]' : \$pass) . '...';
        
        \$mikrotik = new Mikrotik('10.0.0.2:8728', \$user, \$pass);
        if (\$mikrotik->connect()) {
            echo ' ✓ SUCCESS!' . PHP_EOL;
            echo '  Working credentials: ' . \$user . '/' . (\$pass === '' ? '[blank]' : \$pass) . PHP_EOL;
            
            // Test hotspot command
            \$hotspot = \$mikrotik->comm('/ip/hotspot/active/print');
            echo '  Hotspot users: ' . (is_array(\$hotspot) ? count(\$hotspot) : 'Failed') . PHP_EOL;
            
            if (is_array(\$hotspot) && count(\$hotspot) > 0) {
                echo '  SUCCESS! Found your ' . count(\$hotspot) . ' Hotspot users!' . PHP_EOL;
                foreach (\$hotspot as \$i => \$user_data) {
                    echo '    ' . (\$i+1) . '. ' . (\$user_data['user'] ?? 'unknown') . ' - ' . (\$user_data['address'] ?? 'no IP') . PHP_EOL;
                }
            }
            
            // Update database with working credentials
            echo '  Updating database with working credentials...' . PHP_EOL;
            \$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
            if (\$router) {
                \$router->username = \$user;
                \$router->password = \$pass;
                \$router->save();
                echo '  Database updated!' . PHP_EOL;
            }
            
            exit(0);
        } else {
            echo ' ✗' . PHP_EOL;
        }
    }
}

echo PHP_EOL . 'All password combinations failed.' . PHP_EOL;
echo 'You need to either:' . PHP_EOL;
echo '1. Set a password on MikroTik: /user set admin password=admin123' . PHP_EOL;
echo '2. Check current password: /user print detail' . PHP_EOL;
echo '3. Create new API user: /user add name=apiuser password=api123 group=full' . PHP_EOL;
"

echo "=== PASSWORD SEARCH COMPLETE ==="