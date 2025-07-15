<?php

/**
 * Reseller Settings Management
 * Configure reseller account settings
 */

// Ensure reseller is logged in
if (!isset($_SESSION['reseller_admin_id'])) {
    header('Location: ' . RESELLER_URL . '/login');
    exit;
}

$admin_id = $_SESSION['reseller_admin_id'];
$reseller_id = $_SESSION['reseller_id'];

$action = $routes[1] ?? 'profile';

switch ($action) {
    case 'profile':
        handleProfile();
        break;
    case 'company':
        handleCompanySettings();
        break;
    case 'branding':
        handleBrandingSettings();
        break;
    case 'notifications':
        handleNotificationSettings();
        break;
    case 'security':
        handleSecuritySettings();
        break;
    default:
        handleProfile();
}

function handleProfile() {
    global $ui, $admin_id, $reseller_id;
    
    $admin = ORM::for_table('tbl_reseller_admins')->find_one($admin_id);
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    if ($_POST) {
        $fullname = $_POST['fullname'] ?? '';
        $email = $_POST['email'] ?? '';
        $phone = $_POST['phone'] ?? '';
        $current_password = $_POST['current_password'] ?? '';
        $new_password = $_POST['new_password'] ?? '';
        $confirm_password = $_POST['confirm_password'] ?? '';
        
        if (empty($fullname) || empty($email)) {
            r2(RESELLER_URL . '/settings/profile', 'e', 'Full name and email are required');
        }
        
        // Update admin details
        $admin->fullname = $fullname;
        $admin->email = $email;
        $admin->phone = $phone;
        
        // Change password if provided
        if (!empty($new_password)) {
            if (empty($current_password)) {
                r2(RESELLER_URL . '/settings/profile', 'e', 'Current password is required to change password');
            }
            
            if (!password_verify($current_password, $admin->password)) {
                r2(RESELLER_URL . '/settings/profile', 'e', 'Current password is incorrect');
            }
            
            if ($new_password !== $confirm_password) {
                r2(RESELLER_URL . '/settings/profile', 'e', 'New password confirmation does not match');
            }
            
            if (strlen($new_password) < 6) {
                r2(RESELLER_URL . '/settings/profile', 'e', 'Password must be at least 6 characters');
            }
            
            $admin->password = password_hash($new_password, PASSWORD_DEFAULT);
        }
        
        $admin->updated_at = date('Y-m-d H:i:s');
        $admin->save();
        
        // Update session
        $_SESSION['reseller_fullname'] = $admin->fullname;
        
        r2(RESELLER_URL . '/settings/profile', 's', 'Profile updated successfully');
    }
    
    $ui->assign('admin', $admin);
    $ui->assign('reseller', $reseller);
    $ui->assign('_title', 'Profile Settings');
    $ui->assign('_system_menu', 'settings');
    $ui->display('settings/profile.tpl');
}

function handleCompanySettings() {
    global $ui, $reseller_id;
    
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    if ($_POST) {
        $company_name = $_POST['company_name'] ?? '';
        $business_type = $_POST['business_type'] ?? '';
        $address = $_POST['address'] ?? '';
        $city = $_POST['city'] ?? '';
        $country = $_POST['country'] ?? '';
        $website = $_POST['website'] ?? '';
        $description = $_POST['description'] ?? '';
        
        if (empty($company_name)) {
            r2(RESELLER_URL . '/settings/company', 'e', 'Company name is required');
        }
        
        $reseller->name = $company_name;
        $reseller->business_type = $business_type;
        $reseller->address = $address;
        $reseller->city = $city;
        $reseller->country = $country;
        $reseller->website = $website;
        $reseller->description = $description;
        $reseller->updated_at = date('Y-m-d H:i:s');
        $reseller->save();
        
        r2(RESELLER_URL . '/settings/company', 's', 'Company settings updated successfully');
    }
    
    $ui->assign('reseller', $reseller);
    $ui->assign('_title', 'Company Settings');
    $ui->assign('_system_menu', 'settings');
    $ui->display('settings/company.tpl');
}

function handleBrandingSettings() {
    global $ui, $reseller_id;
    
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    if ($_POST) {
        $logo_url = $_POST['logo_url'] ?? '';
        $primary_color = $_POST['primary_color'] ?? '#007bff';
        $secondary_color = $_POST['secondary_color'] ?? '#6c757d';
        $custom_css = $_POST['custom_css'] ?? '';
        $footer_text = $_POST['footer_text'] ?? '';
        
        $reseller->logo_url = $logo_url;
        $reseller->primary_color = $primary_color;
        $reseller->secondary_color = $secondary_color;
        $reseller->custom_css = $custom_css;
        $reseller->footer_text = $footer_text;
        $reseller->updated_at = date('Y-m-d H:i:s');
        $reseller->save();
        
        r2(RESELLER_URL . '/settings/branding', 's', 'Branding settings updated successfully');
    }
    
    $ui->assign('reseller', $reseller);
    $ui->assign('_title', 'Branding Settings');
    $ui->assign('_system_menu', 'settings');
    $ui->display('settings/branding.tpl');
}

function handleNotificationSettings() {
    global $ui, $reseller_id;
    
    $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
    
    if ($_POST) {
        $email_notifications = isset($_POST['email_notifications']) ? 1 : 0;
        $sms_notifications = isset($_POST['sms_notifications']) ? 1 : 0;
        $payment_notifications = isset($_POST['payment_notifications']) ? 1 : 0;
        $customer_notifications = isset($_POST['customer_notifications']) ? 1 : 0;
        $system_notifications = isset($_POST['system_notifications']) ? 1 : 0;
        
        $settings = [
            'email_notifications' => $email_notifications,
            'sms_notifications' => $sms_notifications,
            'payment_notifications' => $payment_notifications,
            'customer_notifications' => $customer_notifications,
            'system_notifications' => $system_notifications
        ];
        
        $reseller->notification_settings = json_encode($settings);
        $reseller->updated_at = date('Y-m-d H:i:s');
        $reseller->save();
        
        r2(RESELLER_URL . '/settings/notifications', 's', 'Notification settings updated successfully');
    }
    
    $settings = json_decode($reseller->notification_settings ?: '{}', true);
    
    $ui->assign('reseller', $reseller);
    $ui->assign('settings', $settings);
    $ui->assign('_title', 'Notification Settings');
    $ui->assign('_system_menu', 'settings');
    $ui->display('settings/notifications.tpl');
}

function handleSecuritySettings() {
    global $ui, $admin_id, $reseller_id;
    
    $admin = ORM::for_table('tbl_reseller_admins')->find_one($admin_id);
    
    if ($_POST) {
        $two_factor = isset($_POST['two_factor_enabled']) ? 1 : 0;
        $login_notifications = isset($_POST['login_notifications']) ? 1 : 0;
        $session_timeout = $_POST['session_timeout'] ?? 60;
        
        $admin->two_factor_enabled = $two_factor;
        $admin->login_notifications = $login_notifications;
        $admin->session_timeout = $session_timeout;
        $admin->updated_at = date('Y-m-d H:i:s');
        $admin->save();
        
        r2(RESELLER_URL . '/settings/security', 's', 'Security settings updated successfully');
    }
    
    // Get recent login history
    $loginHistory = ORM::for_table('tbl_logs')
        ->where('type', 'Reseller')
        ->where('user_id', $reseller_id)
        ->where_like('msg', '%login%')
        ->order_by_desc('id')
        ->limit(10)
        ->find_many();
    
    $ui->assign('admin', $admin);
    $ui->assign('loginHistory', $loginHistory);
    $ui->assign('_title', 'Security Settings');
    $ui->assign('_system_menu', 'settings');
    $ui->display('settings/security.tpl');
}