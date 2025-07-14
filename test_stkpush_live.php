<?php
/**
 * Live M-Pesa STK Push Test
 * This will test a real STK Push transaction with 1 KES
 */

require_once 'config.php';
require_once 'system/boot.php';

// Test parameters
$test_phone = '254708374149'; // Safaricom test number for sandbox
$test_amount = 1; // 1 KES for testing
$test_session_id = 'test_' . time();

echo "Content-Type: text/html\n\n";
echo "<!DOCTYPE html><html><head><title>M-Pesa STK Push Test</title></head><body>";
echo "<h1>M-Pesa STK Push Live Test</h1>";

try {
    // Create test session record
    $transaction = ORM::for_table('tbl_mpesa_transactions')->create();
    $transaction->session_id = $test_session_id;
    $transaction->phone_number = $test_phone;
    $transaction->amount = $test_amount;
    $transaction->status = 'pending';
    $transaction->created_at = date('Y-m-d H:i:s');
    $transaction->save();
    
    echo "<p><strong>✓ Test transaction created in database</strong></p>";
    echo "<p>Session ID: " . htmlspecialchars($test_session_id) . "</p>";
    echo "<p>Phone: " . htmlspecialchars($test_phone) . "</p>";
    echo "<p>Amount: KES " . $test_amount . "</p>";
    
    // Initialize M-Pesa
    $mpesa = new MpesaIntegration();
    
    if (!$mpesa->isConfigured()) {
        echo "<p><strong>❌ M-Pesa not configured</strong></p>";
        echo "<p>Please configure M-Pesa settings in Admin → Settings → Miscellaneous</p>";
        exit;
    }
    
    echo "<p><strong>✓ M-Pesa is configured</strong></p>";
    
    // Initiate STK Push
    echo "<h2>Initiating STK Push...</h2>";
    $result = $mpesa->initiateSTKPush($test_phone, $test_amount, $test_session_id, 'Test Transaction - 1 KES');
    
    echo "<h3>STK Push Result:</h3>";
    echo "<pre>" . json_encode($result, JSON_PRETTY_PRINT) . "</pre>";
    
    if ($result['success']) {
        echo "<p><strong style='color: green;'>✓ STK Push sent successfully!</strong></p>";
        echo "<p>Check your phone (" . htmlspecialchars($test_phone) . ") for the M-Pesa payment prompt.</p>";
        echo "<p>CheckoutRequestID: " . htmlspecialchars($result['checkout_request_id']) . "</p>";
        
        echo "<h3>What to do next:</h3>";
        echo "<ol>";
        echo "<li>Complete the payment on your phone</li>";
        echo "<li>Check the callback logs at: <code>system/uploads/mpesa_debug.log</code></li>";
        echo "<li>Verify transaction status in database table <code>tbl_mpesa_transactions</code></li>";
        echo "</ol>";
        
        // Display callback URL
        echo "<h3>Callback Configuration:</h3>";
        echo "<p>Callback URL: <strong>" . htmlspecialchars($_c['app_url'] . '/portal/callback') . "</strong></p>";
        echo "<p>This URL will receive the payment confirmation from Safaricom.</p>";
        
    } else {
        echo "<p><strong style='color: red;'>❌ STK Push failed</strong></p>";
        echo "<p>Error: " . htmlspecialchars($result['message']) . "</p>";
        
        echo "<h3>Troubleshooting:</h3>";
        echo "<ul>";
        echo "<li>Check your M-Pesa API credentials</li>";
        echo "<li>Verify the phone number format (254XXXXXXXXX)</li>";
        echo "<li>Ensure you're using the correct environment (sandbox/live)</li>";
        echo "<li>Check if the shortcode is active</li>";
        echo "</ul>";
    }
    
} catch (Exception $e) {
    echo "<p><strong style='color: red;'>❌ Error: " . htmlspecialchars($e->getMessage()) . "</strong></p>";
    echo "<pre>" . htmlspecialchars($e->getTraceAsString()) . "</pre>";
}

echo "<hr>";
echo "<p><small>Test completed at: " . date('Y-m-d H:i:s') . "</small></p>";
echo "<p><small>You can delete this test file after testing: <code>rm test_stkpush_live.php</code></small></p>";
echo "</body></html>";
?>