#!/bin/bash

echo "=== TESTING MIKROTIK API AUTHENTICATION ==="

echo "1. Current credentials in database:"
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
\$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (\$router) {
    echo 'IP: ' . \$router->ip_address . PHP_EOL;
    echo 'Username: ' . \$router->username . PHP_EOL;
    echo 'Password: ' . \$router->password . PHP_EOL;
}
"

echo "2. Testing socket connection to port 8728..."
docker exec glinta-web php -r "
\$socket = @fsockopen('10.0.0.2', 8728, \$errno, \$errstr, 10);
if (\$socket) {
    echo '✓ Socket connection successful to port 8728' . PHP_EOL;
    fclose(\$socket);
} else {
    echo '✗ Socket connection failed: ' . \$errstr . ' (Error: ' . \$errno . ')' . PHP_EOL;
}
"

echo "3. Testing raw MikroTik API protocol..."
docker exec glinta-web php -r "
\$socket = @fsockopen('10.0.0.2', 8728, \$errno, \$errstr, 10);
if (\$socket) {
    echo 'Connected to MikroTik API port' . PHP_EOL;
    
    // Send login command
    fwrite(\$socket, chr(6) . '/login');
    fwrite(\$socket, chr(0));
    
    // Read response
    \$response = fread(\$socket, 1024);
    if (\$response) {
        echo 'Got response from MikroTik: ' . bin2hex(\$response) . PHP_EOL;
    }
    
    fclose(\$socket);
} else {
    echo 'Cannot connect to test raw protocol' . PHP_EOL;
}
"

echo "4. Common MikroTik API username/password combinations to try:"
echo "   - admin/admin (default)"
echo "   - admin/[blank]"
echo "   - admin/password"
echo "   - billing/Billing@123 (current)"

echo "5. From your MikroTik, check API users with:"
echo "   /user print"
echo "   /user print detail"

echo "6. Check if API requires different authentication:"
echo "   /ip service print"
echo "   /system user print"

echo "7. Testing if web credentials work for API..."
echo "   Your web interface might use different credentials than API"

echo "8. Also check if database has ANY user data..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';

// Check if database has any users at all
\$customers = ORM::for_table('tbl_customers')->find_many();
echo 'Total customers: ' . count(\$customers) . PHP_EOL;

\$users = ORM::for_table('tbl_users')->find_many();
echo 'Total users: ' . count(\$users) . PHP_EOL;

\$recharges = ORM::for_table('tbl_user_recharges')->find_many();
echo 'Total user_recharges: ' . count(\$recharges) . PHP_EOL;

// Check table structure
try {
    \$tables = ORM::for_table('information_schema.tables')
        ->where('table_schema', 'nuxbilling')
        ->where_like('table_name', 'tbl_%')
        ->find_many();
    echo 'Database tables: ';
    foreach (\$tables as \$table) {
        echo \$table->table_name . ' ';
    }
    echo PHP_EOL;
} catch (Exception \$e) {
    echo 'Cannot check tables: ' . \$e->getMessage() . PHP_EOL;
}
"

echo "=== AUTHENTICATION TEST COMPLETE ==="
echo ""
echo "Next steps:"
echo "1. Check MikroTik user credentials with: /user print"
echo "2. Try common admin credentials"
echo "3. If database is empty, need to create test users"
echo "4. The 4 users you see in MikroTik are connected but not in billing database"