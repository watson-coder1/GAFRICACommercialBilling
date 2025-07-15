<?php
/**
 * Simplified Reseller Portal - For debugging redirect issues
 */

// Start session first
session_start();

// Basic error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Prevent any accidental output
ob_start();

echo "<!DOCTYPE html><html><head><title>Reseller Debug</title></head><body>";
echo "<h1>Reseller Portal Debug</h1><pre>";

// Step 1: Check basic requirements
echo "=== STEP 1: BASIC CHECKS ===\n";
echo "Session ID: " . session_id() . "\n";
echo "Action: " . ($_GET['action'] ?? 'none') . "\n";

// Step 2: Load minimal requirements
echo "\n=== STEP 2: LOADING CONFIG ===\n";
if (file_exists('config.php')) {
    require_once 'config.php';
    echo "Config loaded successfully\n";
    echo "DB Host: $db_host\n";
    echo "DB Name: $db_name\n";
} else {
    die("ERROR: config.php not found!");
}

// Step 3: Test database connection
echo "\n=== STEP 3: DATABASE TEST ===\n";
try {
    require_once 'system/orm.php';
    ORM::configure("mysql:host=$db_host;dbname=$db_name");
    ORM::configure('username', $db_user);
    ORM::configure('password', $db_pass);
    
    // Test query
    $test = ORM::for_table('tbl_resellers')->find_one();
    echo "Database connection: SUCCESS\n";
    echo "Found reseller: " . ($test ? "YES (ID: {$test->id})" : "NO") . "\n";
} catch (Exception $e) {
    echo "Database error: " . $e->getMessage() . "\n";
}

// Step 4: Handle actions
echo "\n=== STEP 4: ACTION HANDLING ===\n";
$action = $_GET['action'] ?? 'login';
echo "Processing action: $action\n";

switch ($action) {
    case 'authenticate':
        echo "\n--- AUTHENTICATION ---\n";
        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';
        echo "Username: $username\n";
        echo "Password: " . (empty($password) ? '[EMPTY]' : '[PROVIDED]') . "\n";
        
        if ($username && $password) {
            // Find admin
            $admin = ORM::for_table('tbl_reseller_admins')
                ->where('username', $username)
                ->where('status', 'active')
                ->find_one();
            
            if ($admin && password_verify($password, $admin->password)) {
                echo "Login successful!\n";
                $_SESSION['reseller_admin_id'] = $admin->id;
                $_SESSION['reseller_id'] = $admin->reseller_id;
                $_SESSION['reseller_username'] = $admin->username;
                echo "Session set - redirecting to dashboard in 3 seconds...\n";
                echo "</pre><p>Login successful! <a href='?action=dashboard'>Go to Dashboard</a></p>";
                // Don't redirect yet - let user click
            } else {
                echo "Login failed - invalid credentials\n";
            }
        } else {
            echo "Username and password required\n";
        }
        break;
        
    case 'dashboard':
        echo "\n--- DASHBOARD CHECK ---\n";
        if (isset($_SESSION['reseller_admin_id'])) {
            echo "Logged in as admin ID: " . $_SESSION['reseller_admin_id'] . "\n";
            echo "Reseller ID: " . $_SESSION['reseller_id'] . "\n";
            echo "Username: " . $_SESSION['reseller_username'] . "\n";
            echo "</pre><h2>Dashboard</h2><p>Welcome to the dashboard!</p>";
            echo "<p><a href='?action=logout'>Logout</a></p>";
        } else {
            echo "Not logged in - would redirect to login\n";
            echo "</pre><p>You need to login first. <a href='?action=login'>Go to Login</a></p>";
        }
        break;
        
    case 'logout':
        session_destroy();
        echo "Logged out successfully\n";
        echo "</pre><p>Logged out. <a href='?action=login'>Login Again</a></p>";
        break;
        
    case 'login':
    default:
        echo "\n--- LOGIN FORM ---\n";
        echo "</pre>";
        ?>
        <h2>Login</h2>
        <form method="POST" action="?action=authenticate">
            <p>
                Username: <input type="text" name="username" value="testreseller"><br>
                Password: <input type="password" name="password" value="test123"><br>
                <input type="submit" value="Login">
            </p>
        </form>
        <p><a href="?action=register">Register</a> | <a href="reseller.php">Go to Full Portal</a></p>
        <?php
        break;
}

echo "</body></html>";

// End output buffering and send
ob_end_flush();
?>