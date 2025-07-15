#!/bin/bash

echo "=== DEBUGGING MIKROTIK CONNECTION ==="

echo "1. Testing network connectivity to MikroTik..."
docker exec glinta-web ping -c 3 10.0.0.2

echo "2. Testing if port 8080 is open..."
docker exec glinta-web timeout 10 telnet 10.0.0.2 8080

echo "3. Testing common MikroTik API ports..."
echo "Testing port 8728 (default API)..."
docker exec glinta-web timeout 5 telnet 10.0.0.2 8728

echo "Testing port 8080 (configured)..."
docker exec glinta-web timeout 5 telnet 10.0.0.2 8080

echo "Testing port 80 (HTTP)..."
docker exec glinta-web timeout 5 telnet 10.0.0.2 80

echo "Testing port 443 (HTTPS)..."
docker exec glinta-web timeout 5 telnet 10.0.0.2 443

echo "4. Checking what ports are accessible via nmap..."
docker exec glinta-web nmap -p 8080,8728,80,443,22 10.0.0.2

echo "5. Testing different connection methods..."
docker exec glinta-web php -r "
echo 'Testing basic socket connection...' . PHP_EOL;
\$socket = @fsockopen('10.0.0.2', 8080, \$errno, \$errstr, 10);
if (\$socket) {
    echo '✓ Socket connection successful on port 8080' . PHP_EOL;
    fclose(\$socket);
} else {
    echo '✗ Socket connection failed: ' . \$errstr . ' (Error: ' . \$errno . ')' . PHP_EOL;
}

echo 'Testing port 8728...' . PHP_EOL;
\$socket = @fsockopen('10.0.0.2', 8728, \$errno, \$errstr, 10);
if (\$socket) {
    echo '✓ Socket connection successful on port 8728' . PHP_EOL;
    fclose(\$socket);
} else {
    echo '✗ Socket connection failed: ' . \$errstr . ' (Error: ' . \$errno . ')' . PHP_EOL;
}
"

echo "6. Checking if MikroTik might be using different authentication..."
docker exec glinta-web php -r "
echo 'Router credentials:' . PHP_EOL;
echo 'IP: 10.0.0.2:8080' . PHP_EOL;
echo 'Username: billing' . PHP_EOL;
echo 'Password: Billing@123' . PHP_EOL;
echo PHP_EOL;
echo 'Note: These credentials might be for web interface, not API' . PHP_EOL;
"

echo "7. Testing HTTP connection (in case 8080 is web interface)..."
docker exec glinta-web curl -m 10 -v http://10.0.0.2:8080/ || echo "HTTP connection failed"

echo "=== CONNECTION DEBUGGING COMPLETE ==="
echo ""
echo "Next steps:"
echo "1. Check if MikroTik API service is enabled"
echo "2. Verify API credentials are correct"
echo "3. Check if MikroTik is using different API port"
echo "4. Consider if firewall is blocking connections"