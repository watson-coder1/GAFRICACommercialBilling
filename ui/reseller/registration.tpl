<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Become a Reseller - Glinta Africa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }
        .registration-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }
        .registration-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .registration-form {
            padding: 2rem;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
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
        .trial-highlight {
            background: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-radius: 0 10px 10px 0;
        }
        .feature-list {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="registration-container">
                    <div class="registration-header">
                        <h1><i class="fas fa-network-wired"></i> Glinta Africa</h1>
                        <h4>Become a Reseller</h4>
                        <p class="mb-0">Start your billing business today with our 30-day FREE trial</p>
                    </div>
                    
                    <div class="registration-form">
                        {if $smarty.get.error}
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle"></i> {$smarty.get.error}
                            </div>
                        {/if}
                        
                        {if $smarty.get.message}
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> {$smarty.get.message}
                            </div>
                        {/if}
                        
                        <!-- Trial Highlight -->
                        <div class="trial-highlight">
                            <h5><i class="fas fa-gift text-primary"></i> 30-Day FREE Trial - No Payment Required!</h5>
                            <p class="mb-0">Get complete access to our billing system for 30 days. No credit card needed. Cancel anytime.</p>
                        </div>

                        <!-- Registration Form -->
                        <form action="?action=process" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="name" class="form-label">
                                        <i class="fas fa-user"></i> Full Name *
                                    </label>
                                    <input type="text" class="form-control" id="name" name="name" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope"></i> Email Address *
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="phone" class="form-label">
                                        <i class="fas fa-phone"></i> Phone Number *
                                    </label>
                                    <input type="tel" class="form-control" id="phone" name="phone" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="company" class="form-label">
                                        <i class="fas fa-building"></i> Company Name *
                                    </label>
                                    <input type="text" class="form-control" id="company" name="company" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">
                                    <i class="fas fa-map-marker-alt"></i> Address
                                </label>
                                <textarea class="form-control" id="address" name="address" rows="2"></textarea>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock"></i> Password *
                                    </label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="confirm_password" class="form-label">
                                        <i class="fas fa-lock"></i> Confirm Password *
                                    </label>
                                    <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
                                </div>
                            </div>
                            
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="terms" required>
                                <label class="form-check-label" for="terms">
                                    I agree to the <a href="#" target="_blank">Terms of Service</a> and <a href="#" target="_blank">Privacy Policy</a>
                                </label>
                            </div>
                            
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-rocket"></i> Start My FREE Trial
                                </button>
                            </div>
                        </form>
                        
                        <!-- Already have account link -->
                        <div class="text-center mt-3">
                            <p class="text-muted">Already have an account?</p>
                            <a href="?action=login" class="btn btn-outline-primary">
                                <i class="fas fa-sign-in-alt"></i> Login Here
                            </a>
                        </div>
                        
                        <!-- Features Overview -->
                        <div class="feature-list">
                            <h6><i class="fas fa-star text-warning"></i> What's included in your trial:</h6>
                            <div class="row">
                                <div class="col-md-6">
                                    <small class="text-muted">
                                        <i class="fas fa-check text-success"></i> Up to 100 customers<br>
                                        <i class="fas fa-check text-success"></i> Multiple MikroTik routers<br>
                                        <i class="fas fa-check text-success"></i> M-Pesa payment integration<br>
                                        <i class="fas fa-check text-success"></i> Customer management portal
                                    </small>
                                </div>
                                <div class="col-md-6">
                                    <small class="text-muted">
                                        <i class="fas fa-check text-success"></i> Real-time monitoring<br>
                                        <i class="fas fa-check text-success"></i> Detailed sales reports<br>
                                        <i class="fas fa-check text-success"></i> SMS notifications<br>
                                        <i class="fas fa-check text-success"></i> 24/7 support
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Back to Main Site -->
                <div class="text-center">
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