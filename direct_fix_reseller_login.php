<?php

/**
 * Direct Fix - Reseller Login Controller
 * Bypasses Smarty template system entirely to avoid null template issues
 */

$action = $routes[1] ?? 'login';

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
    default:
        handleResellerLogin();
}

function handleResellerLogin() {
    // Check if already logged in
    if (isset($_SESSION['reseller_admin_id'])) {
        header('Location: ' . RESELLER_URL . '/dashboard');
        exit;
    }
    
    // Get error/message from URL
    $error = $_GET['error'] ?? '';
    $message = $_GET['message'] ?? '';
    
    // Output HTML directly (no Smarty needed)
    ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reseller Login - Glinta Africa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .login-form {
            padding: 2rem;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1rem;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
        }
        .trial-info {
            background: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 0 10px 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="login-container">
                    <div class="login-header">
                        <h1><i class="fas fa-network-wired"></i> Glinta Africa</h1>
                        <h4>Reseller Portal</h4>
                        <p class="mb-0">Manage your billing business</p>
                    </div>
                    
                    <div class="login-form">
                        <?php if ($error): ?>
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle"></i> <?= htmlspecialchars($error) ?>
                            </div>
                        <?php endif; ?>
                        
                        <?php if ($message): ?>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> <?= htmlspecialchars($message) ?>
                            </div>
                        <?php endif; ?>
                        
                        <!-- Trial Info -->
                        <div class="trial-info">
                            <h6><i class="fas fa-gift text-primary"></i> 30-Day FREE Trial Available!</h6>
                            <small>New resellers get complete billing system access for 30 days. No payment required!</small>
                        </div>

                        <!-- Login Form -->
                        <form action="<?= RESELLER_URL ?>/authenticate" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">
                                    <i class="fas fa-user"></i> Username
                                </label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock"></i> Password
                                </label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-sign-in-alt"></i> Login to Dashboard
                                </button>
                            </div>
                        </form>
                        
                        <!-- Test Credentials -->
                        <div class="text-center">
                            <hr>
                            <p class="text-muted small">Test Credentials:</p>
                            <p class="text-muted small">Username: <strong>testreseller</strong> | Password: <strong>test123</strong></p>
                        </div>
                        
                        <!-- Features Overview -->
                        <div class="mt-4">
                            <h6>What you get as a reseller:</h6>
                            <div class="row">
                                <div class="col-6">
                                    <small class="text-muted">
                                        <i class="fas fa-check text-success"></i> MikroTik Management<br>
                                        <i class="fas fa-check text-success"></i> Customer Management<br>
                                        <i class="fas fa-check text-success"></i> Payment Processing
                                    </small>
                                </div>
                                <div class="col-6">
                                    <small class="text-muted">
                                        <i class="fas fa-check text-success"></i> Sales Reports<br>
                                        <i class="fas fa-check text-success"></i> M-Pesa Integration<br>
                                        <i class="fas fa-check text-success"></i> Real-time Monitoring
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Back to Main Site -->
                <div class="text-center mt-3">
                    <a href="/" class="text-white text-decoration-none">
                        <i class="fas fa-arrow-left"></i> Back to Main Site
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
    <?php
    exit;
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
        header('Location: ' . RESELLER_URL . '/login?error=' . urlencode($subscriptionCheck['message']));
        exit;
    }
    
    // Set session
    $_SESSION['reseller_admin_id'] = $admin->id;
    $_SESSION['reseller_id'] = $admin->reseller_id;
    $_SESSION['reseller_username'] = $admin->username;
    $_SESSION['reseller_fullname'] = $admin->fullname;
    
    // Update last login
    $admin->last_login = date('Y-m-d H:i:s');
    $admin->save();
    
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
    
    // Clear session
    unset($_SESSION['reseller_admin_id']);
    unset($_SESSION['reseller_id']);
    unset($_SESSION['reseller_username']);
    unset($_SESSION['reseller_fullname']);
    
    header('Location: ' . RESELLER_URL . '/login?message=' . urlencode('Logged out successfully'));
    exit;
}

?>