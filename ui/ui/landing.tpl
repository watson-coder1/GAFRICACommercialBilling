<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa - Complete Hotspot Billing System for WiFi Hotspots, ISPs, and Internet Service Providers. Manage your hotspot business with ease.">
    <meta name="keywords" content="hotspot billing, wifi management, mikrotik billing, internet service provider, ISP billing, hotspot management">
    
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/fonts/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/modern-AdminLTE.min.css">
    
    <style>
        .landing-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        .feature-box {
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            background: white;
        }
        .feature-icon {
            font-size: 48px;
            color: #667eea;
            margin-bottom: 20px;
        }
        .btn-primary-custom {
            background: #667eea;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: bold;
        }
        .btn-primary-custom:hover {
            background: #764ba2;
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 24px;
        }
        .pricing-card {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
        }
        .pricing-card.featured {
            border-color: #667eea;
            transform: scale(1.05);
        }
        .demo-section {
            background: #f8f9fa;
            padding: 80px 0;
        }
        .contact-section {
            background: #343a40;
            color: white;
            padding: 80px 0;
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="{$app_url}/landing.php">
                <img src="{$app_url}/ui/ui/images/logo.png" alt="Glinta Africa" height="30" class="d-inline-block align-top">
                Glinta Africa
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#demo">Demo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    {if $logged_in_admin}
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light ml-2" href="{$app_url}/admin">Admin Dashboard</a>
                        </li>
                    {elseif $logged_in_customer}
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light ml-2" href="{$app_url}">Customer Portal</a>
                        </li>
                    {else}
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light ml-2" href="{$app_url}/login">Login</a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="landing-hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h1 class="display-4 font-weight-bold">Complete Hotspot Billing System</h1>
                    <p class="lead mb-4">Manage your WiFi hotspot business with our comprehensive billing and management system. Built for ISPs, hotels, cafes, and hotspot operators.</p>
                    <div class="mt-4">
                        <a href="#demo" class="btn btn-primary-custom btn-lg mr-3">View Demo</a>
                        <a href="#pricing" class="btn btn-outline-light btn-lg">Get Started</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="display-4">Why Choose Glinta Africa?</h2>
                    <p class="lead text-muted">Everything you need to run a successful hotspot business</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-wifi feature-icon"></i>
                        <h4>Captive Portal</h4>
                        <p>Customizable login portal for your hotspot users with branded interface and voucher system.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-users feature-icon"></i>
                        <h4>User Management</h4>
                        <p>Complete customer management system with profiles, packages, and usage tracking.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-credit-card feature-icon"></i>
                        <h4>M-Pesa Integration</h4>
                        <p>Seamless mobile money integration for instant payments and automated service activation.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-chart-bar feature-icon"></i>
                        <h4>Analytics & Reports</h4>
                        <p>Comprehensive reporting and analytics to track your business performance and growth.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-cog feature-icon"></i>
                        <h4>MikroTik Integration</h4>
                        <p>Native integration with MikroTik RouterOS for seamless network management.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-mobile feature-icon"></i>
                        <h4>Mobile Responsive</h4>
                        <p>Fully responsive design that works perfectly on all devices and screen sizes.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Demo Section -->
    <section id="demo" class="demo-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="display-4">Try Our Demo</h2>
                    <p class="lead text-muted">Experience the power of Glinta Africa billing system</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="feature-box">
                        <h4><i class="fa fa-user-shield"></i> Admin Demo</h4>
                        <p>Access the full admin dashboard with all features and management tools.</p>
                        <div class="mt-3">
                            <p><strong>Username:</strong> demo@admin.com</p>
                            <p><strong>Password:</strong> demo123</p>
                            <a href="{$app_url}/admin?demo=1" class="btn btn-primary-custom">Access Admin Demo</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="feature-box">
                        <h4><i class="fa fa-user"></i> Customer Demo</h4>
                        <p>Experience the customer portal from a user's perspective.</p>
                        <div class="mt-3">
                            <p><strong>Username:</strong> demo@customer.com</p>
                            <p><strong>Password:</strong> demo123</p>
                            <a href="{$app_url}/login?demo=1" class="btn btn-primary-custom">Access Customer Demo</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="display-4">Choose Your Plan</h2>
                    <p class="lead text-muted">Flexible pricing for businesses of all sizes</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="pricing-card">
                        <h3>Starter</h3>
                        <div class="mb-3">
                            <span class="h2">$29</span>
                            <span class="text-muted">/month</span>
                        </div>
                        <ul class="list-unstyled">
                            <li>✓ Up to 100 users</li>
                            <li>✓ Basic reporting</li>
                            <li>✓ M-Pesa integration</li>
                            <li>✓ Email support</li>
                            <li>✓ MikroTik integration</li>
                        </ul>
                        <a href="#contact" class="btn btn-outline-primary">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="pricing-card featured">
                        <h3>Professional</h3>
                        <div class="mb-3">
                            <span class="h2">$79</span>
                            <span class="text-muted">/month</span>
                        </div>
                        <ul class="list-unstyled">
                            <li>✓ Up to 500 users</li>
                            <li>✓ Advanced reporting</li>
                            <li>✓ All payment gateways</li>
                            <li>✓ Priority support</li>
                            <li>✓ Custom branding</li>
                            <li>✓ API access</li>
                        </ul>
                        <a href="#contact" class="btn btn-primary-custom">Most Popular</a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="pricing-card">
                        <h3>Enterprise</h3>
                        <div class="mb-3">
                            <span class="h2">$199</span>
                            <span class="text-muted">/month</span>
                        </div>
                        <ul class="list-unstyled">
                            <li>✓ Unlimited users</li>
                            <li>✓ White-label solution</li>
                            <li>✓ Multi-location support</li>
                            <li>✓ 24/7 phone support</li>
                            <li>✓ Custom integrations</li>
                            <li>✓ Dedicated account manager</li>
                        </ul>
                        <a href="#contact" class="btn btn-outline-primary">Contact Sales</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="display-4">Get Started Today</h2>
                    <p class="lead">Ready to transform your hotspot business? Contact us now!</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="row">
                        <div class="col-lg-4 text-center mb-4">
                            <i class="fa fa-envelope fa-3x mb-3"></i>
                            <h5>Email</h5>
                            <p>info@glintaafrica.com</p>
                        </div>
                        <div class="col-lg-4 text-center mb-4">
                            <i class="fa fa-phone fa-3x mb-3"></i>
                            <h5>Phone</h5>
                            <p>+254 700 123 456</p>
                        </div>
                        <div class="col-lg-4 text-center mb-4">
                            <i class="fa fa-map-marker fa-3x mb-3"></i>
                            <h5>Location</h5>
                            <p>Nairobi, Kenya</p>
                        </div>
                    </div>
                    <div class="text-center mt-4">
                        <a href="mailto:info@glintaafrica.com" class="btn btn-primary-custom btn-lg">Contact Us Now</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <p>&copy; 2025 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-lg-6 text-right">
                    <p>Powered by Glinta Africa Billing System</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="{$app_url}/ui/ui/scripts/jquery.min.js"></script>
    <script src="{$app_url}/ui/ui/scripts/bootstrap.min.js"></script>
    <script>
        // Smooth scrolling for navigation links
        $('a[href*="#"]').on('click', function (e) {
            e.preventDefault();
            $('html, body').animate({
                scrollTop: $($(this).attr('href')).offset().top - 70
            }, 500, 'linear');
        });
    </script>
</body>
</html>