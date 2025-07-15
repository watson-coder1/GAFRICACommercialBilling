<?php
// Prevent caching issues
header("Cache-Control: no-cache, no-store, must-revalidate");
header("Pragma: no-cache");
header("Expires: 0");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Glinta Africa - Hotspot Billing System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .main-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            padding: 3rem;
            text-align: center;
        }
        .dashboard-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 2rem;
            margin: 1rem;
            transition: transform 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        .btn-dashboard {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 1rem 2rem;
            font-weight: 600;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 1rem;
        }
        .btn-dashboard:hover {
            color: white;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="main-container">
                    <h1><i class="fas fa-network-wired"></i> Glinta Africa</h1>
                    <h4>Hotspot Billing System</h4>
                    <p class="lead">Choose your dashboard:</p>
                    
                    <div class="row">
                        <!-- Admin Dashboard -->
                        <div class="col-md-6">
                            <div class="dashboard-card">
                                <i class="fas fa-user-shield fa-3x text-primary mb-3"></i>
                                <h5>Admin Dashboard</h5>
                                <p class="text-muted">
                                    System administration, user management, and overall system control.
                                </p>
                                <a href="admin.php" class="btn-dashboard">
                                    <i class="fas fa-sign-in-alt"></i> Admin Login
                                </a>
                            </div>
                        </div>
                        
                        <!-- Reseller Dashboard -->
                        <div class="col-md-6">
                            <div class="dashboard-card">
                                <i class="fas fa-store fa-3x text-success mb-3"></i>
                                <h5>Reseller Dashboard</h5>
                                <p class="text-muted">
                                    Manage your billing business, customers, and MikroTik routers.
                                </p>
                                <a href="reseller.php" class="btn-dashboard">
                                    <i class="fas fa-store"></i> Reseller Login
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="dashboard-card">
                                <h6>New Reseller?</h6>
                                <p class="text-muted mb-2">
                                    Start your 30-day FREE trial today! No payment required.
                                </p>
                                <a href="reseller.php?action=register" class="btn-dashboard">
                                    <i class="fas fa-user-plus"></i> Start Free Trial
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <hr class="my-4">
                    
                    <div class="row">
                        <div class="col-md-12">
                            <h6>Features</h6>
                            <div class="row">
                                <div class="col-md-3">
                                    <small class="text-muted">
                                        <i class="fas fa-check text-success"></i> MikroTik Integration<br>
                                        <i class="fas fa-check text-success"></i> M-Pesa Payments
                                    </small>
                                </div>
                                <div class="col-md-3">
                                    <small class="text-muted">
                                        <i class="fas fa-check text-success"></i> Customer Management<br>
                                        <i class="fas fa-check text-success"></i> Real-time Monitoring
                                    </small>
                                </div>
                                <div class="col-md-3">
                                    <small class="text-muted">
                                        <i class="fas fa-check text-success"></i> Sales Reports<br>
                                        <i class="fas fa-check text-success"></i> SMS Notifications
                                    </small>
                                </div>
                                <div class="col-md-3">
                                    <small class="text-muted">
                                        <i class="fas fa-check text-success"></i> Multi-router Support<br>
                                        <i class="fas fa-check text-success"></i> 24/7 Support
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>