<?php
/**
 * Debug Redirect Issues
 * This script helps identify why redirects are happening
 */

// Start session to check session data
session_start();

echo "<h1>Reseller Portal Debug Information</h1>";
echo "<pre>";

// 1. Check Request Information
echo "=== REQUEST INFORMATION ===\n";
echo "REQUEST_URI: " . ($_SERVER['REQUEST_URI'] ?? 'Not set') . "\n";
echo "QUERY_STRING: " . ($_SERVER['QUERY_STRING'] ?? 'Not set') . "\n";
echo "SCRIPT_NAME: " . ($_SERVER['SCRIPT_NAME'] ?? 'Not set') . "\n";
echo "\$_GET: " . print_r($_GET, true) . "\n";

// 2. Check Session Data
echo "\n=== SESSION DATA ===\n";
echo "Session ID: " . session_id() . "\n";
echo "Session Data: " . print_r($_SESSION, true) . "\n";

// 3. Check File Paths
echo "\n=== FILE PATHS ===\n";
echo "Current Directory: " . __DIR__ . "\n";
echo "reseller.php exists: " . (file_exists(__DIR__ . '/reseller.php') ? 'YES' : 'NO') . "\n";
echo "init.php exists: " . (file_exists(__DIR__ . '/init.php') ? 'YES' : 'NO') . "\n";

// 4. Check Database Connection (without loading full init.php)
echo "\n=== DATABASE CONNECTION ===\n";
try {
    // Try to connect to database - use localhost when inside container
    $db_host = 'localhost';
    $db_name = 'phpnuxbill';
    $db_user = 'phpnuxbill';
    $db_pass = 'nuxbill2025!';
    
    $dsn = "mysql:host=$db_host;dbname=$db_name";
    $pdo = new PDO($dsn, $db_user, $db_pass);
    echo "Database connection: SUCCESS\n";
    
    // Check if test reseller exists
    $stmt = $pdo->query("SELECT id, name, subscription_status, expires_at FROM tbl_resellers WHERE name = 'Test Reseller'");
    $reseller = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($reseller) {
        echo "\nTest Reseller Found:\n";
        echo "ID: " . $reseller['id'] . "\n";
        echo "Name: " . $reseller['name'] . "\n";
        echo "Status: " . $reseller['subscription_status'] . "\n";
        echo "Expires At: " . $reseller['expires_at'] . "\n";
        
        // Check if expires_at is in future
        $expires_timestamp = strtotime($reseller['expires_at']);
        $now = time();
        if ($expires_timestamp > $now) {
            echo "Subscription Valid: YES (expires in " . ceil(($expires_timestamp - $now) / 86400) . " days)\n";
        } else {
            echo "Subscription Valid: NO (expired " . ceil(($now - $expires_timestamp) / 86400) . " days ago)\n";
        }
    } else {
        echo "\nTest Reseller: NOT FOUND\n";
    }
    
} catch (Exception $e) {
    echo "Database connection: FAILED - " . $e->getMessage() . "\n";
}

// 5. Check Controllers
echo "\n=== CONTROLLER FILES ===\n";
$controllers = [
    'reseller_login.php',
    'reseller_dashboard.php',
    'reseller_registration.php'
];

foreach ($controllers as $controller) {
    $path = __DIR__ . '/system/controllers/' . $controller;
    echo "$controller: " . (file_exists($path) ? 'EXISTS' : 'MISSING') . "\n";
}

// 6. Parse Routes
echo "\n=== ROUTE PARSING ===\n";
$request_uri = $_SERVER['REQUEST_URI'] ?? '';
$script_name = $_SERVER['SCRIPT_NAME'] ?? '';
$path = str_replace(dirname($script_name), '', $request_uri);
$path = str_replace('/reseller.php', '', $path);
$path = ltrim($path, '/');

echo "Parsed path: '$path'\n";
$routes = $path ? explode('/', $path) : ['login'];
echo "Routes array: " . print_r($routes, true) . "\n";

$action = $routes[0] ?? $_GET['action'] ?? 'login';
echo "Determined action: '$action'\n";

// 7. Check which controller would be loaded
echo "\n=== CONTROLLER ROUTING ===\n";
echo "Based on action '$action', controller would be: ";

switch ($action) {
    case 'authenticate':
    case 'login':
        echo "reseller_login.php\n";
        break;
    case 'register':
    case 'process':
    case 'success':
        echo "reseller_registration.php\n";
        break;
    case 'dashboard':
        echo "reseller_dashboard.php\n";
        break;
    default:
        echo "reseller_login.php (default)\n";
}

echo "\n=== END DEBUG ===\n";
echo "</pre>";

// Add login test form
echo '<h2>Test Login Form</h2>';
echo '<form method="POST" action="reseller.php?action=authenticate">';
echo 'Username: <input type="text" name="username" value="testreseller"><br>';
echo 'Password: <input type="password" name="password" value="test123"><br>';
echo '<input type="submit" value="Test Login">';
echo '</form>';

echo '<h2>Direct Links</h2>';
echo '<a href="reseller.php">reseller.php</a><br>';
echo '<a href="reseller.php?action=login">reseller.php?action=login</a><br>';
echo '<a href="reseller.php?action=register">reseller.php?action=register</a><br>';
?>