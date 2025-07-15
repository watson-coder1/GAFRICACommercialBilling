<?php

/**
 * Reseller Login System
 * Separate login portal for resellers
 */

$action = $_GET['action'] ?? $routes[1] ?? 'login';

switch ($action) {
    case 'login':
        handleResellerLogin();
        break;
    case 'authenticate':
        handleResellerAuthenticate();
        break;
    case 'logout':
        handleResellerLogout();
        break;
    case 'register':
        handleResellerRegister();
        break;
    default:
        handleResellerLogin();
}

function handleResellerLogin() {
    global $ui;
    
    // Check if already logged in
    if (isset($_SESSION['reseller_admin_id'])) {
        header('Location: ' . RESELLER_URL . '/dashboard');
        exit;
    }
    
    // Set template variables for login
    $ui->assign('_title', 'Reseller Login - Glinta Hotspot');
    $ui->assign('_system_name', 'Glinta Hotspot Billing');
    $ui->assign('login_url', RESELLER_URL . '/authenticate');
    $ui->assign('error', $_GET['error'] ?? '');
    $ui->assign('message', $_GET['message'] ?? '');
    
    // Try to display reseller login template
    try {
        $ui->display('login.tpl');
    } catch (Exception $e) {
        // If template fails, try admin login template
        $ui->display('admin/admin/login.tpl');
    }
}

function handleResellerAuthenticate() {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    
    if (empty($username) || empty($password)) {
        header('Location: ' . RESELLER_URL . '/login?error=' . urlencode('Username and password are required'));
        exit;
    }
    
    // Find reseller admin
    $admin = ORM::for_table('tbl_reseller_admins')
        ->where('username', $username)
        ->where('status', 'active')
        ->find_one();
    
    if (!$admin || !password_verify($password, $admin->password)) {
        header('Location: ' . RESELLER_URL . '/login?error=' . urlencode('Invalid username or password'));
        exit;
    }
    
    // Check reseller subscription status
    require_once 'system/autoload/ResellerAuth.php';
    $subscriptionCheck = ResellerAuth::checkSubscription($admin->reseller_id);
    
    if (!$subscriptionCheck['active']) {
        header('Location: ' . RESELLER_URL . '/subscription?error=' . urlencode($subscriptionCheck['message']));
        exit;
    }
    
    // Update last login
    $admin->last_login = date('Y-m-d H:i:s');
    $admin->save();
    
    // Set session
    $_SESSION['reseller_admin_id'] = $admin->id;
    $_SESSION['reseller_id'] = $admin->reseller_id;
    $_SESSION['reseller_username'] = $admin->username;
    $_SESSION['reseller_fullname'] = $admin->fullname;
    
    // Log login
    $reseller = ORM::for_table('tbl_resellers')->find_one($admin->reseller_id);
    _log('Reseller login: ' . $admin->fullname . ' (' . $reseller->name . ')', 'Reseller', $admin->reseller_id);
    
    // Redirect to dashboard
    header('Location: ' . RESELLER_URL . '/dashboard');
    exit;
}

function handleResellerLogout() {
    // Log logout
    if (isset($_SESSION['reseller_admin_id'])) {
        $admin = ORM::for_table('tbl_reseller_admins')->find_one($_SESSION['reseller_admin_id']);
        if ($admin) {
            $reseller = ORM::for_table('tbl_resellers')->find_one($admin->reseller_id);
            _log('Reseller logout: ' . $admin->fullname . ' (' . $reseller->name . ')', 'Reseller', $admin->reseller_id);
        }
    }
    
    // Clear reseller session
    unset($_SESSION['reseller_admin_id']);
    unset($_SESSION['reseller_id']);
    unset($_SESSION['reseller_username']);
    unset($_SESSION['reseller_fullname']);
    
    header('Location: ' . RESELLER_URL . '/login?message=' . urlencode('Logged out successfully'));
    exit;
}

function handleResellerRegister() {
    // This could be used for self-registration if enabled
    // For now, redirect to contact admin
    header('Location: ' . RESELLER_URL . '/login?message=' . urlencode('Please contact Glinta Africa to become a reseller'));
    exit;
}