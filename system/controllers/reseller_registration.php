<?php

/**
 * Reseller Registration System
 * Allows resellers to register and get 30-day free trial
 */

$action = $routes['1'] ?? 'register';

switch ($action) {
    case 'register':
        handleResellerRegistration();
        break;
    case 'process':
        handleRegistrationProcess();
        break;
    case 'success':
        handleRegistrationSuccess();
        break;
    case 'verify':
        handleEmailVerification();
        break;
    default:
        handleResellerRegistration();
}

function handleResellerRegistration() {
    global $ui;
    
    // Get available plans for display
    $plans = ORM::for_table('tbl_reseller_plans')
        ->where('status', 'active')
        ->order_by_asc('price')
        ->find_many();
    
    $ui->assign('_title', 'Become a Reseller - 30 Day Free Trial');
    $ui->assign('plans', $plans);
    $ui->display('reseller/registration.tpl');
}

function handleRegistrationProcess() {
    $name = _post('name');
    $email = _post('email');
    $password = _post('password');
    $confirm_password = _post('confirm_password');
    $phone = _post('phone');
    $company = _post('company');
    $address = _post('address');
    $plan = _post('plan') ?: 'starter';
    
    // Validation
    $errors = [];
    
    if (empty($name)) {
        $errors[] = 'Full name is required';
    }
    
    if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Valid email address is required';
    }
    
    if (empty($password) || strlen($password) < 6) {
        $errors[] = 'Password must be at least 6 characters';
    }
    
    if ($password !== $confirm_password) {
        $errors[] = 'Passwords do not match';
    }
    
    if (empty($phone)) {
        $errors[] = 'Phone number is required';
    }
    
    if (empty($company)) {
        $errors[] = 'Company name is required';
    }
    
    // Check if email already exists
    $existing = ORM::for_table('tbl_resellers')
        ->where('email', $email)
        ->find_one();
    
    if ($existing) {
        $errors[] = 'Email address already registered';
    }
    
    if (!empty($errors)) {
        r2(U . 'reseller/register', 'e', implode('<br>', $errors));
    }
    
    // Get plan details
    $planDetails = ORM::for_table('tbl_reseller_plans')
        ->where('name', $plan)
        ->find_one();
    
    if (!$planDetails) {
        r2(U . 'reseller/register', 'e', 'Invalid plan selected');
    }
    
    try {
        // Create reseller account with 30-day trial
        $reseller = ORM::for_table('tbl_resellers')->create();
        $reseller->name = $name;
        $reseller->email = $email;
        $reseller->password = password_hash($password, PASSWORD_DEFAULT);
        $reseller->phone = $phone;
        $reseller->company = $company;
        $reseller->address = $address;
        $reseller->subscription_plan = $plan;
        $reseller->subscription_status = 'trial';
        $reseller->trial_starts = date('Y-m-d H:i:s');
        $reseller->trial_ends = date('Y-m-d H:i:s', strtotime('+' . $planDetails->trial_days . ' days'));
        $reseller->max_customers = $planDetails->max_customers;
        $reseller->max_routers = $planDetails->max_routers;
        $reseller->expires_at = date('Y-m-d H:i:s', strtotime('+' . $planDetails->trial_days . ' days'));
        $reseller->save();
        
        // Create default admin user for the reseller
        $admin = ORM::for_table('tbl_reseller_admins')->create();
        $admin->reseller_id = $reseller->id;
        $admin->username = generateUsername($name);
        $admin->password = password_hash($password, PASSWORD_DEFAULT);
        $admin->fullname = $name;
        $admin->email = $email;
        $admin->phone = $phone;
        $admin->role = 'owner';
        $admin->status = 'active';
        $admin->save();
        
        // Create default configurations
        createDefaultResellerConfigs($reseller->id);
        
        // Send welcome email (if email system is configured)
        sendWelcomeEmail($reseller, $admin, $planDetails);
        
        // Log registration
        _log('New reseller registered: ' . $name . ' (' . $company . ') - ' . $plan . ' plan', 'Reseller', 1);
        
        r2(U . 'reseller/registration/success?email=' . urlencode($email), 's', 'Registration successful! Welcome to Glinta Africa Reseller Program!');
        
    } catch (Exception $e) {
        r2(U . 'reseller/register', 'e', 'Registration failed: ' . $e->getMessage());
    }
}

function handleRegistrationSuccess() {
    global $ui;
    
    $email = _get('email');
    
    if ($email) {
        $reseller = ORM::for_table('tbl_resellers')
            ->where('email', $email)
            ->find_one();
        
        if ($reseller) {
            $admin = ORM::for_table('tbl_reseller_admins')
                ->where('reseller_id', $reseller->id)
                ->where('role', 'owner')
                ->find_one();
            
            $ui->assign('reseller', $reseller);
            $ui->assign('admin', $admin);
        }
    }
    
    $ui->assign('_title', 'Registration Successful');
    $ui->display('reseller/registration_success.tpl');
}

function generateUsername($name) {
    // Generate username from name
    $username = strtolower(str_replace(' ', '', $name));
    $username = preg_replace('/[^a-z0-9]/', '', $username);
    
    // Check if username exists
    $counter = 1;
    $original_username = $username;
    
    while (true) {
        $existing = ORM::for_table('tbl_reseller_admins')
            ->where('username', $username)
            ->find_one();
        
        if (!$existing) {
            break;
        }
        
        $username = $original_username . $counter;
        $counter++;
    }
    
    return $username;
}

function createDefaultResellerConfigs($reseller_id) {
    $default_configs = [
        // MikroTik settings
        'mikrotik_enabled' => '1',
        'mikrotik_api_ssl' => '0',
        'mikrotik_api_port' => '8728',
        
        // Payment settings
        'mpesa_enabled' => '0',
        'mpesa_environment' => 'sandbox',
        'mpesa_consumer_key' => '',
        'mpesa_consumer_secret' => '',
        'mpesa_passkey' => '',
        'mpesa_shortcode' => '',
        
        // SMS settings
        'sms_enabled' => '0',
        'sms_gateway' => '',
        'sms_username' => '',
        'sms_password' => '',
        
        // Portal settings
        'portal_enabled' => '1',
        'portal_theme' => 'default',
        'company_name' => '',
        'company_logo' => '',
        
        // Email settings
        'email_enabled' => '0',
        'email_smtp_host' => '',
        'email_smtp_port' => '587',
        'email_smtp_username' => '',
        'email_smtp_password' => '',
        
        // Notification settings
        'notify_new_customer' => '1',
        'notify_payment_received' => '1',
        'notify_expiry_warning' => '1',
        'notify_subscription_expiry' => '1'
    ];
    
    foreach ($default_configs as $key => $value) {
        $config = ORM::for_table('tbl_reseller_configs')->create();
        $config->reseller_id = $reseller_id;
        $config->config_key = $key;
        $config->config_value = $value;
        $config->is_encrypted = in_array($key, ['mpesa_consumer_secret', 'mpesa_passkey', 'sms_password', 'email_smtp_password']) ? 1 : 0;
        $config->save();
    }
}

function sendWelcomeEmail($reseller, $admin, $plan) {
    // This would integrate with your email system
    // For now, we'll just log the details
    
    $trial_ends = date('F j, Y', strtotime($reseller->trial_ends));
    
    $message = "
    Welcome to Glinta Africa Reseller Program!
    
    Your Account Details:
    - Company: {$reseller->company}
    - Email: {$reseller->email}
    - Username: {$admin->username}
    - Plan: {$reseller->subscription_plan}
    - Trial Period: 30 days (ends {$trial_ends})
    - Max Customers: {$reseller->max_customers}
    - Max Routers: {$reseller->max_routers}
    
    Login to your reseller portal:
    URL: " . U . "reseller/login
    Username: {$admin->username}
    
    During your trial period, you can:
    ✓ Add and configure MikroTik routers
    ✓ Manage up to {$reseller->max_customers} customers
    ✓ Process payments and view reports
    ✓ Configure your own M-Pesa settings
    ✓ Access complete billing system
    
    After your trial ends on {$trial_ends}, you'll need to pay KSh {$plan->price} monthly to continue.
    
    Need help? Contact support@glintaafrica.com
    
    Welcome aboard!
    Glinta Africa Team
    ";
    
    // Log the welcome message for now
    _log('Welcome email for reseller: ' . $reseller->name . ' - Trial ends: ' . $trial_ends, 'Reseller', $reseller->id);
    
    return true;
}