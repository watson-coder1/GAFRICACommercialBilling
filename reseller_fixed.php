<?php
/**
 * Reseller Portal Entry Point (Fixed)
 * Separate portal for resellers to manage their business
 */

// Start session and error reporting for debugging
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

try {
    // Initialize system
    require_once 'init.php';
    require_once 'system/orm.php';
    
    // Check if ResellerAuth exists
    if (file_exists('system/autoload/ResellerAuth.php')) {
        require_once 'system/autoload/ResellerAuth.php';
    }

    // Set base URL for reseller portal
    define('RESELLER_URL', $config['web_url'] . '/reseller.php');

    // Parse URL routes
    $request_uri = $_SERVER['REQUEST_URI'];
    $script_name = $_SERVER['SCRIPT_NAME'];
    $path = str_replace(dirname($script_name), '', $request_uri);
    $path = str_replace('/reseller.php', '', $path);
    $path = ltrim($path, '/');

    // Remove query string
    if (strpos($path, '?') !== false) {
        $path = substr($path, 0, strpos($path, '?'));
    }

    // Parse routes
    $routes = $path ? explode('/', $path) : ['login'];

    // Initialize UI for reseller portal
    if (class_exists('Smarty')) {
        $ui = new Smarty();
        $ui->setTemplateDir('ui/reseller/');
        $ui->setCompileDir('system/tmp/');
        $ui->assign('_url', RESELLER_URL);
        $ui->assign('app_url', $config['web_url']);
    } else {
        throw new Exception('Smarty template engine not found');
    }

    // Route to appropriate controller
    $controller = $routes[0] ?? 'login';

    switch ($controller) {
        case 'login':
        case 'authenticate':
        case 'logout':
            if (file_exists('system/controllers/reseller_login.php')) {
                require_once 'system/controllers/reseller_login.php';
            } else {
                throw new Exception('Reseller login controller not found');
            }
            break;
            
        case 'register':
            if (file_exists('system/controllers/reseller_registration.php')) {
                require_once 'system/controllers/reseller_registration.php';
            } else {
                echo '<h1>Registration</h1><p>Reseller registration is not yet available. Please contact support.</p>';
            }
            break;
            
        case 'dashboard':
            if (file_exists('system/controllers/reseller_dashboard.php')) {
                require_once 'system/controllers/reseller_dashboard.php';
            } else {
                throw new Exception('Reseller dashboard controller not found');
            }
            break;
            
        case 'mikrotik':
            if (file_exists('system/controllers/reseller_mikrotik.php')) {
                require_once 'system/controllers/reseller_mikrotik.php';
            } else {
                echo '<h1>MikroTik Management</h1><p>MikroTik management is not yet available.</p>';
            }
            break;
            
        case 'customers':
            echo '<h1>Customer Management</h1><p>Customer management features coming soon.</p>';
            break;
            
        case 'reports':
            echo '<h1>Sales Reports</h1><p>Sales reporting features coming soon.</p>';
            break;
            
        case 'settings':
            echo '<h1>Settings</h1><p>Settings panel coming soon.</p>';
            break;
            
        case 'subscription':
            echo '<h1>Subscription</h1><p>Subscription management coming soon.</p>';
            break;
            
        default:
            // Redirect to login for unknown routes
            header('Location: ' . RESELLER_URL . '/login');
            exit;
    }

} catch (Exception $e) {
    // Display error for debugging
    echo '<div style="background: #f8d7da; color: #721c24; padding: 20px; border: 1px solid #f5c6cb; border-radius: 5px; margin: 20px; font-family: Arial, sans-serif;">';
    echo '<h2>Reseller Portal Error</h2>';
    echo '<p><strong>Error:</strong> ' . htmlspecialchars($e->getMessage()) . '</p>';
    echo '<p><strong>File:</strong> ' . htmlspecialchars($e->getFile()) . '</p>';
    echo '<p><strong>Line:</strong> ' . $e->getLine() . '</p>';
    echo '<h3>Debug Information:</h3>';
    echo '<p><strong>Current Directory:</strong> ' . getcwd() . '</p>';
    echo '<p><strong>PHP Version:</strong> ' . PHP_VERSION . '</p>';
    echo '<p><strong>Request URI:</strong> ' . $_SERVER['REQUEST_URI'] . '</p>';
    echo '<p><strong>Routes:</strong> ' . print_r($routes, true) . '</p>';
    
    // Check for required files
    echo '<h3>File Check:</h3>';
    $required_files = [
        'init.php',
        'system/orm.php',
        'system/autoload/ResellerAuth.php',
        'system/controllers/reseller_login.php',
        'system/controllers/reseller_dashboard.php',
        'ui/reseller/'
    ];
    
    foreach ($required_files as $file) {
        $exists = file_exists($file);
        $status = $exists ? '✓' : '✗';
        echo "<p>$status $file</p>";
    }
    
    echo '</div>';
}
?>