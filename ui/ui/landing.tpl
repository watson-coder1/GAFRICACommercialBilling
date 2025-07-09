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
            background: linear-gradient(135deg, rgba(0,0,0,0.7) 0%, rgba(26,26,26,0.8) 100%), 
                        url('https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center/cover;
            color: var(--white);
            padding: 140px 0;
            text-align: center;
            position: relative;
            overflow: hidden;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        
        .landing-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent 49%, rgba(255, 215, 0, 0.05) 50%, transparent 51%);
            animation: shimmer 3s infinite;
        }
        
        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
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
            font-size: 28px;
            color: var(--black) !important;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-family: 'Arial Black', Arial, sans-serif;
            text-shadow: 1px 1px 2px rgba(255, 215, 0, 0.3);
            position: relative;
            transition: all 0.3s ease;
        }
        
        .navbar-brand:hover {
            color: var(--gold) !important;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .navbar-brand::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--gold) 0%, var(--dark-gold) 100%);
            border-radius: 2px;
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
            transform: scale(1.08);
            background: linear-gradient(135deg, var(--light-gold) 0%, var(--white) 100%);
            position: relative;
        }
        
        .pricing-card.featured::after {
            content: 'MOST POPULAR';
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--gold);
            color: var(--black);
            padding: 5px 20px;
            font-size: 12px;
            font-weight: bold;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
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
        
        /* New Advanced Sections */
        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 1;
        }
        
        .floating-element {
            position: absolute;
            opacity: 0.1;
            animation: float 6s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }
        
        .how-it-works-section {
            background: linear-gradient(135deg, var(--light-gray) 0%, var(--white) 100%);
            padding: 100px 0;
            position: relative;
        }
        
        .step-card {
            background: var(--white);
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            position: relative;
            transition: all 0.3s ease;
        }
        
        .step-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
        }
        
        .step-number {
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--gold);
            color: var(--black);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 900;
            font-size: 20px;
        }
        
        .faq-section {
            background: var(--white);
            padding: 100px 0;
        }
        
        .faq-item {
            background: var(--light-gray);
            border-radius: 10px;
            margin-bottom: 20px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .faq-question {
            background: var(--gold);
            color: var(--black);
            padding: 20px;
            cursor: pointer;
            font-weight: 700;
            transition: all 0.3s ease;
        }
        
        .faq-question:hover {
            background: var(--dark-gold);
        }
        
        .faq-answer {
            padding: 20px;
            display: none;
            background: var(--white);
        }
        
        .newsletter-section {
            background: linear-gradient(135deg, var(--gold) 0%, var(--dark-gold) 100%);
            padding: 80px 0;
            color: var(--black);
        }
        
        .newsletter-form {
            max-width: 500px;
            margin: 0 auto;
            display: flex;
            gap: 15px;
        }
        
        .newsletter-input {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
        }
        
        .newsletter-btn {
            background: var(--black);
            color: var(--white);
            border: none;
            padding: 15px 30px;
            border-radius: 25px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .newsletter-btn:hover {
            background: var(--dark-gray);
            transform: translateY(-2px);
        }
        
        .blog-section {
            background: var(--light-gray);
            padding: 100px 0;
        }
        
        .blog-card {
            background: var(--white);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        .blog-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        
        .blog-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(45deg, var(--gold), var(--dark-gold));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--black);
            font-size: 48px;
        }
        
        .blog-content {
            padding: 30px;
        }
        
        .blog-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--black);
            margin-bottom: 15px;
        }
        
        .blog-excerpt {
            color: #666;
            margin-bottom: 20px;
        }
        
        .blog-date {
            color: var(--gold);
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--gold);
            color: var(--black);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
        }
        
        .back-to-top.visible {
            opacity: 1;
            visibility: visible;
        }
        
        .back-to-top:hover {
            background: var(--dark-gold);
            transform: translateY(-5px);
        }
        
        .cookie-banner {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: var(--black);
            color: var(--white);
            padding: 20px;
            z-index: 1001;
            transform: translateY(100%);
            transition: all 0.3s ease;
        }
        
        .cookie-banner.show {
            transform: translateY(0);
        }
        
        .cookie-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .cookie-text {
            flex: 1;
            margin-right: 20px;
        }
        
        .cookie-buttons {
            display: flex;
            gap: 15px;
        }
        
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--black);
            color: var(--gold);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            transition: all 0.5s ease;
        }
        
        .loading-screen.hidden {
            opacity: 0;
            visibility: hidden;
        }
        
        .loading-spinner {
            border: 4px solid rgba(255, 215, 0, 0.3);
            border-top: 4px solid var(--gold);
            border-radius: 50%;
            width: 60px;
            height: 60px;
            animation: spin 1s linear infinite;
            margin-bottom: 20px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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
            
            .pricing-card.featured::after {
                top: -10px;
                font-size: 10px;
                padding: 3px 15px;
            }
        }
    </style>
</head>

<body>
    <!-- Loading Screen -->
    <div class="loading-screen" id="loadingScreen">
        <div class="text-center">
            <div class="loading-spinner"></div>
            <h4>Loading Glinta Africa...</h4>
        </div>
    </div>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="{$app_url}/landing.php">
                GLINTA AFRICA
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
                        <a class="nav-link" href="#how-it-works">How It Works</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#demo">Demo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#faq">FAQ</a>
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
        <div class="floating-elements">
            <div class="floating-element" style="top: 10%; left: 10%; animation-delay: 0s;">
                <i class="fa fa-wifi" style="font-size: 48px; color: var(--gold);"></i>
            </div>
            <div class="floating-element" style="top: 20%; right: 15%; animation-delay: 1s;">
                <i class="fa fa-users" style="font-size: 36px; color: var(--gold);"></i>
            </div>
            <div class="floating-element" style="bottom: 30%; left: 20%; animation-delay: 2s;">
                <i class="fa fa-chart-line" style="font-size: 42px; color: var(--gold);"></i>
            </div>
            <div class="floating-element" style="bottom: 40%; right: 10%; animation-delay: 3s;">
                <i class="fa fa-shield" style="font-size: 40px; color: var(--gold);"></i>
            </div>
        </div>
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
                        <div class="mt-4">
                            <p class="text-muted">✓ 30-day free trial &nbsp;&nbsp; ✓ No credit card required &nbsp;&nbsp; ✓ Setup in 5 minutes</p>
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
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-clock-o feature-icon"></i>
                        <h4 class="feature-title">Time-Based Packages</h4>
                        <p class="feature-description">Flexible time-based internet packages: hourly, daily, weekly, monthly plans. Automatic disconnection when time expires.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-tachometer feature-icon"></i>
                        <h4 class="feature-title">Bandwidth Management</h4>
                        <p class="feature-description">Dynamic bandwidth allocation, speed limits per user, traffic shaping, and Quality of Service (QoS) controls for optimal network performance.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-envelope feature-icon"></i>
                        <h4 class="feature-title">SMS & Email Integration</h4>
                        <p class="feature-description">Automated SMS and email notifications for payments, package expiry, promotions, and customer communications via multiple channels.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-code feature-icon"></i>
                        <h4 class="feature-title">API & Integrations</h4>
                        <p class="feature-description">RESTful API for third-party integrations, webhooks, custom applications, and seamless connection with external systems.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-database feature-icon"></i>
                        <h4 class="feature-title">Data Usage Monitoring</h4>
                        <p class="feature-description">Real-time data usage tracking, automatic cutoff when limits reached, detailed usage reports, and fair usage policies.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-users-cog feature-icon"></i>
                        <h4 class="feature-title">Staff Management</h4>
                        <p class="feature-description">Role-based access control, multiple admin levels, activity logging, and permission management for team collaboration.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-sync feature-icon"></i>
                        <h4 class="feature-title">Auto-Renewal & Subscriptions</h4>
                        <p class="feature-description">Automatic package renewals, subscription management, recurring billing, and grace period configurations for uninterrupted service.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-map-marker feature-icon"></i>
                        <h4 class="feature-title">Geolocation & Mapping</h4>
                        <p class="feature-description">GPS tracking of access points, customer location mapping, coverage area visualization, and location-based services.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-box text-center">
                        <i class="fa fa-backup feature-icon"></i>
                        <h4 class="feature-title">Backup & Recovery</h4>
                        <p class="feature-description">Automated daily backups, one-click restore, data export/import, and disaster recovery solutions to protect your business data.</p>
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

    <!-- How It Works Section -->
    <section id="how-it-works" class="how-it-works-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="section-title">How It Works</h2>
                    <p class="section-subtitle">Get your hotspot billing system up and running in just 4 simple steps</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="step-card">
                        <div class="step-number">1</div>
                        <i class="fa fa-user-plus feature-icon"></i>
                        <h4 class="feature-title">Sign Up</h4>
                        <p class="feature-description">Create your account and choose the perfect plan for your business needs.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="step-card">
                        <div class="step-number">2</div>
                        <i class="fa fa-cog feature-icon"></i>
                        <h4 class="feature-title">Configure</h4>
                        <p class="feature-description">Set up your MikroTik router and customize your captive portal branding.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="step-card">
                        <div class="step-number">3</div>
                        <i class="fa fa-rocket feature-icon"></i>
                        <h4 class="feature-title">Launch</h4>
                        <p class="feature-description">Go live with your hotspot and start accepting payments from customers.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="step-card">
                        <div class="step-number">4</div>
                        <i class="fa fa-chart-bar feature-icon"></i>
                        <h4 class="feature-title">Grow</h4>
                        <p class="feature-description">Monitor analytics, optimize performance, and scale your business.</p>
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
                                <span class="text-muted">Username:</span> admin<br>
                                <span class="text-muted">Password:</span> admin
                            </div>
                            <a href="{$app_url}/admin" class="btn btn-primary-custom" target="_blank">Launch Admin Demo</a>
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
                                <span class="text-muted">Username:</span> demo<br>
                                <span class="text-muted">Password:</span> demo
                            </div>
                            <a href="{$app_url}/login" class="btn btn-primary-custom" target="_blank">Launch Customer Demo</a>
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
                <div class="col-lg-3">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Basic</h3>
                        <div class="pricing-price">
                            KES 1,000<span style="font-size: 1.2rem; color: #666;">/month</span>
                        </div>
                        <ul class="list-unstyled text-left">
                            <li class="mb-2">✓ Up to 50 concurrent users</li>
                            <li class="mb-2">✓ Basic captive portal</li>
                            <li class="mb-2">✓ M-Pesa integration</li>
                            <li class="mb-2">✓ Email support</li>
                            <li class="mb-2">✓ Basic reporting</li>
                            <li class="mb-2">✓ Voucher system</li>
                            <li class="mb-2">✓ 1 location</li>
                            <li class="mb-2">✓ 10GB monthly data</li>
                        </ul>
                        <a href="#contact" class="btn btn-outline-custom">Start Free Trial</a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Starter</h3>
                        <div class="pricing-price">
                            KES 2,500<span style="font-size: 1.2rem; color: #666;">/month</span>
                        </div>
                        <ul class="list-unstyled text-left">
                            <li class="mb-2">✓ Up to 150 concurrent users</li>
                            <li class="mb-2">✓ Advanced captive portal</li>
                            <li class="mb-2">✓ M-Pesa & Airtel Money</li>
                            <li class="mb-2">✓ Email & SMS support</li>
                            <li class="mb-2">✓ MikroTik integration</li>
                            <li class="mb-2">✓ Advanced voucher system</li>
                            <li class="mb-2">✓ Up to 3 locations</li>
                            <li class="mb-2">✓ 50GB monthly data</li>
                        </ul>
                        <a href="#contact" class="btn btn-outline-custom">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="pricing-card featured">
                        <h3 class="pricing-title">Professional</h3>
                        <div class="pricing-price">
                            KES 5,000<span style="font-size: 1.2rem; color: #666;">/month</span>
                        </div>
                        <ul class="list-unstyled text-left">
                            <li class="mb-2">✓ Up to 500 concurrent users</li>
                            <li class="mb-2">✓ All payment gateways</li>
                            <li class="mb-2">✓ Priority support</li>
                            <li class="mb-2">✓ Custom branding</li>
                            <li class="mb-2">✓ API access</li>
                            <li class="mb-2">✓ Up to 10 locations</li>
                            <li class="mb-2">✓ Advanced analytics</li>
                            <li class="mb-2">✓ 200GB monthly data</li>
                        </ul>
                        <a href="#contact" class="btn btn-primary-custom">Most Popular</a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Enterprise</h3>
                        <div class="pricing-price">
                            KES 10,000<span style="font-size: 1.2rem; color: #666;">/month</span>
                        </div>
                        <ul class="list-unstyled text-left">
                            <li class="mb-2">✓ Unlimited users</li>
                            <li class="mb-2">✓ White-label solution</li>
                            <li class="mb-2">✓ Unlimited locations</li>
                            <li class="mb-2">✓ 24/7 phone support</li>
                            <li class="mb-2">✓ Custom integrations</li>
                            <li class="mb-2">✓ Dedicated manager</li>
                            <li class="mb-2">✓ SLA guarantee</li>
                            <li class="mb-2">✓ Unlimited data</li>
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

    <!-- FAQ Section -->
    <section id="faq" class="faq-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="section-title">Frequently Asked Questions</h2>
                    <p class="section-subtitle">Everything you need to know about Glinta Africa</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="faq-item">
                        <div class="faq-question">
                            <i class="fa fa-question-circle mr-2"></i>
                            How quickly can I set up my hotspot billing system?
                        </div>
                        <div class="faq-answer">
                            <p>You can have your hotspot billing system up and running in less than 30 minutes. Our quick setup wizard guides you through the entire process, from router configuration to payment gateway integration.</p>
                        </div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">
                            <i class="fa fa-question-circle mr-2"></i>
                            Do you support MikroTik routers?
                        </div>
                        <div class="faq-answer">
                            <p>Yes! Glinta Africa has native integration with MikroTik RouterOS. We support all major MikroTik models and provide automatic configuration for seamless connectivity.</p>
                        </div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">
                            <i class="fa fa-question-circle mr-2"></i>
                            What payment methods do you support?
                        </div>
                        <div class="faq-answer">
                            <p>We support M-Pesa, Airtel Money, PayPal, Stripe, bank transfers, and major credit cards. All payments are processed securely with instant service activation.</p>
                        </div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">
                            <i class="fa fa-question-circle mr-2"></i>
                            Can I customize the captive portal design?
                        </div>
                        <div class="faq-answer">
                            <p>Absolutely! You can fully customize your captive portal with your branding, colors, logo, and custom content. No coding skills required.</p>
                        </div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">
                            <i class="fa fa-question-circle mr-2"></i>
                            Is there a free trial available?
                        </div>
                        <div class="faq-answer">
                            <p>Yes! We offer a 30-day free trial with full access to all features. No credit card required to start your trial.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="newsletter-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 style="color: var(--black); margin-bottom: 20px;">Stay Updated</h2>
                    <p style="margin-bottom: 40px;">Get the latest updates, tips, and exclusive offers delivered to your inbox</p>
                    <form class="newsletter-form">
                        <input type="email" class="newsletter-input" placeholder="Enter your email address" required>
                        <button type="submit" class="newsletter-btn">Subscribe</button>
                    </form>
                    <p class="mt-3" style="font-size: 0.9rem;">Join 5,000+ hotspot operators who trust our insights</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Blog/News Section -->
    <section id="blog" class="blog-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="section-title">Latest News & Insights</h2>
                    <p class="section-subtitle">Stay informed with the latest trends in hotspot technology</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="blog-card">
                        <div class="blog-image">
                            <i class="fa fa-wifi"></i>
                        </div>
                        <div class="blog-content">
                            <h4 class="blog-title">5 Ways to Increase Your Hotspot Revenue</h4>
                            <p class="blog-excerpt">Discover proven strategies to maximize your WiFi business profitability and customer satisfaction.</p>
                            <div class="blog-date">January 15, 2025</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog-card">
                        <div class="blog-image">
                            <i class="fa fa-shield"></i>
                        </div>
                        <div class="blog-content">
                            <h4 class="blog-title">Security Best Practices for Hotspot Operators</h4>
                            <p class="blog-excerpt">Essential security measures to protect your network and customers' data from cyber threats.</p>
                            <div class="blog-date">January 10, 2025</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog-card">
                        <div class="blog-image">
                            <i class="fa fa-chart-line"></i>
                        </div>
                        <div class="blog-content">
                            <h4 class="blog-title">Understanding Hotspot Analytics</h4>
                            <p class="blog-excerpt">Learn how to interpret your hotspot data to make informed business decisions and improve performance.</p>
                            <div class="blog-date">January 5, 2025</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Us Section -->
    <section id="about" class="py-5" style="background: var(--white);">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h2 class="section-title text-left">About Glinta Africa</h2>
                    <p class="lead">We are Africa's leading provider of hotspot billing solutions, dedicated to empowering businesses with cutting-edge WiFi monetization technology.</p>
                    <p>Since our inception, we've helped over 500 businesses across Africa transform their WiFi networks into profitable revenue streams. Our platform combines advanced technology with local market expertise to deliver solutions that work in the African context.</p>
                    <div class="mt-4">
                        <div class="row">
                            <div class="col-6">
                                <h4 style="color: var(--gold);">500+</h4>
                                <p>Happy Clients</p>
                            </div>
                            <div class="col-6">
                                <h4 style="color: var(--gold);">99.9%</h4>
                                <p>Uptime SLA</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div style="background: linear-gradient(45deg, var(--gold), var(--dark-gold)); height: 400px; border-radius: 15px; display: flex; align-items: center; justify-content: center;">
                        <i class="fa fa-building" style="font-size: 120px; color: var(--black); opacity: 0.7;"></i>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Back to Top Button -->
    <div class="back-to-top" id="backToTop">
        <i class="fa fa-arrow-up"></i>
    </div>

    <!-- Cookie Consent Banner -->
    <div class="cookie-banner" id="cookieBanner">
        <div class="cookie-content">
            <div class="cookie-text">
                <p>We use cookies to enhance your experience and analyze site usage. By continuing to browse, you agree to our use of cookies.</p>
            </div>
            <div class="cookie-buttons">
                <button class="btn btn-outline-custom btn-sm" onclick="acceptCookies()">Accept</button>
                <button class="btn btn-primary-custom btn-sm" onclick="manageCookies()">Manage</button>
            </div>
        </div>
    </div>

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
                    <p>Made with ❤️ by <a href="https://watsonsdevelopers.com" target="_blank" style="color: var(--gold); text-decoration: none;">watsonsdevelopers.com</a></p>
                </div>
            </div>
        </div>
    </footer>

    <script src="{$app_url}/ui/ui/scripts/jquery.min.js"></script>
    <script src="{$app_url}/ui/ui/scripts/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            // Hide loading screen after page loads
            setTimeout(function() {
                $('#loadingScreen').addClass('hidden');
            }, 1500);
            
            // Smooth scrolling for navigation links
            $('a[href*="#"]').on('click', function (e) {
                e.preventDefault();
                var target = $(this).attr('href');
                if (target && $(target).length) {
                    $('html, body').animate({
                        scrollTop: $(target).offset().top - 70
                    }, 800, 'ease');
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
                
                // Back to top button
                if ($(this).scrollTop() > 300) {
                    $('#backToTop').addClass('visible');
                } else {
                    $('#backToTop').removeClass('visible');
                }
            });
            
            // Back to top functionality
            $('#backToTop').click(function() {
                $('html, body').animate({scrollTop: 0}, 800);
            });
            
            // FAQ accordion functionality
            $('.faq-question').click(function() {
                var answer = $(this).next('.faq-answer');
                $('.faq-answer').not(answer).slideUp();
                answer.slideToggle();
            });
            
            // Newsletter form submission
            $('.newsletter-form').submit(function(e) {
                e.preventDefault();
                var email = $(this).find('.newsletter-input').val();
                if (email) {
                    $(this).find('.newsletter-btn').text('Subscribed!').css('background', 'green');
                    setTimeout(function() {
                        $('.newsletter-btn').text('Subscribe').css('background', '');
                        $('.newsletter-input').val('');
                    }, 3000);
                }
            });
            
            // Cookie banner functionality
            setTimeout(function() {
                $('#cookieBanner').addClass('show');
            }, 3000);
            
            // Add fade-in animation to elements
            $(window).scroll(function() {
                $('.feature-box, .step-card, .blog-card').each(function() {
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
            
            // Demo button functionality
            $('.btn[href*="admin"], .btn[href*="login"]').click(function(e) {
                var originalText = $(this).text();
                $(this).text('Launching...');
                
                setTimeout(function() {
                    $(this).text(originalText);
                }.bind(this), 2000);
            });
            
            // Form validation and submission
            $('form').not('.newsletter-form').submit(function(e) {
                e.preventDefault();
                
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
                    alert('Thank you for your interest! We will contact you soon.');
                }
            });
            
            // Parallax effect for hero section
            $(window).scroll(function() {
                var scrolled = $(this).scrollTop();
                $('.landing-hero').css('background-position', 'center ' + (scrolled * 0.5) + 'px');
            });
        });
        
        // Cookie consent functions
        function acceptCookies() {
            $('#cookieBanner').removeClass('show');
            localStorage.setItem('cookiesAccepted', 'true');
        }
        
        function manageCookies() {
            alert('Cookie management functionality would be implemented here.');
        }
        
        // Check if cookies were already accepted
        if (localStorage.getItem('cookiesAccepted') === 'true') {
            $('#cookieBanner').removeClass('show');
        }
        
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