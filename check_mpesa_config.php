<?php
/**
 * Check Mpesa Configuration Script
 */

require_once 'config.php';
require_once 'system/boot.php';

echo "=== Mpesa Configuration Check ===\n\n";

// Check configuration values
$config_keys = ['mpesa_consumer_key', 'mpesa_consumer_secret', 'mpesa_passkey', 'mpesa_shortcode', 'mpesa_environment'];

echo "Current Configuration:\n";
foreach ($config_keys as $key) {
    $value = $_c[$key] ?? '';
    if (empty($value)) {
        echo "❌ $key: NOT SET\n";
    } else {
        if (strpos($key, 'secret') !== false || strpos($key, 'passkey') !== false) {
            echo "✅ $key: " . str_repeat('*', strlen($value)) . " (hidden)\n";
        } else {
            echo "✅ $key: $value\n";
        }
    }
}

echo "\nEnvironment: " . ($_c['mpesa_environment'] ?? 'Not set') . "\n";
echo "Callback URL: " . ($_c['mpesa_callback_url'] ?? ($_c['app_url'] . '/portal/callback')) . "\n";

// Test Mpesa Integration class
echo "\n=== Testing MpesaIntegration Class ===\n";
try {
    $mpesa = new MpesaIntegration();
    
    if ($mpesa->isConfigured()) {
        echo "✅ Mpesa is configured and ready\n";
        
        // Test access token (without making actual STK push)
        echo "\nTesting API Connection...\n";
        $reflection = new ReflectionClass($mpesa);
        $method = $reflection->getMethod('getAccessToken');
        $method->setAccessible(true);
        
        $token = $method->invoke($mpesa);
        if ($token) {
            echo "✅ Successfully obtained access token\n";
            echo "✅ API credentials are valid\n";
        } else {
            echo "❌ Failed to get access token - check your credentials\n";
        }
    } else {
        echo "❌ Mpesa is NOT configured\n";
        echo "Please set all required configuration values in Admin → Settings → Miscellaneous\n";
    }
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}

echo "\n=== Troubleshooting Tips ===\n";
echo "1. Ensure all Mpesa credentials are entered in Admin → Settings → Miscellaneous\n";
echo "2. For production, change environment from 'sandbox' to 'live'\n";
echo "3. Check that your callback URL is accessible from the internet\n";
echo "4. Verify your Safaricom API credentials are correct\n";
echo "5. Check the portal debug log at: system/uploads/portal_debug.log\n";

echo "\nDone. You can delete this file: rm check_mpesa_config.php\n";
?>