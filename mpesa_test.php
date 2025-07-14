<?php
/**
 * Direct M-Pesa STK Push Test
 * Bypasses all routing and authentication
 */

// Direct include without routing
$_c = array();
include 'config.php';

// Bootstrap minimal system
if (file_exists('system/autoload/Database.php')) {
    require_once 'system/autoload/Database.php';
}
if (file_exists('system/autoload/ORM.php')) {
    require_once 'system/autoload/ORM.php';
}
if (file_exists('system/autoload/MpesaIntegration.php')) {
    require_once 'system/autoload/MpesaIntegration.php';
}

// Initialize database
try {
    ORM::configure('mysql:host=' . $_c['host'] . ';dbname=' . $_c['db_name']);
    ORM::configure('username', $_c['username']);
    ORM::configure('password', $_c['password']);
    ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));
} catch (Exception $e) {
    die('Database connection failed: ' . $e->getMessage());
}

// Test parameters
$test_phone = '254708374149'; // Safaricom test number
$test_amount = 1; // 1 KES for testing
$test_session_id = 'test_' . time();

header('Content-Type: text/html; charset=utf-8');
?>
<!DOCTYPE html>
<html>
<head>
    <title>M-Pesa STK Push Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        .info { background: #f0f8ff; padding: 15px; border-left: 4px solid #0066cc; margin: 10px 0; }
        .warning { background: #fff3cd; padding: 15px; border-left: 4px solid #ffc107; margin: 10px 0; }
        pre { background: #f5f5f5; padding: 15px; border: 1px solid #ddd; overflow-x: auto; }
        h1 { color: #333; }
        h2 { color: #666; }
    </style>
</head>
<body>
    <h1>🚀 M-Pesa STK Push Live Test</h1>
    
    <?php
    try {
        echo "<h2>📋 Step 1: Creating Test Transaction</h2>";
        
        // Create test session record
        $transaction = ORM::for_table('tbl_mpesa_transactions')->create();
        $transaction->session_id = $test_session_id;
        $transaction->phone_number = $test_phone;
        $transaction->amount = $test_amount;
        $transaction->status = 'pending';
        $transaction->created_at = date('Y-m-d H:i:s');
        $transaction->save();
        
        echo "<p class='success'>✓ Test transaction created successfully</p>";
        echo "<div class='info'>";
        echo "<p><strong>Test Transaction Details:</strong></p>";
        echo "<p>📱 Phone: " . htmlspecialchars($test_phone) . "</p>";
        echo "<p>💰 Amount: KES " . $test_amount . "</p>";
        echo "<p>🆔 Session ID: " . htmlspecialchars($test_session_id) . "</p>";
        echo "<p>⏰ Created: " . date('Y-m-d H:i:s') . "</p>";
        echo "</div>";
        
        echo "<h2>⚙️ Step 2: Checking M-Pesa Configuration</h2>";
        
        // Initialize M-Pesa
        $mpesa = new MpesaIntegration();
        
        if (!$mpesa->isConfigured()) {
            echo "<p class='error'>❌ M-Pesa is not configured</p>";
            echo "<div class='warning'>";
            echo "<p><strong>Configuration Required:</strong></p>";
            echo "<p>Please configure M-Pesa settings in Admin → Settings → Miscellaneous</p>";
            echo "<p>Required settings: Consumer Key, Consumer Secret, Passkey, Shortcode, Environment</p>";
            echo "</div>";
            exit;
        }
        
        echo "<p class='success'>✓ M-Pesa configuration found and validated</p>";
        
        echo "<h2>🚀 Step 3: Initiating STK Push</h2>";
        echo "<p>Sending payment request to phone: <strong>" . htmlspecialchars($test_phone) . "</strong></p>";
        
        // Initiate STK Push
        $result = $mpesa->initiateSTKPush($test_phone, $test_amount, $test_session_id, 'Test Payment - Glinta Hotspot');
        
        echo "<h3>📊 STK Push Response:</h3>";
        echo "<pre>" . htmlspecialchars(json_encode($result, JSON_PRETTY_PRINT)) . "</pre>";
        
        if ($result['success']) {
            echo "<div class='info'>";
            echo "<p class='success'>🎉 STK Push sent successfully!</p>";
            echo "<p><strong>CheckoutRequestID:</strong> " . htmlspecialchars($result['checkout_request_id']) . "</p>";
            echo "</div>";
            
            echo "<h2>📱 Step 4: Complete Payment on Phone</h2>";
            echo "<div class='warning'>";
            echo "<p><strong>Action Required:</strong></p>";
            echo "<ol>";
            echo "<li>Check your phone (" . htmlspecialchars($test_phone) . ") for M-Pesa payment prompt</li>";
            echo "<li>Enter your M-Pesa PIN to complete the payment</li>";
            echo "<li>Wait for the payment confirmation</li>";
            echo "</ol>";
            echo "</div>";
            
            echo "<h2>🔍 Step 5: Monitoring</h2>";
            echo "<div class='info'>";
            echo "<p><strong>How to monitor the transaction:</strong></p>";
            echo "<ol>";
            echo "<li><strong>Callback URL:</strong> " . htmlspecialchars($_c['app_url'] . '/portal/callback') . "</li>";
            echo "<li><strong>Debug Log:</strong> <code>system/uploads/mpesa_debug.log</code></li>";
            echo "<li><strong>Integration Log:</strong> <code>system/uploads/mpesa_integration_debug.log</code></li>";
            echo "<li><strong>Database:</strong> Check <code>tbl_mpesa_transactions</code> table</li>";
            echo "</ol>";
            echo "</div>";
            
            echo "<h2>✅ Test Status: PAYMENT SENT</h2>";
            echo "<p class='success'>The STK Push has been sent successfully. Complete the payment on your phone to finish the test.</p>";
            
        } else {
            echo "<div class='warning'>";
            echo "<p class='error'>❌ STK Push failed</p>";
            echo "<p><strong>Error Message:</strong> " . htmlspecialchars($result['message']) . "</p>";
            echo "</div>";
            
            echo "<h3>🔧 Troubleshooting Steps:</h3>";
            echo "<ol>";
            echo "<li>Verify M-Pesa API credentials in Admin settings</li>";
            echo "<li>Check phone number format (should be 254XXXXXXXXX)</li>";
            echo "<li>Confirm environment setting (sandbox/live)</li>";
            echo "<li>Verify shortcode is active</li>";
            echo "<li>Check Safaricom Developer Portal configuration</li>";
            echo "</ol>";
        }
        
    } catch (Exception $e) {
        echo "<div class='warning'>";
        echo "<p class='error'><strong>❌ System Error:</strong> " . htmlspecialchars($e->getMessage()) . "</p>";
        echo "</div>";
        echo "<h3>🔍 Debug Information:</h3>";
        echo "<pre>" . htmlspecialchars($e->getTraceAsString()) . "</pre>";
    }
    ?>
    
    <hr>
    <div style="margin-top: 30px; padding: 15px; background: #f8f9fa; border: 1px solid #dee2e6;">
        <h3>📝 Test Summary</h3>
        <p><strong>Test File:</strong> mpesa_test.php</p>
        <p><strong>Completed:</strong> <?php echo date('Y-m-d H:i:s'); ?></p>
        <p><strong>Cleanup:</strong> You can delete this file after testing: <code>rm mpesa_test.php</code></p>
    </div>
</body>
</html>