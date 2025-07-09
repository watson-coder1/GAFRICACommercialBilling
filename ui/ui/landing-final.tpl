<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Professional billing software for internet service providers and resellers. Manage hotspot and PPPoE connections with automated payments and real-time monitoring.">
    <meta name="keywords" content="internet billing software, hotspot management, PPPoE billing, ISP software, WISP billing, Kenya internet providers">
    <meta name="author" content="Glinta Africa">
    <meta property="og:title" content="Glinta Africa - Internet Billing Solutions">
    <meta property="og:description" content="Complete billing and management software for internet service providers. Hotspot and PPPoE support with automated payment collection.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://glintaafrica.com">
    
    <link rel="canonical" href="https://glintaafrica.com">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Clean Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Professional Styles -->
    <style>
        :root {
            --primary: #1a1a2e;
            --secondary: #16213e;
            --accent: #0066cc;
            --accent-hover: #0052a3;
            --text-primary: #2c3e50;
            --text-secondary: #5a6c7d;
            --text-light: #7a8a9a;
            --bg-primary: #ffffff;
            --bg-secondary: #f8f9fa;
            --bg-light: #f5f7fa;
            --border: #e5e7eb;
            --shadow: 0 1px 3px rgba(0,0,0,0.1);
            --shadow-lg: 0 10px 25px rgba(0,0,0,0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            background: var(--bg-primary);
        }

        /* Navigation */
        .navbar {
            background: var(--bg-primary);
            border-bottom: 1px solid var(--border);
            padding: 1rem 0;
            transition: all 0.3s ease;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .navbar.scrolled {
            box-shadow: var(--shadow);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
        }

        .navbar-brand:hover {
            color: var(--accent);
        }

        .navbar-nav .nav-link {
            color: var(--text-primary);
            font-weight: 500;
            margin: 0 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: var(--accent);
            background: var(--bg-light);
        }

        .btn {
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--accent);
            color: white;
        }

        .btn-primary:hover {
            background: var(--accent-hover);
            color: white;
            transform: translateY(-1px);
            box-shadow: var(--shadow-lg);
        }

        .btn-outline-primary {
            background: transparent;
            color: var(--accent);
            border: 2px solid var(--accent);
        }

        .btn-outline-primary:hover {
            background: var(--accent);
            color: white;
        }

        /* Hero Section */
        .hero {
            padding: 120px 0 80px;
            background: var(--bg-light);
            margin-top: 76px;
        }

        .hero h1 {
            font-size: 3rem;
            font-weight: 700;
            line-height: 1.2;
            margin-bottom: 1.5rem;
            color: var(--primary);
        }

        .hero .lead {
            font-size: 1.25rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
        }

        .hero-stats {
            margin-top: 3rem;
            padding-top: 3rem;
            border-top: 1px solid var(--border);
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--accent);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        /* Section Styles */
        .section {
            padding: 80px 0;
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .section-subtitle {
            font-size: 1.125rem;
            text-align: center;
            color: var(--text-secondary);
            margin-bottom: 3rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Feature Cards */
        .feature-card {
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 2rem;
            height: 100%;
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
            border-color: var(--accent);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            background: var(--bg-light);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            color: var(--accent);
            font-size: 1.5rem;
        }

        .feature-card h4 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .feature-card p {
            color: var(--text-secondary);
            line-height: 1.6;
        }

        /* Service Boxes */
        .service-box {
            background: var(--bg-primary);
            border: 2px solid var(--border);
            border-radius: 12px;
            padding: 3rem;
            text-align: center;
            transition: all 0.3s ease;
            height: 100%;
        }

        .service-box:hover {
            border-color: var(--accent);
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .service-icon {
            font-size: 3rem;
            color: var(--accent);
            margin-bottom: 1.5rem;
        }

        .service-box h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        /* Pricing */
        .pricing-card {
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 2.5rem;
            text-align: center;
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .pricing-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .pricing-card.featured {
            border-color: var(--accent);
            position: relative;
        }

        .pricing-card.featured::before {
            content: 'Most Popular';
            position: absolute;
            top: -12px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--accent);
            color: white;
            padding: 0.25rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }

        .pricing-header {
            margin-bottom: 2rem;
        }

        .pricing-price {
            font-size: 3rem;
            font-weight: 700;
            color: var(--accent);
            margin-bottom: 0.5rem;
        }

        .pricing-currency {
            font-size: 1.5rem;
            font-weight: 400;
        }

        .pricing-period {
            color: var(--text-secondary);
        }

        .pricing-features {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem 0;
            flex-grow: 1;
        }

        .pricing-features li {
            padding: 0.75rem 0;
            border-bottom: 1px solid var(--border);
            color: var(--text-primary);
        }

        .pricing-features li:last-child {
            border-bottom: none;
        }

        .pricing-features i {
            color: #22c55e;
            margin-right: 0.5rem;
        }

        /* CTA Section */
        .cta-section {
            background: var(--secondary);
            color: white;
            padding: 80px 0;
            text-align: center;
        }

        .cta-section h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .cta-section p {
            font-size: 1.25rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        /* Footer */
        .footer {
            background: var(--primary);
            color: white;
            padding: 60px 0 30px;
        }

        .footer h5 {
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .footer ul {
            list-style: none;
            padding: 0;
        }

        .footer ul li {
            margin-bottom: 0.75rem;
        }

        .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: white;
        }

        .footer-bottom {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 3rem;
            padding-top: 2rem;
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .pricing-price {
                font-size: 2.5rem;
            }

            .stat-number {
                font-size: 2rem;
            }

            .navbar-nav {
                text-align: center;
                padding-top: 1rem;
            }
        }

        /* Utility Classes */
        .text-accent {
            color: var(--accent);
        }

        .bg-light-section {
            background: var(--bg-light);
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="{$app_url}">Glinta Africa</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                    <li class="nav-item ms-3">
                        <a class="btn btn-primary" href="{$app_url}/index.php?_route=login">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1>Professional Internet Billing Solutions for African ISPs</h1>
                    <p class="lead">
                        Complete billing and management software for internet service providers. Handle hotspot and PPPoE connections with automated payment collection and real-time monitoring.
                    </p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="#pricing" class="btn btn-primary btn-lg">View Pricing</a>
                        <a href="https://wa.me/254711503023" class="btn btn-outline-primary btn-lg" target="_blank">
                            <i class="fab fa-whatsapp me-2"></i>Get Started
                        </a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="hero-stats">
                        <div class="row">
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number">500+</div>
                                    <div class="stat-label">Active ISPs</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number">50K+</div>
                                    <div class="stat-label">End Users</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number">24/7</div>
                                    <div class="stat-label">Support</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="section">
        <div class="container">
            <h2 class="section-title">Everything You Need to Run Your ISP Business</h2>
            <p class="section-subtitle">
                Built specifically for African internet service providers, with features that handle the unique challenges of our market.
            </p>

            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-wifi"></i>
                        </div>
                        <h4>Hotspot Management</h4>
                        <p>Create and manage WiFi hotspots with customizable vouchers, time-based or data-based packages, and instant activation.</p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-ethernet"></i>
                        </div>
                        <h4>PPPoE Support</h4>
                        <p>Full PPPoE server integration for fiber and cable connections. Automatic provisioning and bandwidth management included.</p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h4>Mobile Money Integration</h4>
                        <p>Accept payments via M-Pesa, Airtel Money, and other mobile wallets. Automatic account crediting and payment reconciliation.</p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h4>Business Analytics</h4>
                        <p>Track revenue, user growth, and network performance. Generate detailed reports for better business decisions.</p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h4>Customer Portal</h4>
                        <p>Self-service portal where customers can buy packages, check usage, and manage their accounts without calling support.</p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <h4>Network Monitoring</h4>
                        <p>Real-time monitoring of your network infrastructure. Get alerts for outages and performance issues.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="section bg-light-section">
        <div class="container">
            <h2 class="section-title">Who We Serve</h2>
            <p class="section-subtitle">
                Whether you're a reseller managing multiple locations or an end user looking for reliable internet, we have solutions for you.
            </p>

            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="service-box">
                        <div class="service-icon">
                            <i class="fas fa-building"></i>
                        </div>
                        <h3>For Internet Resellers</h3>
                        <p class="mb-4">Complete billing and management platform for ISPs, WISPs, and internet cafes. Manage multiple locations from one dashboard.</p>
                        <ul class="text-start list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Automated billing and invoicing</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Multi-location management</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Reseller commission tracking</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>White-label customer portals</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>API for custom integrations</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi, I'm interested in your reseller billing software" class="btn btn-primary mt-3" target="_blank">
                            Learn More
                        </a>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="service-box">
                        <div class="service-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <h3>For End Users</h3>
                        <p class="mb-4">Reliable internet packages for homes and businesses. Choose from hotspot vouchers or dedicated PPPoE connections.</p>
                        <ul class="text-start list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Flexible daily, weekly, monthly plans</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Instant activation</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>24/7 customer support</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Multiple payment options</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>No hidden charges</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi, I need internet for my home/business" class="btn btn-primary mt-3" target="_blank">
                            Get Connected
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="section">
        <div class="container">
            <h2 class="section-title">Simple, Transparent Pricing</h2>
            <p class="section-subtitle">
                Choose the plan that fits your business size. All plans include core features with no setup fees.
            </p>

            <div class="row g-4 justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3>Starter</h3>
                            <div class="pricing-price">
                                <span class="pricing-currency">KSh</span> 2,500
                            </div>
                            <div class="pricing-period">per month</div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Up to 100 active users</li>
                            <li><i class="fas fa-check"></i> Hotspot & PPPoE support</li>
                            <li><i class="fas fa-check"></i> Basic reporting</li>
                            <li><i class="fas fa-check"></i> M-Pesa integration</li>
                            <li><i class="fas fa-check"></i> Email support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi, I'm interested in the Starter plan" class="btn btn-primary w-100" target="_blank">
                            Get Started
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="pricing-card featured">
                        <div class="pricing-header">
                            <h3>Professional</h3>
                            <div class="pricing-price">
                                <span class="pricing-currency">KSh</span> 5,000
                            </div>
                            <div class="pricing-period">per month</div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Up to 500 active users</li>
                            <li><i class="fas fa-check"></i> All Starter features</li>
                            <li><i class="fas fa-check"></i> Advanced analytics</li>
                            <li><i class="fas fa-check"></i> Multiple payment gateways</li>
                            <li><i class="fas fa-check"></i> Priority phone support</li>
                            <li><i class="fas fa-check"></i> Custom branding</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi, I'm interested in the Professional plan" class="btn btn-primary w-100" target="_blank">
                            Get Started
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="pricing-card">
                        <div class="pricing-header">
                            <h3>Enterprise</h3>
                            <div class="pricing-price">
                                <span class="pricing-currency">KSh</span> 10,000
                            </div>
                            <div class="pricing-period">per month</div>
                        </div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Unlimited users</li>
                            <li><i class="fas fa-check"></i> All Professional features</li>
                            <li><i class="fas fa-check"></i> Multi-location support</li>
                            <li><i class="fas fa-check"></i> API access</li>
                            <li><i class="fas fa-check"></i> Dedicated account manager</li>
                            <li><i class="fas fa-check"></i> Custom development</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi, I'm interested in the Enterprise plan" class="btn btn-primary w-100" target="_blank">
                            Contact Sales
                        </a>
                    </div>
                </div>
            </div>

            <div class="text-center mt-5">
                <p class="text-secondary">
                    <strong>Need a custom solution?</strong> We can tailor our software to meet your specific requirements.
                </p>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section id="contact" class="cta-section">
        <div class="container">
            <h2>Ready to Transform Your Internet Business?</h2>
            <p>Join hundreds of ISPs across Kenya and East Africa who trust Glinta Africa for their billing needs.</p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="https://wa.me/254711503023" class="btn btn-primary btn-lg" target="_blank">
                    <i class="fab fa-whatsapp me-2"></i>Chat on WhatsApp
                </a>
                <a href="tel:+254711503023" class="btn btn-outline-primary btn-lg" style="background: white; color: var(--accent);">
                    <i class="fas fa-phone me-2"></i>Call +254 711 503 023
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <h5>About Glinta Africa</h5>
                    <p class="text-light">
                        Professional billing software designed for African internet service providers. We help ISPs and WISPs manage their businesses more efficiently with automated billing, payment collection, and network management tools.
                    </p>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Product</h5>
                    <ul>
                        <li><a href="{$app_url}/features">Features</a></li>
                        <li><a href="{$app_url}/pricing">Pricing</a></li>
                        <li><a href="{$app_url}/integrations">Integrations</a></li>
                        <li><a href="{$app_url}/api">API Documentation</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Company</h5>
                    <ul>
                        <li><a href="{$app_url}/about">About Us</a></li>
                        <li><a href="{$app_url}/contact">Contact</a></li>
                        <li><a href="{$app_url}/careers">Careers</a></li>
                        <li><a href="{$app_url}/partners">Partners</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Support</h5>
                    <ul>
                        <li><a href="{$app_url}/help">Help Center</a></li>
                        <li><a href="{$app_url}/docs">Documentation</a></li>
                        <li><a href="{$app_url}/status">System Status</a></li>
                        <li><a href="{$app_url}/changelog">Changelog</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Legal</h5>
                    <ul>
                        <li><a href="{$app_url}/privacy">Privacy Policy</a></li>
                        <li><a href="{$app_url}/terms">Terms of Service</a></li>
                        <li><a href="{$app_url}/sla">SLA</a></li>
                        <li><a href="{$app_url}/security">Security</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Glinta Africa. All rights reserved. | Billing solutions for African ISPs</p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    const offsetTop = target.offsetTop - 80;
                    window.scrollTo({
                        top: offsetTop,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Close mobile menu when link is clicked
        document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
            link.addEventListener('click', () => {
                const navbarCollapse = document.querySelector('.navbar-collapse');
                if (navbarCollapse.classList.contains('show')) {
                    const bsCollapse = new bootstrap.Collapse(navbarCollapse);
                    bsCollapse.hide();
                }
            });
        });
    </script>
</body>
</html>