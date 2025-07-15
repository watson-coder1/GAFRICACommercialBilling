<?php

/**
 * Reseller Login System
 * Separate login portal for resellers
 */

$action = $routes['1'] ?? 'login';

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
        r2(U . 'reseller/dashboard', 's', 'Welcome back!');
    }
    
    $ui->assign('_title', 'Reseller Login');
    $ui->display('reseller/login.tpl');
}

function handleResellerAuthenticate() {
    $username = _post('username');
    $password = _post('password');
    
    if (empty($username) || empty($password)) {
        r2(U . 'reseller/login', 'e', 'Username and password are required');
    }
    
    // Find reseller admin
    $admin = ORM::for_table('tbl_reseller_admins')
        ->where('username', $username)
        ->where('status', 'active')
        ->find_one();
    
    if (!$admin || !password_verify($password, $admin->password)) {
        r2(U . 'reseller/login', 'e', 'Invalid username or password');
    }
    
    // Check reseller subscription status
    require_once 'system/autoload/ResellerAuth.php';
    $subscriptionCheck = ResellerAuth::checkSubscription($admin->reseller_id);
    
    if (!$subscriptionCheck['active']) {
        r2(U . 'reseller/subscription', 'e', $subscriptionCheck['message']);
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
    
    // Show subscription warnings if needed
    if (isset($subscriptionCheck['message'])) {
        r2(U . 'reseller/dashboard', 'w', $subscriptionCheck['message']);
    } else {
        r2(U . 'reseller/dashboard', 's', 'Welcome to your reseller dashboard!');
    }
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
    
    r2(U . 'reseller/login', 's', 'Logged out successfully');
}

function handleResellerRegister() {
    global $ui;
    
    // This could be used for self-registration if enabled
    // For now, redirect to contact admin
    r2(U . 'reseller/login', 'i', 'Please contact Glinta Africa to become a reseller');
}