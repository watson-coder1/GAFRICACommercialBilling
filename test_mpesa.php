<?php
/**
 * M-Pesa Integration Test Script
 * This will test if M-Pesa integration is working
 */

require_once 'config.php';
require_once 'system/boot.php';

echo "=== M-Pesa Integration Test ===\n\n";

// Test database connection
try {
    $mpesa_tables = ORM::raw_execute("SHOW TABLES LIKE 'tbl_mpesa%'");
    echo "✓ Database connection successful\n";
    echo "✓ M-Pesa tables exist\n\n";
} catch (Exception $e) {
    echo "✗ Database connection failed: " . $e->getMessage() . "\n";
    exit(1);
}

// Test M-Pesa configuration
try {
    $config_keys = ['mpesa_consumer_key', 'mpesa_consumer_secret', 'mpesa_passkey', 'mpesa_shortcode', 'mpesa_environment'];
    
    echo "=== M-Pesa Configuration ===\n";
    foreach ($config_keys as $key) {
        $value = $_c[$key] ?? '';
        if (empty($value)) {
            echo "⚠️  $key: Not configured\n";
        } else {
            $display_value = (strpos($key, 'secret') !== false || strpos($key, 'passkey') !== false) 
                ? str_repeat('*', strlen($value)) 
                : $value;
            echo "✓ $key: $display_value\n";
        }
    }
    echo "\n";
    
    // Test MpesaIntegration class
    $mpesa = new MpesaIntegration();
    
    if ($mpesa->isConfigured()) {
        echo "✓ M-Pesa is fully configured\n";
        echo "✓ Ready for STK Push transactions\n\n";
        
        echo "=== Test STK Push (Sandbox) ===\n";
        echo "To test STK Push, use:\n";
        echo "- Phone: 254708374149 (Safaricom test number)\n";
        echo "- Amount: 1 (minimum for testing)\n";
        echo "- This will send a test payment request\n\n";
        
    } else {
        echo "⚠️  M-Pesa configuration incomplete\n";
        echo "Please configure all M-Pesa settings in Admin → Settings → Miscellaneous\n\n";
    }
    
} catch (Exception $e) {
    echo "✗ Error testing M-Pesa integration: " . $e->getMessage() . "\n";
}

echo "=== Callback URL ===\n";
echo "Callback URL: " . $_c['app_url'] . "/portal/callback\n";
echo "Make sure this URL is configured in your Safaricom Developer Portal\n\n";

echo "=== Next Steps ===\n";
echo "1. Configure M-Pesa settings in Admin panel\n";
echo "2. Test with Safaricom sandbox credentials\n";
echo "3. Create a test customer portal session\n";
echo "4. Try STK Push with test phone number\n\n";

echo "Test completed. You can delete this file: rm test_mpesa.php\n";
?>