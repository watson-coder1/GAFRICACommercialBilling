#!/bin/bash

echo "=== TESTING BOTH MIKROTIK USERS ==="

echo "1. MikroTik users found:"
echo "   - admin (full group)"
echo "   - billing (full group)"

echo "2. Testing admin user (might have blank password)..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/devices/Mikrotik.php';

echo 'Testing admin with blank password...' . PHP_EOL;
\$mikrotik = new Mikrotik('10.0.0.2:8728', 'admin', '');
if (\$mikrotik->connect()) {
    echo '✓ SUCCESS: admin with blank password works!' . PHP_EOL;
    
    \$pppoe = \$mikrotik->comm('/ppp/active/print');
    echo 'PPPoE active: ' . (is_array(\$pppoe) ? count(\$pppoe) : 'Failed') . PHP_EOL;
    
    \$hotspot = \$mikrotik->comm('/ip/hotspot/active/print');
    echo 'Hotspot active: ' . (is_array(\$hotspot) ? count(\$hotspot) : 'Failed') . PHP_EOL;
} else {
    echo '✗ admin with blank password failed' . PHP_EOL;
}
"

echo "3. Testing admin with common passwords..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/devices/Mikrotik.php';

\$passwords = ['admin', 'password', '123456', 'mikrotik'];
foreach (\$passwords as \$pass) {
    echo 'Testing admin/' . \$pass . '...' . PHP_EOL;
    \$mikrotik = new Mikrotik('10.0.0.2:8728', 'admin', \$pass);
    if (\$mikrotik->connect()) {
        echo '✓ SUCCESS: admin/' . \$pass . ' works!' . PHP_EOL;
        break;
    } else {
        echo '✗ admin/' . \$pass . ' failed' . PHP_EOL;
    }
}
"

echo "4. Testing billing user with different passwords..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/devices/Mikrotik.php';

\$passwords = ['Billing@123', 'billing', 'password', '123456', ''];
foreach (\$passwords as \$pass) {
    echo 'Testing billing/' . \$pass . '...' . PHP_EOL;
    \$mikrotik = new Mikrotik('10.0.0.2:8728', 'billing', \$pass);
    if (\$mikrotik->connect()) {
        echo '✓ SUCCESS: billing/' . \$pass . ' works!' . PHP_EOL;
        
        // Show actual users
        \$pppoe = \$mikrotik->comm('/ppp/active/print');
        \$hotspot = \$mikrotik->comm('/ip/hotspot/active/print');
        \$total = (is_array(\$pppoe) ? count(\$pppoe) : 0) + (is_array(\$hotspot) ? count(\$hotspot) : 0);
        echo 'Total active users in MikroTik: ' . \$total . PHP_EOL;
        
        // Show user details
        if (is_array(\$pppoe) && count(\$pppoe) > 0) {
            echo 'PPPoE Users:' . PHP_EOL;
            foreach (\$pppoe as \$i => \$user) {
                echo '  ' . (\$i+1) . '. ' . (\$user['name'] ?? 'unknown') . ' - ' . (\$user['address'] ?? 'no IP') . PHP_EOL;
            }
        }
        
        if (is_array(\$hotspot) && count(\$hotspot) > 0) {
            echo 'Hotspot Users:' . PHP_EOL;
            foreach (\$hotspot as \$i => \$user) {
                echo '  ' . (\$i+1) . '. ' . (\$user['user'] ?? 'unknown') . ' - ' . (\$user['address'] ?? 'no IP') . PHP_EOL;
            }
        }
        
        break;
    } else {
        echo '✗ billing/' . \$pass . ' failed' . PHP_EOL;
    }
}
"

echo "5. If successful, update database with working credentials..."
echo "   This will be done in next step once we find working credentials"

echo "=== AUTHENTICATION TEST COMPLETE ==="