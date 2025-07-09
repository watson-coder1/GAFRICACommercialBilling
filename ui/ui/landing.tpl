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
        :root {
            --gold: #FFD700;
            --dark-gold: #DAA520;
            --light-gold: #FFF8DC;
            --black: #000000;
            --dark-gray: #1a1a1a;
            --light-gray: #f5f5f5;
            --white: #ffffff;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: var(--black);
        }
        
        .landing-hero {
            background: linear-gradient(135deg, var(--black) 0%, var(--dark-gray) 100%);
            color: var(--white);
            padding: 120px 0;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .landing-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="%23FFD700" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 20px;
            color: var(--gold);
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        
        .hero-subtitle {
            font-size: 1.4rem;
            margin-bottom: 30px;
            color: var(--light-gold);
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .feature-box {
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 40px;
            background: var(--white);
            border: 3px solid var(--light-gold);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .feature-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--gold) 0%, var(--dark-gold) 100%);
        }
        
        .feature-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            border-color: var(--gold);
        }
        
        .feature-icon {
            font-size: 60px;
            color: var(--gold);
            margin-bottom: 25px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        
        .feature-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--black);
            margin-bottom: 15px;
        }
        
        .feature-description {
            font-size: 1.1rem;
            color: #333;
            line-height: 1.8;
        }
        
        .btn-primary-custom {
            background: linear-gradient(45deg, var(--gold) 0%, var(--dark-gold) 100%);
            color: var(--black);
            border: none;
            padding: 15px 40px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(218, 165, 32, 0.3);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-primary-custom:hover {
            background: linear-gradient(45deg, var(--dark-gold) 0%, var(--gold) 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(218, 165, 32, 0.4);
            color: var(--black);
        }
        
        .btn-outline-custom {
            background: transparent;
            color: var(--gold);
            border: 2px solid var(--gold);
            padding: 15px 40px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-outline-custom:hover {
            background: var(--gold);
            color: var(--black);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(218, 165, 32, 0.4);
        }
        
        .navbar-brand {
            font-weight: 900;
            font-size: 24px;
            color: var(--gold) !important;
        }
        
        .navbar-dark .navbar-nav .nav-link {
            color: var(--white) !important;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .navbar-dark .navbar-nav .nav-link:hover {
            color: var(--gold) !important;
        }
        
        .pricing-card {
            border: 3px solid var(--light-gold);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            text-align: center;
            background: var(--white);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .pricing-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--gold) 0%, var(--dark-gold) 100%);
        }
        
        .pricing-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            border-color: var(--gold);
        }
        
        .pricing-card.featured {
            border-color: var(--gold);
            transform: scale(1.05);
            background: linear-gradient(135deg, var(--light-gold) 0%, var(--white) 100%);
        }
        
        .pricing-card.featured::before {
            height: 8px;
        }
        
        .pricing-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--black);
            margin-bottom: 20px;
        }
        
        .pricing-price {
            font-size: 3rem;
            font-weight: 900;
            color: var(--gold);
            margin-bottom: 30px;
        }
        
        .demo-section {
            background: var(--light-gray);
            padding: 100px 0;
            position: relative;
        }
        
        .demo-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent 49%, var(--light-gold) 50%, transparent 51%);
            opacity: 0.1;
        }
        
        .contact-section {
            background: linear-gradient(135deg, var(--black) 0%, var(--dark-gray) 100%);
            color: var(--white);
            padding: 100px 0;
        }
        
        .section-title {
            font-size: 3rem;
            font-weight: 900;
            color: var(--black);
            margin-bottom: 20px;
            text-align: center;
        }
        
        .section-subtitle {
            font-size: 1.3rem;
            color: #666;
            text-align: center;
            margin-bottom: 60px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .contact-section .section-title {
            color: var(--gold);
        }
        
        .contact-section .section-subtitle {
            color: var(--light-gold);
        }
        
        .stats-section {
            background: var(--gold);
            padding: 80px 0;
            color: var(--black);
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 900;
            color: var(--black);
            margin-bottom: 10px;
        }
        
        .stat-label {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--dark-gray);
        }
        
        .testimonial-card {
            background: var(--white);
            border: 2px solid var(--light-gold);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .testimonial-text {
            font-size: 1.1rem;
            font-style: italic;
            color: #333;
            margin-bottom: 20px;
        }
        
        .testimonial-author {
            font-weight: 700;
            color: var(--gold);
        }
        
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
            
            .section-title {
                font-size: 2.2rem;
            }
            
            .feature-box {
                padding: 30px;
                margin-bottom: 30px;
            }
            
            .pricing-card {
                padding: 30px;
            }
            
            .pricing-card.featured {
                transform: none;
                margin-top: 0;
            }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="{$app_url}/landing.php">
                <img src="{$app_url}/ui/ui/images/logo.png" alt="Glinta Africa" height="30" class="d-inline-block align-top mr-2">
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
                        <a class="nav-link" href="#stats">Why Choose Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#demo">Demo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#testimonials">Reviews</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    {if $logged_in_admin}
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-custom ml-2" href="{$app_url}/admin">Admin Dashboard</a>
                        </li>
                    {elseif $logged_in_customer}
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-custom ml-2" href="{$app_url}">Customer Portal</a>
                        </li>
                    {else}
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-custom ml-2" href="{$app_url}/login">Login</a>
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
                <div class="col-lg-10 mx-auto">
                    <div class="hero-content">
                        <h1 class="hero-title">Enterprise Hotspot Billing Solutions</h1>
                        <p class="hero-subtitle">Transform your WiFi business with Africa's most advanced hotspot billing system. Trusted by ISPs, hotels, cafes, and enterprise networks across the continent.</p>
                        <div class="mt-5">
                            <a href="#demo" class="btn btn-primary-custom btn-lg mr-4">Start Free Trial</a>
                            <a href="#features" class="btn btn-outline-custom btn-lg">Explore Features</a>
                        </div>
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
                    <h2 class="section-title">Comprehensive Hotspot Management</h2>
                    <p class="section-subtitle">Everything you need to run a profitable WiFi business with enterprise-grade features</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-wifi feature-icon"></i>
                        <h4 class="feature-title">Advanced Captive Portal</h4>
                        <p class="feature-description">Customizable branded login portal with voucher system, social login, and multi-language support. Create a professional first impression for your users.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-users feature-icon"></i>
                        <h4 class="feature-title">Customer Management</h4>
                        <p class="feature-description">Complete CRM system with user profiles, package management, usage tracking, and automated notifications. Manage thousands of customers effortlessly.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-credit-card feature-icon"></i>
                        <h4 class="feature-title">Multiple Payment Gateways</h4>
                        <p class="feature-description">M-Pesa, Airtel Money, PayPal, Stripe, and bank transfers. Automated payment processing with instant service activation and receipt generation.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-chart-line feature-icon"></i>
                        <h4 class="feature-title">Business Analytics</h4>
                        <p class="feature-description">Real-time dashboards, revenue reports, user statistics, and performance metrics. Make data-driven decisions to grow your business.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-cogs feature-icon"></i>
                        <h4 class="feature-title">MikroTik Integration</h4>
                        <p class="feature-description">Native RouterOS integration with API support. Automatic bandwidth management, user authentication, and network monitoring.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-mobile feature-icon"></i>
                        <h4 class="feature-title">Mobile-First Design</h4>
                        <p class="feature-description">Responsive design optimized for all devices. Mobile app-like experience for both administrators and customers.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-ticket feature-icon"></i>
                        <h4 class="feature-title">Voucher System</h4>
                        <p class="feature-description">Generate and manage vouchers with custom validity periods, bandwidth limits, and pricing. Perfect for hotels and cafes.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-shield feature-icon"></i>
                        <h4 class="feature-title">Enterprise Security</h4>
                        <p class="feature-description">Advanced security features including SSL encryption, user authentication, bandwidth control, and access logging.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-globe feature-icon"></i>
                        <h4 class="feature-title">Multi-Location Support</h4>
                        <p class="feature-description">Manage multiple hotspot locations from a single dashboard. Perfect for franchise operations and multi-site businesses.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section id="stats" class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">Active Businesses</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                        <div class="stat-number">50K+</div>
                        <div class="stat-label">Daily Active Users</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                        <div class="stat-number">99.9%</div>
                        <div class="stat-label">System Uptime</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                        <div class="stat-number">24/7</div>
                        <div class="stat-label">Technical Support</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section id="testimonials" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="section-title">What Our Customers Say</h2>
                    <p class="section-subtitle">Trusted by leading businesses across Africa</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="testimonial-card">
                        <div class="testimonial-text">"Glinta Africa transformed our hotel's WiFi service. Revenue increased by 300% within 6 months of implementation."</div>
                        <div class="testimonial-author">- Sarah Kimani, Nairobi Grand Hotel</div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="testimonial-card">
                        <div class="testimonial-text">"The best hotspot billing system in Africa. Easy to use, reliable, and excellent customer support."</div>
                        <div class="testimonial-author">- David Mwangi, FastNet ISP</div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="testimonial-card">
                        <div class="testimonial-text">"Perfect for our cafe chain. Centralized management of all locations with detailed analytics."</div>
                        <div class="testimonial-author">- Grace Ochieng, Java House</div>
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
                    <h2 class="section-title">Experience Glinta Africa</h2>
                    <p class="section-subtitle">Try our complete hotspot billing system with full access to all features</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fa fa-dashboard"></i>
                        </div>
                        <h4 class="feature-title">Admin Dashboard Demo</h4>
                        <p class="feature-description">Full access to the admin dashboard with customer management, billing, reports, and all administrative features.</p>
                        <div class="mt-4">
                            <div class="mb-3">
                                <strong>Demo Credentials:</strong><br>
                                <span class="text-muted">Username:</span> admin@demo.com<br>
                                <span class="text-muted">Password:</span> demo2025
                            </div>
                            <a href="{$app_url}/admin?demo=1" class="btn btn-primary-custom">Launch Admin Demo</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fa fa-user-circle"></i>
                        </div>
                        <h4 class="feature-title">Customer Portal Demo</h4>
                        <p class="feature-description">Experience the customer interface including package purchases, voucher activation, and account management.</p>
                        <div class="mt-4">
                            <div class="mb-3">
                                <strong>Demo Credentials:</strong><br>
                                <span class="text-muted">Username:</span> customer@demo.com<br>
                                <span class="text-muted">Password:</span> demo2025
                            </div>
                            <a href="{$app_url}/login?demo=1" class="btn btn-primary-custom">Launch Customer Demo</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-lg-12 text-center">
                    <h4 class="mb-4">Ready to Get Started?</h4>
                    <a href="#contact" class="btn btn-primary-custom btn-lg mr-3">Start Free Trial</a>
                    <a href="#pricing" class="btn btn-outline-custom btn-lg">View Pricing</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="section-title">Transparent Pricing</h2>
                    <p class="section-subtitle">Choose the perfect plan for your hotspot business - no hidden fees, no surprises</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Starter</h3>
                        <div class="pricing-price">
                            KES 2,500<span style="font-size: 1.2rem; color: #666;">/month</span>
                        </div>
                        <ul class="list-unstyled text-left">
                            <li class="mb-2">✓ Up to 100 concurrent users</li>
                            <li class="mb-2">✓ Basic reporting & analytics</li>
                            <li class="mb-2">✓ M-Pesa & Airtel Money integration</li>
                            <li class="mb-2">✓ Email & SMS support</li>
                            <li class="mb-2">✓ MikroTik RouterOS integration</li>
                            <li class="mb-2">✓ Voucher system</li>
                            <li class="mb-2">✓ Mobile responsive design</li>
                        </ul>
                        <a href="#contact" class="btn btn-outline-custom">Start Free Trial</a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="pricing-card featured">
                        <h3 class="pricing-title">Professional</h3>
                        <div class="pricing-price">
                            KES 7,500<span style="font-size: 1.2rem; color: #666;">/month</span>
                        </div>
                        <ul class="list-unstyled text-left">
                            <li class="mb-2">✓ Up to 500 concurrent users</li>
                            <li class="mb-2">✓ Advanced reporting & analytics</li>
                            <li class="mb-2">✓ All payment gateways</li>
                            <li class="mb-2">✓ Priority support</li>
                            <li class="mb-2">✓ Custom branding & themes</li>
                            <li class="mb-2">✓ API access & integrations</li>
                            <li class="mb-2">✓ Multi-location support</li>
                            <li class="mb-2">✓ Advanced user management</li>
                        </ul>
                        <a href="#contact" class="btn btn-primary-custom">Most Popular</a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Enterprise</h3>
                        <div class="pricing-price">
                            KES 15,000<span style="font-size: 1.2rem; color: #666;">/month</span>
                        </div>
                        <ul class="list-unstyled text-left">
                            <li class="mb-2">✓ Unlimited concurrent users</li>
                            <li class="mb-2">✓ White-label solution</li>
                            <li class="mb-2">✓ Unlimited locations</li>
                            <li class="mb-2">✓ 24/7 phone support</li>
                            <li class="mb-2">✓ Custom integrations</li>
                            <li class="mb-2">✓ Dedicated account manager</li>
                            <li class="mb-2">✓ SLA guarantee</li>
                            <li class="mb-2">✓ On-site training</li>
                        </ul>
                        <a href="#contact" class="btn btn-outline-custom">Contact Sales</a>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-lg-12 text-center">
                    <p class="text-muted">All plans include: SSL certificates, automatic backups, security monitoring, and software updates</p>
                    <div class="mt-4">
                        <h5 class="mb-3">Need a custom solution?</h5>
                        <a href="#contact" class="btn btn-primary-custom">Contact Our Sales Team</a>
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
                    <h2 class="section-title">Ready to Transform Your Business?</h2>
                    <p class="section-subtitle">Join hundreds of successful hotspot operators across Africa</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="row">
                        <div class="col-lg-4 text-center mb-4">
                            <i class="fa fa-envelope fa-3x mb-3" style="color: var(--gold);"></i>
                            <h5 style="color: var(--gold);">Email Support</h5>
                            <p>info@glintaafrica.com</p>
                            <p class="text-muted">24/7 email support</p>
                        </div>
                        <div class="col-lg-4 text-center mb-4">
                            <i class="fa fa-phone fa-3x mb-3" style="color: var(--gold);"></i>
                            <h5 style="color: var(--gold);">Phone Support</h5>
                            <p>+254 700 123 456</p>
                            <p class="text-muted">Mon-Fri: 8AM-6PM EAT</p>
                        </div>
                        <div class="col-lg-4 text-center mb-4">
                            <i class="fa fa-whatsapp fa-3x mb-3" style="color: var(--gold);"></i>
                            <h5 style="color: var(--gold);">WhatsApp</h5>
                            <p>+254 700 123 456</p>
                            <p class="text-muted">Instant messaging</p>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-lg-12 text-center">
                            <h4 class="mb-4" style="color: var(--gold);">Start Your Free Trial Today</h4>
                            <p class="mb-4">No credit card required • 30-day free trial • Setup in 5 minutes</p>
                            <div class="mt-4">
                                <a href="mailto:info@glintaafrica.com?subject=Free Trial Request" class="btn btn-primary-custom btn-lg mr-3">Start Free Trial</a>
                                <a href="tel:+254700123456" class="btn btn-outline-custom btn-lg">Call Now</a>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-lg-12 text-center">
                            <h6 class="mb-3" style="color: var(--gold);">Follow Us</h6>
                            <div class="social-links">
                                <a href="#" class="btn btn-outline-custom btn-sm mr-2">
                                    <i class="fa fa-facebook"></i> Facebook
                                </a>
                                <a href="#" class="btn btn-outline-custom btn-sm mr-2">
                                    <i class="fa fa-twitter"></i> Twitter
                                </a>
                                <a href="#" class="btn btn-outline-custom btn-sm mr-2">
                                    <i class="fa fa-linkedin"></i> LinkedIn
                                </a>
                                <a href="#" class="btn btn-outline-custom btn-sm">
                                    <i class="fa fa-youtube"></i> YouTube
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <h5 style="color: var(--gold); margin-bottom: 20px;">Glinta Africa</h5>
                    <p>Africa's premier hotspot billing system, empowering businesses to monetize their WiFi networks with ease and efficiency.</p>
                    <div class="mt-3">
                        <a href="#" class="text-white mr-3"><i class="fa fa-facebook"></i></a>
                        <a href="#" class="text-white mr-3"><i class="fa fa-twitter"></i></a>
                        <a href="#" class="text-white mr-3"><i class="fa fa-linkedin"></i></a>
                        <a href="#" class="text-white"><i class="fa fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-lg-2">
                    <h6 style="color: var(--gold); margin-bottom: 15px;">Product</h6>
                    <ul class="list-unstyled">
                        <li><a href="#features" class="text-white">Features</a></li>
                        <li><a href="#pricing" class="text-white">Pricing</a></li>
                        <li><a href="#demo" class="text-white">Demo</a></li>
                        <li><a href="#" class="text-white">Documentation</a></li>
                    </ul>
                </div>
                <div class="col-lg-2">
                    <h6 style="color: var(--gold); margin-bottom: 15px;">Company</h6>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">About Us</a></li>
                        <li><a href="#" class="text-white">Careers</a></li>
                        <li><a href="#" class="text-white">Partners</a></li>
                        <li><a href="#" class="text-white">Blog</a></li>
                    </ul>
                </div>
                <div class="col-lg-2">
                    <h6 style="color: var(--gold); margin-bottom: 15px;">Support</h6>
                    <ul class="list-unstyled">
                        <li><a href="#contact" class="text-white">Contact</a></li>
                        <li><a href="#" class="text-white">Help Center</a></li>
                        <li><a href="#" class="text-white">System Status</a></li>
                        <li><a href="#" class="text-white">Training</a></li>
                    </ul>
                </div>
                <div class="col-lg-2">
                    <h6 style="color: var(--gold); margin-bottom: 15px;">Legal</h6>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Privacy Policy</a></li>
                        <li><a href="#" class="text-white">Terms of Service</a></li>
                        <li><a href="#" class="text-white">GDPR</a></li>
                        <li><a href="#" class="text-white">Security</a></li>
                    </ul>
                </div>
            </div>
            <hr style="border-color: #444; margin: 30px 0;">
            <div class="row">
                <div class="col-lg-6">
                    <p>&copy; 2025 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-lg-6 text-right">
                    <p>Made with ❤️ in Kenya | Powered by Glinta Africa</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="{$app_url}/ui/ui/scripts/jquery.min.js"></script>
    <script src="{$app_url}/ui/ui/scripts/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            // Smooth scrolling for navigation links
            $('a[href*="#"]').on('click', function (e) {
                e.preventDefault();
                var target = $(this).attr('href');
                if (target && $(target).length) {
                    $('html, body').animate({
                        scrollTop: $(target).offset().top - 70
                    }, 800, 'easeInOutQuart');
                }
            });
            
            // Counter animation for stats
            function animateCounter(element, start, end, duration) {
                var obj = $(element);
                var range = end - start;
                var increment = end > start ? 1 : -1;
                var step = Math.abs(Math.floor(duration / range));
                var current = start;
                
                var timer = setInterval(function() {
                    current += increment;
                    if (element.text().includes('+')) {
                        obj.text(current + '+');
                    } else if (element.text().includes('%')) {
                        obj.text(current + '%');
                    } else if (element.text().includes('/')) {
                        obj.text(current + '/7');
                    } else {
                        obj.text(current);
                    }
                    
                    if (current == end) {
                        clearInterval(timer);
                    }
                }, step);
            }
            
            // Trigger counter animation when stats section is in view
            var statsAnimated = false;
            $(window).scroll(function() {
                var statsOffset = $('#stats').offset();
                if (statsOffset && ($(window).scrollTop() + $(window).height()) > statsOffset.top && !statsAnimated) {
                    statsAnimated = true;
                    animateCounter($('.stat-number:contains("500")'), 0, 500, 2000);
                    animateCounter($('.stat-number:contains("50K")'), 0, 50, 2000);
                    animateCounter($('.stat-number:contains("99.9")'), 0, 99, 2000);
                    animateCounter($('.stat-number:contains("24")'), 0, 24, 2000);
                }
            });
            
            // Add fade-in animation to feature boxes
            $(window).scroll(function() {
                $('.feature-box').each(function() {
                    var elementTop = $(this).offset().top;
                    var elementBottom = elementTop + $(this).outerHeight();
                    var viewportTop = $(window).scrollTop();
                    var viewportBottom = viewportTop + $(window).height();
                    
                    if (elementBottom > viewportTop && elementTop < viewportBottom) {
                        $(this).addClass('animate__animated animate__fadeInUp');
                    }
                });
            });
            
            // Mobile menu toggle
            $('.navbar-toggler').click(function() {
                $('.navbar-collapse').toggleClass('show');
            });
            
            // Auto-hide navbar on scroll
            var lastScrollTop = 0;
            $(window).scroll(function() {
                var st = $(this).scrollTop();
                if (st > lastScrollTop && st > 100) {
                    $('.navbar').addClass('navbar-hidden');
                } else {
                    $('.navbar').removeClass('navbar-hidden');
                }
                lastScrollTop = st;
            });
            
            // Copy demo credentials to clipboard
            $('.btn[href*="demo"]').click(function(e) {
                e.preventDefault();
                var url = $(this).attr('href');
                
                // Show loading state
                var originalText = $(this).text();
                $(this).text('Launching...');
                
                // Simulate demo launch
                setTimeout(function() {
                    window.open(url, '_blank');
                    $(this).text(originalText);
                }.bind(this), 1000);
            });
            
            // Form validation and submission
            $('form').submit(function(e) {
                e.preventDefault();
                
                // Basic form validation
                var isValid = true;
                $(this).find('input[required], textarea[required]').each(function() {
                    if ($(this).val() == '') {
                        isValid = false;
                        $(this).addClass('is-invalid');
                    } else {
                        $(this).removeClass('is-invalid');
                    }
                });
                
                if (isValid) {
                    // Show success message
                    alert('Thank you for your interest! We will contact you soon.');
                }
            });
        });
        
        // Add CSS for navbar animation
        $('<style>')
            .prop('type', 'text/css')
            .html(`
                .navbar {
                    transition: transform 0.3s ease-in-out;
                }
                .navbar-hidden {
                    transform: translateY(-100%);
                }
                .animate__fadeInUp {
                    animation-duration: 0.8s;
                    animation-fill-mode: both;
                }
                @keyframes fadeInUp {
                    from {
                        opacity: 0;
                        transform: translate3d(0, 40px, 0);
                    }
                    to {
                        opacity: 1;
                        transform: translate3d(0, 0, 0);
                    }
                }
                .animate__fadeInUp {
                    animation-name: fadeInUp;
                }
            `)
            .appendTo('head');
    </script>
</body>
</html>