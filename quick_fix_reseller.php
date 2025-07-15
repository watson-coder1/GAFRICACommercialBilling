<?php

/**
 * Quick Fix for Reseller Login Template Issue
 * This creates a simplified version that should work immediately
 */

echo "=== CREATING QUICK FIX FOR RESELLER LOGIN ===\n";

// 1. Create a bulletproof template fallback
$template_fallback = '<?php
// Bulletproof template fallback
global $template, $ui;

if (!isset($template) || !is_object($template)) {
    require_once __DIR__ . "/system/vendor/smarty/smarty/libs/Smarty.class.php";
    
    $template = new Smarty();
    $template->setTemplateDir(__DIR__ . \'/ui/\');
    $template->setCompileDir(__DIR__ . \'/ui/compiled/\');
    $template->setCacheDir(__DIR__ . \'/ui/cache/\');
    $template->setConfigDir(__DIR__ . \'/ui/conf/\');
    
    // Make directories writable
    @chmod(__DIR__ . \'/ui/compiled/\', 0755);
    @chmod(__DIR__ . \'/ui/cache/\', 0755);
    
    // Set basic variables
    $template->assign("_title", "Glinta Reseller Portal");
    $template->assign("_system_name", "Glinta Hotspot Billing");
    $template->assign("_admin", ["fullname" => "Reseller Admin"]);
}

// Ensure $ui compatibility
if (!isset($ui)) {
    $ui = $template;
}
?>';

file_put_contents(__DIR__ . '/template_fallback.php', $template_fallback);

// 2. Create a working reseller login controller
$reseller_login = '<?php

/**
 * Reseller Login Controller - Fixed Version
 */

// Ensure template is available
require_once __DIR__ . "/../../template_fallback.php";

$action = $routes[1] ?? \'login\';

switch ($action) {
    case \'login\':
        handleResellerLogin();
        break;
    case \'authenticate\':
        handleResellerAuthenticate();
        break;
    case \'logout\':
        handleResellerLogout();
        break;
    default:
        handleResellerLogin();
}

function handleResellerLogin() {
    global $template;
    
    // Double-check template is available
    if (!isset($template) || !is_object($template)) {
        require_once __DIR__ . "/../../template_fallback.php";
    }
    
    // Check if already logged in
    if (isset($_SESSION[\'reseller_admin_id\'])) {
        header(\'Location: \' . RESELLER_URL . \'/dashboard\');
        exit;
    }
    
    // Set template variables
    $template->assign(\'_title\', \'Reseller Login - Glinta Hotspot\');
    $template->assign(\'_system_name\', \'Glinta Hotspot Billing\');
    $template->assign(\'login_url\', RESELLER_URL . \'/authenticate\');
    $template->assign(\'error\', $_GET[\'error\'] ?? \'\');
    $template->assign(\'message\', $_GET[\'message\'] ?? \'\');
    
    // Try to display reseller template, fall back to simple HTML
    try {
        $template->display(\'reseller/login.tpl\');
    } catch (Exception $e) {
        // Simple HTML fallback
        echo \'<!DOCTYPE html>
<html>
<head>
    <title>Reseller Login</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; }
        .container { max-width: 400px; margin: 0 auto; }
        .form-group { margin: 15px 0; }
        input { width: 100%; padding: 10px; margin: 5px 0; }
        button { background: #007bff; color: white; padding: 10px 20px; border: none; }
        .error { color: red; }
        .message { color: green; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reseller Login</h2>
        <p>Welcome to Glinta Hotspot Billing</p>\';
        
        if (!empty($_GET[\'error\'])) {
            echo \'<div class="error">Error: \' . htmlspecialchars($_GET[\'error\']) . \'</div>\';
        }
        
        if (!empty($_GET[\'message\'])) {
            echo \'<div class="message">Info: \' . htmlspecialchars($_GET[\'message\']) . \'</div>\';
        }
        
        echo \'<form method="post" action="\' . RESELLER_URL . \'/authenticate">
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>\';
    }
}

function handleResellerAuthenticate() {
    $username = $_POST[\'username\'] ?? \'\';
    $password = $_POST[\'password\'] ?? \'\';
    
    if (empty($username) || empty($password)) {
        header(\'Location: \' . RESELLER_URL . \'/login?error=\' . urlencode(\'Username and password are required\'));
        exit;
    }
    
    // Find reseller admin
    $admin = ORM::for_table(\'tbl_reseller_admins\')
        ->where(\'username\', $username)
        ->where(\'status\', \'active\')
        ->find_one();
    
    if (!$admin || !password_verify($password, $admin->password)) {
        header(\'Location: \' . RESELLER_URL . \'/login?error=\' . urlencode(\'Invalid username or password\'));
        exit;
    }
    
    // Set session
    $_SESSION[\'reseller_admin_id\'] = $admin->id;
    $_SESSION[\'reseller_id\'] = $admin->reseller_id;
    $_SESSION[\'reseller_username\'] = $admin->username;
    $_SESSION[\'reseller_fullname\'] = $admin->fullname;
    
    // Update last login
    $admin->last_login = date(\'Y-m-d H:i:s\');
    $admin->save();
    
    // Redirect to dashboard
    header(\'Location: \' . RESELLER_URL . \'/dashboard\');
    exit;
}

function handleResellerLogout() {
    // Clear session
    unset($_SESSION[\'reseller_admin_id\']);
    unset($_SESSION[\'reseller_id\']);
    unset($_SESSION[\'reseller_username\']);
    unset($_SESSION[\'reseller_fullname\']);
    
    header(\'Location: \' . RESELLER_URL . \'/login?message=\' . urlencode(\'Logged out successfully\'));
    exit;
}

?>';

file_put_contents(__DIR__ . '/system/controllers/reseller_login.php', $reseller_login);

echo "✓ Created bulletproof template_fallback.php\n";
echo "✓ Created working reseller_login.php with HTML fallback\n";

echo "\n=== DOCKER COMMANDS TO RUN ===\n";
echo "# First, fix the git state in container:\n";
echo "docker exec glinta-web bash -c 'cd /var/www/html && git stash && git pull origin master'\n";
echo "\n# Then copy the fixed files:\n";
echo "docker cp template_fallback.php glinta-web:/var/www/html/template_fallback.php\n";
echo "docker cp system/controllers/reseller_login.php glinta-web:/var/www/html/system/controllers/reseller_login.php\n";
echo "\n# Test the fix:\n";
echo "curl https://glintaafrica.com/reseller.php\n";

?>