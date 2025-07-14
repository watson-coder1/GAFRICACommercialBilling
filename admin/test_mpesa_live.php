<?php
/**
 * Live M-Pesa STK Push Test - Admin Version
 */

// Go up one directory to access config
require_once '../config.php';
require_once '../system/boot.php';

// Test parameters
$test_phone = '254708374149'; // Safaricom test number
$test_amount = 1; // 1 KES for testing
$test_session_id = 'test_' . time();

?>
<!DOCTYPE html>
<html>
<head>
    <title>M-Pesa STK Push Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .success { color: green; }
        .error { color: red; }
        .info { background: #f0f8ff; padding: 10px; border-left: 4px solid #0066cc; }
        pre { background: #f5f5f5; padding: 10px; border: 1px solid #ddd; }
    </style>
</head>
<body>
    <h1>M-Pesa STK Push Live Test</h1>
    
    <?php
    try {
        // Create test session record
        $transaction = ORM::for_table('tbl_mpesa_transactions')->create();
        $transaction->session_id = $test_session_id;
        $transaction->phone_number = $test_phone;
        $transaction->amount = $test_amount;
        $transaction->status = 'pending';
        $transaction->created_at = date('Y-m-d H:i:s');
        $transaction->save();
        
        echo "<p class='success'><strong>✓ Test transaction created in database</strong></p>";
        echo "<div class='info'>";
        echo "<p><strong>Test Details:</strong></p>";
        echo "<p>Session ID: " . htmlspecialchars($test_session_id) . "</p>";
        echo "<p>Phone: " . htmlspecialchars($test_phone) . "</p>";
        echo "<p>Amount: KES " . $test_amount . "</p>";
        echo "</div>";
        
        // Initialize M-Pesa
        $mpesa = new MpesaIntegration();
        
        if (!$mpesa->isConfigured()) {
            echo "<p class='error'><strong>❌ M-Pesa not configured</strong></p>";
            echo "<p>Please configure M-Pesa settings in Admin → Settings → Miscellaneous</p>";
            exit;
        }
        
        echo "<p class='success'><strong>✓ M-Pesa is configured</strong></p>";
        
        // Initiate STK Push
        echo "<h2>Initiating STK Push...</h2>";
        $result = $mpesa->initiateSTKPush($test_phone, $test_amount, $test_session_id, 'Test Transaction - 1 KES');
        
        echo "<h3>STK Push Result:</h3>";
        echo "<pre>" . htmlspecialchars(json_encode($result, JSON_PRETTY_PRINT)) . "</pre>";
        
        if ($result['success']) {
            echo "<p class='success'><strong>✓ STK Push sent successfully!</strong></p>";
            echo "<div class='info'>";
            echo "<p><strong>Next Steps:</strong></p>";
            echo "<ol>";
            echo "<li>Check your phone (" . htmlspecialchars($test_phone) . ") for the M-Pesa payment prompt</li>";
            echo "<li>Complete the payment (enter your M-Pesa PIN)</li>";
            echo "<li>Monitor callback logs at: <code>system/uploads/mpesa_debug.log</code></li>";
            echo "<li>Check transaction status in database table <code>tbl_mpesa_transactions</code></li>";
            echo "</ol>";
            echo "<p><strong>CheckoutRequestID:</strong> " . htmlspecialchars($result['checkout_request_id']) . "</p>";
            echo "</div>";
            
            // Display callback URL
            echo "<h3>Callback Configuration:</h3>";
            echo "<p><strong>Callback URL:</strong> " . htmlspecialchars($_c['app_url'] . '/portal/callback') . "</p>";
            echo "<p>This URL will receive the payment confirmation from Safaricom.</p>";
            
        } else {
            echo "<p class='error'><strong>❌ STK Push failed</strong></p>";
            echo "<p class='error'>Error: " . htmlspecialchars($result['message']) . "</p>";
            
            echo "<h3>Troubleshooting:</h3>";
            echo "<ul>";
            echo "<li>Check your M-Pesa API credentials in Admin → Settings → Miscellaneous</li>";
            echo "<li>Verify the phone number format (254XXXXXXXXX)</li>";
            echo "<li>Ensure you're using the correct environment (sandbox/live)</li>";
            echo "<li>Check if the shortcode is active</li>";
            echo "<li>Verify your Safaricom Developer Portal configuration</li>";
            echo "</ul>";
        }
        
    } catch (Exception $e) {
        echo "<p class='error'><strong>❌ Error: " . htmlspecialchars($e->getMessage()) . "</strong></p>";
        echo "<pre>" . htmlspecialchars($e->getTraceAsString()) . "</pre>";
    }
    ?>
    
    <hr>
    <p><small>Test completed at: <?php echo date('Y-m-d H:i:s'); ?></small></p>
    <p><small>You can delete this test file after testing: <code>rm admin/test_mpesa_live.php</code></small></p>
</body>
</html>