<?php
echo "Simple connectivity test\n";
echo "Testing ping to 10.0.0.2...\n";
$ping_result = shell_exec("ping -c 2 10.0.0.2 2>&1");
echo "Ping result: " . $ping_result . "\n";

echo "Testing WireGuard status...\n";
$wg_status = shell_exec("wg show 2>&1");
echo "WireGuard status: " . $wg_status . "\n";

echo "Testing API port...\n";
$socket = @fsockopen("10.0.0.2", 8728, $errno, $errstr, 5);
if ($socket) {
    echo "API port accessible\n";
    fclose($socket);
} else {
    echo "API port not accessible: $errstr\n";
}
?>