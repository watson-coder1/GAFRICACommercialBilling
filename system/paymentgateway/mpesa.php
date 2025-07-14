<?php

/**
 * M-Pesa STK Push Callback Handler
 * This file is called by Safaricom when payment status changes
 */

function mpesa_payment_notification() {
    global $config;
    
    // Get callback data from Safaricom
    $data = file_get_contents("php://input");
    
    // Log all callback data for debugging
    $logFile = __DIR__ . "/../uploads/mpesa_callback.log";
    file_put_contents($logFile, date('Y-m-d H:i:s') . " RAW CALLBACK: " . $data . "\n", FILE_APPEND);
    
    // Parse JSON data
    $callbackData = json_decode($data, true);
    
    if (!$callbackData) {
        file_put_contents($logFile, date('Y-m-d H:i:s') . " ERROR: Invalid JSON data\n", FILE_APPEND);
        http_response_code(400);
        echo json_encode(['ResultCode' => 1, 'ResultDesc' => 'Invalid JSON']);
        return;
    }
    
    // Log parsed data
    file_put_contents($logFile, date('Y-m-d H:i:s') . " PARSED: " . print_r($callbackData, true) . "\n", FILE_APPEND);
    
    // Process the callback using existing MpesaIntegration class
    try {
        require_once __DIR__ . '/../autoload/MpesaIntegration.php';
        $mpesa = new MpesaIntegration();
        
        $result = $mpesa->processCallback($callbackData);
        
        if ($result) {
            file_put_contents($logFile, date('Y-m-d H:i:s') . " SUCCESS: Callback processed successfully\n", FILE_APPEND);
            echo json_encode(['ResultCode' => 0, 'ResultDesc' => 'Callback processed successfully']);
        } else {
            file_put_contents($logFile, date('Y-m-d H:i:s') . " ERROR: Callback processing failed\n", FILE_APPEND);
            echo json_encode(['ResultCode' => 1, 'ResultDesc' => 'Processing failed']);
        }
        
    } catch (Exception $e) {
        file_put_contents($logFile, date('Y-m-d H:i:s') . " EXCEPTION: " . $e->getMessage() . "\n", FILE_APPEND);
        echo json_encode(['ResultCode' => 1, 'ResultDesc' => 'Server error']);
    }
}

// If called directly (for testing)
if (basename(__FILE__) == basename($_SERVER['SCRIPT_NAME'])) {
    mpesa_payment_notification();
}