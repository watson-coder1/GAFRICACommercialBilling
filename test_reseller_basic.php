<?php
/**
 * Basic Test of Reseller System
 * Tests core functionality without full initialization
 */

// Start output buffering to prevent any headers
ob_start();

echo "<h1>Basic Reseller System Test</h1>";
echo "<pre>";

// Test 1: Session
echo "=== SESSION TEST ===\n";
session_start();
echo "Session can start: YES\n";
echo "Session ID: " . session_id() . "\n";

// Test 2: Check if we're in a redirect loop
echo "\n=== REDIRECT LOOP CHECK ===\n";
if (isset($_GET['loop_count'])) {
    $loop_count = intval($_GET['loop_count']);
    echo "Loop count: $loop_count\n";
    if ($loop_count > 5) {
        echo "REDIRECT LOOP DETECTED!\n";
        exit;
    }
} else {
    $loop_count = 0;
}

// Test 3: Simple routing test
echo "\n=== SIMPLE ROUTING TEST ===\n";
$action = $_GET['action'] ?? 'login';
echo "Action requested: $action\n";

// Test 4: Check if Smarty is available
echo "\n=== SMARTY CHECK ===\n";
$smarty_path = __DIR__ . '/system/vendor/smarty/smarty/libs/Smarty.class.php';
echo "Smarty library exists: " . (file_exists($smarty_path) ? 'YES' : 'NO') . "\n";

if (file_exists($smarty_path)) {
    require_once $smarty_path;
    try {
        $ui = new Smarty();
        echo "Smarty can be instantiated: YES\n";
        
        // Set template directories
        $ui->setTemplateDir([
            'reseller' => 'ui/reseller/',
            'admin' => 'ui/ui/admin/',
            'default' => 'ui/ui/'
        ]);
        echo "Template directories set: YES\n";
        
        // Check if login template exists
        $login_template = __DIR__ . '/ui/reseller/login.tpl';
        echo "Login template exists: " . (file_exists($login_template) ? 'YES' : 'NO') . "\n";
        
    } catch (Exception $e) {
        echo "Smarty error: " . $e->getMessage() . "\n";
    }
}

// Test 5: Display simple login form
echo "\n=== SIMPLE LOGIN FORM ===\n";
echo "</pre>";

if ($action == 'authenticate') {
    echo "<h2>Processing Authentication...</h2>";
    echo "<pre>";
    echo "Username: " . ($_POST['username'] ?? 'Not provided') . "\n";
    echo "Password: " . (isset($_POST['password']) ? '[PROVIDED]' : 'Not provided') . "\n";
    echo "</pre>";
    
    // Simple session test
    $_SESSION['test_auth'] = true;
    echo "<p>Session variable set. <a href='?action=check_session'>Check session</a></p>";
    
} elseif ($action == 'check_session') {
    echo "<h2>Session Check</h2>";
    echo "<pre>";
    echo "Session test_auth: " . (isset($_SESSION['test_auth']) ? 'SET' : 'NOT SET') . "\n";
    echo "</pre>";
    
} else {
    // Show simple login form
    ?>
    <h2>Simple Login Test</h2>
    <form method="POST" action="?action=authenticate">
        <p>
            Username: <input type="text" name="username" value="testreseller"><br>
            Password: <input type="password" name="password" value="test123"><br>
            <input type="submit" value="Test Login">
        </p>
    </form>
    <?php
}

echo "<hr>";
echo "<a href='?action=login'>Login</a> | ";
echo "<a href='?action=register'>Register</a> | ";
echo "<a href='debug_redirect.php'>Debug Info</a> | ";
echo "<a href='reseller.php'>Reseller Portal</a>";

ob_end_flush();
?>