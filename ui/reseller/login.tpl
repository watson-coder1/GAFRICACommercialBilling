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
                        {if $error}
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle"></i> {$error}
                            </div>
                        {/if}
                        
                        {if $message}
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> {$message}
                            </div>
                        {/if}
                        
                        <!-- Trial Info -->
                        <div class="trial-info">
                            <h6><i class="fas fa-gift text-primary"></i> 30-Day FREE Trial Available!</h6>
                            <small>New resellers get complete billing system access for 30 days. No payment required!</small>
                        </div>

                        <!-- Login Form -->
                        <form action="?action=authenticate" method="post">
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
                        
                        <!-- Registration Link -->
                        <div class="text-center">
                            <hr>
                            <p class="text-muted">Don't have an account?</p>
                            <a href="mailto:support@glintaafrica.com?subject=Reseller Registration Request" class="btn btn-outline-primary">
                                <i class="fas fa-user-plus"></i> Request Reseller Account
                            </a>
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
                    <a href="https://glintaafrica.com" class="text-white text-decoration-none">
                        <i class="fas fa-arrow-left"></i> Back to Main Site
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>