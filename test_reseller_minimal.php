<?php
/**
 * Minimal Reseller Test - No Database Required
 * Tests basic routing and template rendering
 */

// Prevent any output before headers
ob_start();

// Start session
session_start();

echo "<!DOCTYPE html><html><head><title>Minimal Reseller Test</title></head><body>";
echo "<h1>Minimal Reseller Portal Test</h1>";
echo "<pre>";

// Test 1: Basic Info
echo "=== BASIC INFO ===\n";
echo "PHP Version: " . phpversion() . "\n";
echo "Script: " . $_SERVER['SCRIPT_NAME'] . "\n";
echo "Action: " . ($_GET['action'] ?? 'none') . "\n";

// Test 2: Session Test
echo "\n=== SESSION TEST ===\n";
if ($_GET['action'] ?? '' == 'set_session') {
    $_SESSION['test_user'] = 'testreseller';
    $_SESSION['test_time'] = time();
    echo "Session variables set!\n";
    echo '<a href="?action=check_session">Check Session</a>';
} elseif ($_GET['action'] ?? '' == 'check_session') {
    echo "Session ID: " . session_id() . "\n";
    echo "Test User: " . ($_SESSION['test_user'] ?? 'NOT SET') . "\n";
    echo "Test Time: " . ($_SESSION['test_time'] ?? 'NOT SET') . "\n";
    if (isset($_SESSION['test_time'])) {
        echo "Session age: " . (time() - $_SESSION['test_time']) . " seconds\n";
    }
    echo '<a href="?action=clear_session">Clear Session</a>';
} elseif ($_GET['action'] ?? '' == 'clear_session') {
    session_destroy();
    echo "Session cleared!\n";
    echo '<a href="?action=set_session">Set Session Again</a>';
} else {
    echo "Session ID: " . session_id() . "\n";
    echo '<a href="?action=set_session">Set Test Session</a>';
}

// Test 3: Routing Test
echo "\n\n=== ROUTING TEST ===\n";
$actions = ['login', 'register', 'dashboard', 'authenticate'];
foreach ($actions as $action) {
    echo "Action '$action' would load: ";
    switch ($action) {
        case 'authenticate':
        case 'login':
            echo "reseller_login.php\n";
            break;
        case 'register':
            echo "reseller_registration.php\n";
            break;
        case 'dashboard':
            echo "reseller_dashboard.php (requires auth)\n";
            break;
        default:
            echo "reseller_login.php (default)\n";
    }
}

// Test 4: File Check
echo "\n=== FILE CHECK ===\n";
$files_to_check = [
    'reseller.php',
    'init.php',
    'config.php',
    'system/controllers/reseller_login.php',
    'system/controllers/reseller_dashboard.php',
    'system/controllers/reseller_registration.php',
    'ui/reseller/login.tpl',
    'ui/reseller/dashboard.tpl',
    'ui/reseller/registration.tpl'
];

foreach ($files_to_check as $file) {
    echo "$file: " . (file_exists($file) ? "EXISTS" : "MISSING") . "\n";
}

echo "</pre>";

// Test 5: Simple Forms
echo "<h2>Test Actions</h2>";
echo '<p>';
echo '<a href="?action=login">Login Action</a> | ';
echo '<a href="?action=register">Register Action</a> | ';
echo '<a href="?action=dashboard">Dashboard Action</a> | ';
echo '<a href="reseller.php">Go to Reseller Portal</a>';
echo '</p>';

// Test 6: Redirect Test
if ($_GET['action'] ?? '' == 'test_redirect') {
    echo "<p>Testing redirect in 3 seconds...</p>";
    header("Refresh: 3; url=?action=redirect_complete");
} elseif ($_GET['action'] ?? '' == 'redirect_complete') {
    echo "<p style='color: green;'>Redirect completed successfully!</p>";
}
echo '<p><a href="?action=test_redirect">Test Redirect</a></p>';

echo "</body></html>";

ob_end_flush();
?>