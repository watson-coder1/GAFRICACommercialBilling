<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful - Glinta Africa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .success-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .success-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .success-content {
            padding: 2rem;
        }
        .trial-info {
            background: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 1.5rem;
            margin: 1.5rem 0;
            border-radius: 0 10px 10px 0;
        }
        .credentials-box {
            background: #f8f9fa;
            border: 2px solid #dee2e6;
            border-radius: 10px;
            padding: 1.5rem;
            margin: 1.5rem 0;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
        }
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }
        .feature-item {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="success-container">
                    <div class="success-header">
                        <h1><i class="fas fa-check-circle"></i> Registration Successful!</h1>
                        <h4>Welcome to Glinta Africa Reseller Program</h4>
                        <p class="mb-0">Your 30-day FREE trial has started</p>
                    </div>
                    
                    <div class="success-content">
                        <div class="text-center">
                            <h5 class="text-success">
                                <i class="fas fa-gift"></i> Congratulations {if $reseller}{$reseller->name}{/if}!
                            </h5>
                            <p class="lead">Your reseller account has been created successfully.</p>
                        </div>
                        
                        <!-- Trial Information -->
                        <div class="trial-info">
                            <h6><i class="fas fa-calendar-alt text-primary"></i> Your Trial Details</h6>
                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Trial Period:</strong><br>
                                    <span class="text-success">30 Days FREE</span>
                                </div>
                                <div class="col-md-4">
                                    <strong>Started:</strong><br>
                                    {if $reseller}{$reseller->trial_starts|date_format:"%Y-%m-%d"}{/if}
                                </div>
                                <div class="col-md-4">
                                    <strong>Expires:</strong><br>
                                    {if $reseller}{$reseller->trial_ends|date_format:"%Y-%m-%d"}{/if}
                                </div>
                            </div>
                        </div>
                        
                        <!-- Login Credentials -->
                        <div class="credentials-box">
                            <h6><i class="fas fa-key text-warning"></i> Your Login Credentials</h6>
                            <div class="row">
                                <div class="col-md-6">
                                    <strong>Username:</strong><br>
                                    <code>{if $admin}{$admin->username}{/if}</code>
                                </div>
                                <div class="col-md-6">
                                    <strong>Password:</strong><br>
                                    <code>The password you created</code>
                                </div>
                            </div>
                            <div class="mt-3">
                                <strong>Login URL:</strong><br>
                                <a href="{$app_url}/reseller.php" target="_blank">{$app_url}/reseller.php</a>
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="text-center mb-4">
                            <a href="?action=login" class="btn btn-primary btn-lg me-3">
                                <i class="fas fa-sign-in-alt"></i> Login to Dashboard
                            </a>
                            <a href="https://glintaafrica.com" class="btn btn-outline-secondary">
                                <i class="fas fa-home"></i> Back to Main Site
                            </a>
                        </div>
                        
                        <!-- What's Next -->
                        <div class="feature-grid">
                            <div class="feature-item">
                                <i class="fas fa-router fa-2x text-primary mb-2"></i>
                                <h6>Add MikroTik Routers</h6>
                                <small class="text-muted">Connect your MikroTik devices to start managing customers</small>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-users fa-2x text-success mb-2"></i>
                                <h6>Add Customers</h6>
                                <small class="text-muted">Create customer accounts and manage their subscriptions</small>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-credit-card fa-2x text-info mb-2"></i>
                                <h6>Setup M-Pesa</h6>
                                <small class="text-muted">Configure M-Pesa payments for automated billing</small>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-chart-line fa-2x text-warning mb-2"></i>
                                <h6>View Reports</h6>
                                <small class="text-muted">Track sales, customers, and revenue in real-time</small>
                            </div>
                        </div>
                        
                        <div class="alert alert-info mt-4">
                            <i class="fas fa-info-circle"></i>
                            <strong>Need Help?</strong> Contact our support team at 
                            <a href="mailto:support@glintaafrica.com">support@glintaafrica.com</a> 
                            or call <strong>+254 700 000 000</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>