<?php
/**
 * Check WireGuard VPN connectivity to MikroTik
 */

echo "=== WireGuard VPN Connectivity Check ===\n\n";

// Check if WireGuard is running
echo "1. Checking WireGuard status...\n";
$wg_status = shell_exec("wg show 2>&1");
if (!empty($wg_status)) {
    echo "✓ WireGuard is running:\n";
    echo $wg_status . "\n";
} else {
    echo "❌ WireGuard is not running or not configured\n";
    echo "   Try: systemctl status wg-quick@wg0\n\n";
}

// Check network interfaces
echo "2. Checking network interfaces...\n";
$interfaces = shell_exec("ip addr show 2>/dev/null | grep -E '(wg|10\.0\.0)'");
if (!empty($interfaces)) {
    echo "✓ WireGuard/VPN interfaces found:\n";
    echo $interfaces . "\n";
} else {
    echo "❌ No WireGuard interfaces found\n\n";
}

// Check routing
echo "3. Checking routing to 10.0.0.0/24...\n";
$routes = shell_exec("ip route | grep '10.0.0' 2>/dev/null");
if (!empty($routes)) {
    echo "✓ Route to 10.0.0.x network found:\n";
    echo $routes . "\n";
} else {
    echo "❌ No route to 10.0.0.x network\n\n";
}

// Test connectivity to MikroTik
echo "4. Testing ping to MikroTik (10.0.0.2)...\n";
$ping_result = shell_exec("ping -c 3 10.0.0.2 2>&1");
if (strpos($ping_result, "bytes from") !== false) {
    echo "✓ Ping to MikroTik successful!\n";
    echo $ping_result . "\n";
} else {
    echo "❌ Ping to MikroTik failed:\n";
    echo $ping_result . "\n";
}

// Test API port
echo "5. Testing MikroTik API port (8728)...\n";
$socket = @fsockopen("10.0.0.2", 8728, $errno, $errstr, 5);
if ($socket) {
    echo "✓ API port 8728 is accessible!\n";
    fclose($socket);
} else {
    echo "❌ Cannot connect to API port 8728\n";
    echo "   Error: $errstr (Code: $errno)\n";
}

// Test with different port combinations
echo "\n6. Testing alternative ports...\n";
$ports = [8728, 8729, 443, 80];
foreach ($ports as $port) {
    $socket = @fsockopen("10.0.0.2", $port, $errno, $errstr, 2);
    if ($socket) {
        echo "✓ Port $port is open\n";
        fclose($socket);
    } else {
        echo "❌ Port $port is closed\n";
    }
}

echo "\n=== Troubleshooting Steps ===\n";
echo "If WireGuard is not working:\n";
echo "1. Check WireGuard service: systemctl status wg-quick@wg0\n";
echo "2. Start WireGuard: systemctl start wg-quick@wg0\n";
echo "3. Check config file: cat /etc/wireguard/wg0.conf\n";
echo "4. Restart WireGuard: systemctl restart wg-quick@wg0\n";
echo "5. Check firewall: iptables -L | grep 10.0.0\n";
?>