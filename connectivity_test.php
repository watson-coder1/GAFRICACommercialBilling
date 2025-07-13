<?php
/**
 * Simple connectivity test endpoint
 * Returns JSON response indicating if user has internet access
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

// Simple test - if they can reach this page, they have internet
$response = [
    'connected' => true,
    'message' => 'Internet access confirmed',
    'timestamp' => date('Y-m-d H:i:s'),
    'success' => true
];

echo json_encode($response);
?>