<?php
/**
 * Reseller Portal Entry Point
 * Separate portal for resellers to manage their business
 */

// Prevent caching issues
header("Cache-Control: no-cache, no-store, must-revalidate");
header("Pragma: no-cache");
header("Expires: 0");

session_start();
require_once 'init.php';
require_once 'system/orm.php';
require_once 'system/autoload/ResellerAuth.php';

// Include Smarty library
require_once 'system/vendor/smarty/smarty/libs/Smarty.class.php';

// Set base URL for reseller portal
define('RESELLER_URL', $config['web_url'] . '/reseller.php');

// Parse URL routes
$request_uri = $_SERVER['REQUEST_URI'];
$script_name = $_SERVER['SCRIPT_NAME'];
$path = str_replace(dirname($script_name), '', $request_uri);
$path = str_replace('/reseller.php', '', $path);
$path = ltrim($path, '/');

// Parse routes
$routes = $path ? explode('/', $path) : ['login'];

// Initialize UI for reseller portal
$ui = new Smarty();
$ui->setTemplateDir([
    'reseller' => 'ui/reseller/',
    'admin' => 'ui/ui/admin/',
    'default' => 'ui/ui/'
]);
$ui->setCompileDir('ui/compiled/');
$ui->setCacheDir('ui/cache/');
$ui->setConfigDir('ui/conf/');

// Make sure directories are writable
@chmod('ui/compiled/', 0755);
@chmod('ui/cache/', 0755);

// Assign basic template variables
$ui->assign('_url', RESELLER_URL);
$ui->assign('app_url', $config['web_url']);
$ui->assign('_title', 'Reseller Portal - Glinta Africa');
$ui->assign('_system_name', 'Glinta Hotspot Billing');

// Make template globally available as $template for compatibility
$template = $ui;

// Check subscription status for authenticated users
$action = $routes[0] ?? $_GET['action'] ?? 'login';
if (isset($_SESSION['reseller_admin_id']) && $action !== 'login' && $action !== 'logout' && $action !== 'authenticate') {
    $reseller_id = $_SESSION['reseller_id'];
    $subscriptionCheck = ResellerAuth::checkSubscription($reseller_id);
    
    if (!$subscriptionCheck['active']) {
        // Log the automatic logout
        $admin = ORM::for_table('tbl_reseller_admins')->find_one($_SESSION['reseller_admin_id']);
        if ($admin) {
            $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
            _log('Reseller automatically logged out due to ' . $subscriptionCheck['status'] . ': ' . $admin->fullname . ' (' . $reseller->name . ')', 'Reseller', $reseller_id);
        }
        
        // Clear session
        session_destroy();
        
        // Redirect to login with message
        header('Location: ' . RESELLER_URL . '?action=login&error=' . urlencode($subscriptionCheck['message']));
        exit;
    }
    
    // Assign subscription info to UI
    $ui->assign('subscription_status', $subscriptionCheck);
}

// Route to appropriate controller
$controller = $routes[0] ?? $_GET['action'] ?? 'login';

switch ($controller) {
    case 'authenticate':
        require_once 'system/controllers/reseller_login.php';
        break;
    case 'login':
        require_once 'system/controllers/reseller_login.php';
        break;
    case 'register':
    case 'process':
    case 'success':
        require_once 'system/controllers/reseller_registration.php';
        break;
    case 'dashboard':
        require_once 'system/controllers/reseller_dashboard.php';
        break;
    case 'mikrotik':
        require_once 'system/controllers/reseller_mikrotik.php';
        break;
    case 'customers':
        require_once 'system/controllers/reseller_customers.php';
        break;
    case 'reports':
        require_once 'system/controllers/reseller_reports.php';
        break;
    case 'settings':
        require_once 'system/controllers/reseller_settings.php';
        break;
    case 'subscription':
        require_once 'system/controllers/reseller_subscription.php';
        break;
    default:
        // For unknown routes, include login controller
        require_once 'system/controllers/reseller_login.php';
}
?>