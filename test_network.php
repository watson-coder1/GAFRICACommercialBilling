<?php
/**
 * Test network connectivity to MikroTik router
 */

echo "=== Network Connectivity Test ===\n\n";

// Test basic connectivity to router IP
$router_ip = "10.0.0.2";
$api_port = 8728;

echo "1. Testing ping to {$router_ip}...\n";
$ping_result = exec("ping -c 3 {$router_ip} 2>&1", $ping_output, $ping_code);
if ($ping_code === 0) {
    echo "✓ Ping successful - router is reachable\n";
} else {
    echo "❌ Ping failed - router not reachable\n";
    echo "   This suggests the server cannot access the VPN network\n";
}

echo "\n2. Testing API port {$api_port}...\n";
$socket = @fsockopen($router_ip, $api_port, $errno, $errstr, 5);
if ($socket) {
    echo "✓ API port {$api_port} is open and accessible\n";
    fclose($socket);
} else {
    echo "❌ Cannot connect to API port {$api_port}\n";
    echo "   Error: {$errstr} (Code: {$errno})\n";
}

echo "\n3. Checking server network interfaces...\n";
$interfaces = exec("ip addr show 2>/dev/null | grep -E 'inet.*scope global'", $if_output);
foreach ($if_output as $line) {
    if (preg_match('/inet (\d+\.\d+\.\d+\.\d+)/', $line, $matches)) {
        echo "  Server IP: {$matches[1]}\n";
    }
}

echo "\n4. Checking for WireGuard interface...\n";
$wg_check = exec("ip addr show 2>/dev/null | grep wg", $wg_output);
if (!empty($wg_output)) {
    echo "✓ WireGuard interface found:\n";
    foreach ($wg_output as $line) {
        echo "  {$line}\n";
    }
} else {
    echo "❌ No WireGuard interface found\n";
    echo "   The server needs WireGuard configured to access 10.0.0.x network\n";
}

echo "\n5. Checking routing table for 10.0.0.0/24...\n";
$route_check = exec("ip route | grep '10.0.0'", $route_output);
if (!empty($route_output)) {
    echo "✓ Route to 10.0.0.x network found:\n";
    foreach ($route_output as $line) {
        echo "  {$line}\n";
    }
} else {
    echo "❌ No route to 10.0.0.x network\n";
    echo "   Need to configure routing to VPN network\n";
}

echo "\n=== Recommendations ===\n";
echo "To fix MikroTik connectivity:\n";
echo "1. Install WireGuard on the server\n";
echo "2. Configure WireGuard client with your VPN config\n";
echo "3. Ensure routing to 10.0.0.0/24 network via WireGuard\n";
echo "4. Alternative: Use MikroTik's public IP if available\n";
echo "5. Alternative: Configure port forwarding for API port\n";
?>