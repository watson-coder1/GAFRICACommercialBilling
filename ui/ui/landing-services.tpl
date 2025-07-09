<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Comprehensive internet billing solutions for African ISPs. Hotspot management, PPPoE billing, mobile money integration, and advanced analytics.">
    <meta name="keywords" content="ISP billing software, hotspot management, PPPoE billing, mobile money integration, WiFi monetization, internet service provider solutions">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/services">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --gold: #D4AF37;
            --gold-light: #F4E4C1;
            --gold-dark: #B8941F;
            --black: #000000;
            --black-soft: #1a1a1a;
            --white: #FFFFFF;
            --white-soft: #f8f8f8;
            --gray: #666666;
            --shadow: 0 5px 20px rgba(0,0,0,0.1);
            --shadow-lg: 0 15px 40px rgba(0,0,0,0.2);
            --shadow-gold: 0 10px 30px rgba(212,175,55,0.3);
            --gradient-gold: linear-gradient(135deg, #D4AF37 0%, #F4E4C1 50%, #B8941F 100%);
            --gradient-black: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            line-height: 1.6;
            color: var(--black);
            background: var(--white);
            overflow-x: hidden;
        }

        /* Creative Logo Typography */
        .logo-brand {
            font-family: 'Orbitron', monospace;
            font-size: 1.8rem;
            font-weight: 900;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-decoration: none;
            position: relative;
            transition: all 0.3s ease;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .logo-brand:hover {
            transform: scale(1.05);
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            padding: 1.2rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 2000;
        }

        .navbar-nav .nav-link {
            color: var(--black);
            font-weight: 600;
            margin: 0 0.5rem;
            padding: 0.8rem 1.2rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .navbar-nav .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--gradient-gold);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .navbar-nav .nav-link:hover::before {
            left: 0;
        }

        .navbar-nav .nav-link:hover {
            color: var(--white);
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            background: var(--gradient-black);
            color: var(--white);
            padding: 120px 0 80px;
            margin-top: 80px;
        }

        .hero h1 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 3.5rem;
            font-weight: 700;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1.5rem;
        }

        /* Service Cards */
        .service-card {
            background: var(--white);
            border-radius: 20px;
            padding: 3rem 2rem;
            box-shadow: var(--shadow);
            transition: all 0.4s ease;
            border: 1px solid rgba(212, 175, 55, 0.1);
            height: 100%;
            text-align: center;
        }

        .service-card:hover {
            transform: translateY(-15px);
            box-shadow: var(--shadow-gold);
        }

        .service-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            font-size: 2rem;
            color: var(--black);
        }

        .service-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 1rem;
        }

        .service-description {
            color: var(--gray);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .service-features {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem;
        }

        .service-features li {
            padding: 0.5rem 0;
            color: var(--gray);
            border-bottom: 1px solid rgba(212, 175, 55, 0.1);
        }

        .service-features li:last-child {
            border-bottom: none;
        }

        .service-features li i {
            color: var(--gold);
            margin-right: 0.5rem;
        }

        .btn-service {
            background: var(--gradient-gold);
            color: var(--black);
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-service:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-gold);
            color: var(--black);
        }

        /* Demo Section */
        .demo-section {
            background: var(--white-soft);
            padding: 5rem 0;
        }

        .demo-card {
            background: var(--white);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            text-align: center;
            border: 2px solid transparent;
        }

        .demo-card:hover {
            border-color: var(--gold);
            transform: translateY(-5px);
        }

        .demo-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 1rem;
        }

        .demo-credentials {
            background: var(--gradient-gold);
            color: var(--black);
            padding: 1rem;
            border-radius: 10px;
            margin: 1.5rem 0;
            font-weight: 600;
        }

        /* Footer */
        .footer {
            background: var(--gradient-black);
            color: var(--white);
            padding: 4rem 0 2rem;
            margin-top: 4rem;
        }

        .footer h5 {
            color: var(--gold);
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            padding: 0.3rem 0;
        }

        .footer a:hover {
            color: var(--gold);
            transform: translateX(5px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }
            
            .logo-brand {
                font-size: 1.5rem;
            }
            
            .service-card {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="logo-brand" href="{$app_url}">
                GLINTA<span style="color: var(--gold);">•</span>AFRICA
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fas fa-bars text-dark"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/contact">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$app_url}/blog">Blog</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1>Our Services</h1>
                    <p class="lead" style="color: rgba(255, 255, 255, 0.9);">
                        Comprehensive internet billing solutions designed for African ISPs and network operators.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-wifi"></i>
                        </div>
                        <h3 class="service-title">Hotspot Management</h3>
                        <p class="service-description">
                            Complete WiFi hotspot billing and management solution with captive portal, user authentication, and mobile money integration.
                        </p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> Captive Portal System</li>
                            <li><i class="fas fa-check"></i> Mobile Money Integration</li>
                            <li><i class="fas fa-check"></i> User Management</li>
                            <li><i class="fas fa-check"></i> Bandwidth Control</li>
                            <li><i class="fas fa-check"></i> Real-time Monitoring</li>
                        </ul>
                        <a href="{$app_url}/hotspot" class="btn-service">Learn More</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h3 class="service-title">PPPoE Billing</h3>
                        <p class="service-description">
                            Advanced PPPoE management for fiber and DSL networks with automated billing, usage tracking, and customer self-service portals.
                        </p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> PPPoE Authentication</li>
                            <li><i class="fas fa-check"></i> Automated Billing</li>
                            <li><i class="fas fa-check"></i> Usage Monitoring</li>
                            <li><i class="fas fa-check"></i> Speed Management</li>
                            <li><i class="fas fa-check"></i> Customer Portal</li>
                        </ul>
                        <a href="{$app_url}/pppoe" class="btn-service">Learn More</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h3 class="service-title">Mobile Money Integration</h3>
                        <p class="service-description">
                            Seamless integration with M-Pesa, Airtel Money, MTN MoMo, and other African mobile money platforms for instant payments.
                        </p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> M-Pesa Integration</li>
                            <li><i class="fas fa-check"></i> Airtel Money Support</li>
                            <li><i class="fas fa-check"></i> MTN MoMo Compatible</li>
                            <li><i class="fas fa-check"></i> Instant Payments</li>
                            <li><i class="fas fa-check"></i> Auto Reconciliation</li>
                        </ul>
                        <a href="{$app_url}/billing" class="btn-service">Learn More</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h3 class="service-title">Analytics & Reporting</h3>
                        <p class="service-description">
                            Comprehensive business intelligence with real-time dashboards, revenue analytics, and customer insights for data-driven decisions.
                        </p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> Real-time Dashboards</li>
                            <li><i class="fas fa-check"></i> Revenue Analytics</li>
                            <li><i class="fas fa-check"></i> Customer Insights</li>
                            <li><i class="fas fa-check"></i> Usage Reports</li>
                            <li><i class="fas fa-check"></i> Performance Metrics</li>
                        </ul>
                        <a href="{$app_url}/analytics" class="btn-service">Learn More</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3 class="service-title">Customer Management</h3>
                        <p class="service-description">
                            Advanced customer relationship management with automated communications, support ticketing, and customer lifecycle management.
                        </p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> Customer Database</li>
                            <li><i class="fas fa-check"></i> Automated Notifications</li>
                            <li><i class="fas fa-check"></i> Support Ticketing</li>
                            <li><i class="fas fa-check"></i> Payment History</li>
                            <li><i class="fas fa-check"></i> Service Management</li>
                        </ul>
                        <a href="{$app_url}/contact" class="btn-service">Learn More</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3 class="service-title">Security & Compliance</h3>
                        <p class="service-description">
                            Enterprise-grade security with data encryption, fraud prevention, regulatory compliance, and secure payment processing.
                        </p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> Data Encryption</li>
                            <li><i class="fas fa-check"></i> Fraud Prevention</li>
                            <li><i class="fas fa-check"></i> Compliance Ready</li>
                            <li><i class="fas fa-check"></i> Secure Payments</li>
                            <li><i class="fas fa-check"></i> Access Control</li>
                        </ul>
                        <a href="{$app_url}/security" class="btn-service">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Demo Section -->
    <section class="demo-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-5 fw-bold" style="color: var(--black);">Try Our Platform</h2>
                    <p class="lead" style="color: var(--gray);">
                        Experience our billing system with live demos for both resellers and end customers.
                    </p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-up">
                    <div class="demo-card">
                        <div class="service-icon mx-auto mb-3">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <h3 class="demo-title">Reseller Demo</h3>
                        <p class="text-muted">
                            Access the full admin dashboard to manage customers, plans, payments, and analytics.
                        </p>
                        <div class="demo-credentials">
                            <strong>Username:</strong> Trial<br>
                            <strong>Password:</strong> Trialpass
                        </div>
                        <a href="{$app_url}/demo-reseller" class="btn-service">Launch Reseller Demo</a>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="demo-card">
                        <div class="service-icon mx-auto mb-3">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3 class="demo-title">Customer Demo</h3>
                        <p class="text-muted">
                            Experience the customer portal for purchasing packages, viewing usage, and managing account.
                        </p>
                        <div class="demo-credentials">
                            <strong>Username:</strong> Trial<br>
                            <strong>Password:</strong> Trialpass
                        </div>
                        <a href="{$app_url}/demo-customer" class="btn-service">Launch Customer Demo</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <h5>Company</h5>
                    <a href="{$app_url}/about">About Us</a>
                    <a href="{$app_url}/careers">Careers</a>
                    <a href="{$app_url}/news">News & Press</a>
                    <a href="{$app_url}/investors">Investor Relations</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Products</h5>
                    <a href="{$app_url}/hotspot">Hotspot Solutions</a>
                    <a href="{$app_url}/pppoe">PPPoE Management</a>
                    <a href="{$app_url}/billing">Billing Platform</a>
                    <a href="{$app_url}/analytics">Analytics Suite</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Support</h5>
                    <a href="{$app_url}/help">Help Center</a>
                    <a href="{$app_url}/documentation">Documentation</a>
                    <a href="{$app_url}/community">Community Forum</a>
                    <a href="{$app_url}/contact">Contact Support</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Legal</h5>
                    <a href="{$app_url}/privacy">Privacy Policy</a>
                    <a href="{$app_url}/terms">Terms of Service</a>
                    <a href="{$app_url}/security">Security</a>
                    <a href="{$app_url}/compliance">Compliance</a>
                </div>
            </div>
            <hr style="border-color: var(--gold); margin: 3rem 0 2rem;">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2024 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">Made with ❤️ in Africa | <a href="https://watsonsdevelopers.com" style="color: var(--gold);">watsonsdevelopers.com</a></p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS animations
        AOS.init({
            duration: 800,
            easing: 'ease-in-out',
            once: true
        });
    </script>
</body>
</html>