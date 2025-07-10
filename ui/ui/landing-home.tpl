<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa - Enterprise-grade internet billing platform for African ISPs. Advanced hotspot management, automated billing, real-time analytics, and mobile money integration.">
    <meta name="keywords" content="ISP billing software, hotspot management, PPPoE billing, network operations, RADIUS integration, mobile money, African telecommunications">
    <meta name="author" content="Glinta Africa">
    <meta property="og:title" content="Glinta Africa - Enterprise ISP Billing Platform">
    <meta property="og:description" content="Professional-grade billing and network management solution for Internet Service Providers across Africa.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://glintaafrica.com">
    
    <link rel="canonical" href="https://glintaafrica.com">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Chart.js for Technical Visualizations -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        :root {
            --gold: #D4AF37;
            --gold-light: #F4E4C1;
            --gold-dark: #B8941F;
            --black: #000000;
            --black-soft: #1a1a1a;
            --white: #FFFFFF;
            --white-soft: #f8f8f8;
            --teal: #2C5282;
            --teal-light: #4299E1;
            --teal-dark: #1A365D;
            --gray: #666666;
            --gray-light: #f5f5f5;
            --gray-dark: #2d2d2d;
            --gradient-gold: linear-gradient(135deg, #D4AF37 0%, #F4E4C1 50%, #B8941F 100%);
            --gradient-black: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            --gradient-teal: linear-gradient(135deg, #2C5282 0%, #4299E1 100%);
            --gradient-hero: linear-gradient(135deg, #000000 0%, #1a1a1a 50%, #2C5282 100%);
            --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);
            --shadow-gold: 0 10px 30px rgba(212,175,55,0.3);
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
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            font-size: 14px;
            line-height: 1.5;
            color: var(--black);
            background: var(--white);
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        /* Professional Typography */
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Manrope', sans-serif;
            font-weight: 600;
            line-height: 1.2;
            color: var(--black);
            margin-bottom: 0.5rem;
        }

        h1 { font-size: 2.5rem; }
        h2 { font-size: 2rem; }
        h3 { font-size: 1.5rem; }
        h4 { font-size: 1.25rem; }
        h5 { font-size: 1.125rem; }
        h6 { font-size: 1rem; }

        .display-2 { font-size: 3rem; font-weight: 700; }
        .text-lg { font-size: 1.125rem; }
        .text-sm { font-size: 0.875rem; }
        .text-xs { font-size: 0.75rem; }

        /* Logo */
        .logo-brand {
            font-family: 'Orbitron', monospace;
            font-size: 1.5rem;
            font-weight: 900;
            background: var(--gradient-gold);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-decoration: none;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .logo-brand:hover {
            transform: scale(1.05);
            filter: brightness(1.1);
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--gray-200);
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            padding: 0.5rem 0;
            box-shadow: var(--shadow);
        }

        .nav-link {
            color: var(--black);
            font-weight: 500;
            font-size: 0.875rem;
            margin: 0 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            color: var(--gold);
            background: var(--gold-light);
        }

        /* Hero Section */
        .hero {
            background: var(--gradient-hero);
            color: white;
            padding: 8rem 0 4rem;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: 
                radial-gradient(circle at 20% 80%, rgba(212, 175, 55, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(212, 175, 55, 0.08) 0%, transparent 50%);
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero h1 {
            color: white;
            margin-bottom: 1.5rem;
        }

        .hero .lead {
            font-size: 1.125rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
        }

        /* Feature Cards */
        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .feature-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .feature-icon {
            width: 56px;
            height: 56px;
            background: var(--gradient-gold);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--black);
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .feature-title {
            font-size: 1.25rem;
            margin-bottom: 1rem;
            color: var(--black);
        }

        .feature-description {
            color: var(--gray);
            font-size: 0.875rem;
            margin-bottom: 1.5rem;
        }

        .feature-list {
            list-style: none;
            padding: 0;
            margin-bottom: 1.5rem;
        }

        .feature-list li {
            padding: 0.5rem 0;
            color: var(--gray);
            font-size: 0.875rem;
            border-bottom: 1px solid var(--gold-light);
        }

        .feature-list li:last-child {
            border-bottom: none;
        }

        .feature-list li i {
            color: var(--gold);
            margin-right: 0.5rem;
            font-size: 0.75rem;
        }

        /* Technical Demo Section */
        .demo-section {
            background: var(--white-soft);
            padding: 4rem 0;
        }

        .demo-card {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            height: 100%;
        }

        .demo-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .demo-icon {
            width: 40px;
            height: 40px;
            background: var(--gradient-gold);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--black);
            font-size: 1rem;
        }

        /* Metrics Section */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .metric-item {
            text-align: center;
            padding: 1.5rem;
            background: white;
            border-radius: 8px;
            border: 1px solid var(--gray-200);
        }

        .metric-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--gold);
            font-family: 'JetBrains Mono', monospace;
        }

        .metric-label {
            font-size: 0.875rem;
            color: var(--gray);
            margin-top: 0.5rem;
        }

        /* Code Demo */
        .code-demo {
            background: var(--black);
            color: var(--white);
            border-radius: 8px;
            padding: 1rem;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            line-height: 1.4;
            overflow-x: auto;
        }

        .code-header {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--gray-700);
        }

        .code-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        .code-dot.red { background: #ff5f57; }
        .code-dot.yellow { background: #ffbd2e; }
        .code-dot.green { background: #28ca42; }

        /* CTA Section */
        .cta-section {
            background: var(--gradient-black);
            color: white;
            padding: 4rem 0;
            text-align: center;
        }

        /* Buttons */
        .btn {
            font-size: 0.875rem;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            border: none;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--gradient-gold);
            color: var(--black);
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow-gold);
            color: var(--black);
        }

        .btn-outline-primary {
            border: 1px solid var(--gold);
            color: var(--gold);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--gold);
            color: var(--black);
        }

        .btn-accent {
            background: var(--gradient-gold);
            color: var(--black);
        }

        .btn-accent:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow-gold);
            color: var(--black);
        }

        /* Footer */
        .footer {
            background: var(--gradient-black);
            color: var(--white);
            padding: 3rem 0 1rem;
        }

        .footer h6 {
            color: var(--gold);
            margin-bottom: 1rem;
        }

        .footer a {
            color: var(--white);
            text-decoration: none;
            font-size: 0.875rem;
            transition: color 0.2s ease;
        }

        .footer a:hover {
            color: var(--gold);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                padding: 6rem 0 3rem;
            }
            
            h1 { font-size: 2rem; }
            h2 { font-size: 1.75rem; }
            
            .feature-card {
                padding: 1.5rem;
            }
            
            .metrics-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg" id="navbar">
        <div class="container">
            <a class="logo-brand" href="{$app_url}">
                <i class="fas fa-network-wired me-2"></i>Glinta Africa
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fas fa-bars"></i>
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
                    <li class="nav-item ms-2">
                        <a class="btn btn-primary" href="https://glintaafrica.com/admin" target="_blank">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container hero-content">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-2">Enterprise ISP Billing Platform</h1>
                    <p class="lead">Professional-grade network billing and management solution for African telecommunications infrastructure</p>
                    <div class="mt-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-accent me-3">
                            <i class="fas fa-external-link-alt me-2"></i>Try Demo Now
                        </a>
                        <a href="{$app_url}/contact" class="btn btn-outline-primary">
                            <i class="fas fa-phone me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Key Features Overview -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Complete ISP Management Solution</h2>
                    <p class="text-lg" style="color: var(--gray);">Everything you need to run a modern internet service provider</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5 class="feature-title">Mobile Money</h5>
                        <p class="feature-description">Integrated payment processing with M-Pesa, Airtel Money, and MTN MoMo for instant customer payments.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-wifi"></i>
                        </div>
                        <h5 class="feature-title">Hotspot Management</h5>
                        <p class="feature-description">Complete control over your WiFi hotspots with automated user provisioning and bandwidth management.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5 class="feature-title">Real-time Analytics</h5>
                        <p class="feature-description">Monitor network performance, track revenue, and analyze customer behavior with live dashboards.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="feature-title">RADIUS Integration</h5>
                        <p class="feature-description">Enterprise-grade authentication and accounting with FreeRADIUS integration for secure network access.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Technical Architecture -->
    <section class="demo-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Built for Scale and Reliability</h2>
                    <p class="text-lg" style="color: var(--gray);">Enterprise architecture designed for African infrastructure</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="demo-card">
                        <div class="demo-header">
                            <div class="demo-icon">
                                <i class="fas fa-server"></i>
                            </div>
                            <div>
                                <h6 class="mb-0">System Architecture</h6>
                                <small style="color: var(--gray);">High-availability infrastructure</small>
                            </div>
                        </div>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Load-balanced servers with failover</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Distributed database with replication</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>CDN-powered asset delivery</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>99.9% uptime SLA guarantee</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="demo-card">
                        <div class="demo-header">
                            <div class="demo-icon">
                                <i class="fas fa-code"></i>
                            </div>
                            <div>
                                <h6 class="mb-0">API Integration</h6>
                                <small style="color: var(--gray);">RESTful API for custom development</small>
                            </div>
                        </div>
                        <div class="code-demo">
                            <div class="code-header">
                                <div class="code-dot red"></div>
                                <div class="code-dot yellow"></div>
                                <div class="code-dot green"></div>
                                <span class="text-xs ms-2" style="color: var(--gray);">api_example.php</span>
                            </div>
                            <pre><code>// Create new hotspot user
$api = new GlintaAPI($apiKey);
$user = $api->createUser([
    'username' => 'john@example.com',
    'package' => 'daily_unlimited',
    'payment_method' => 'mpesa'
]);

// Auto-provision on payment
if ($payment->confirmed) {
    $radius->activateUser($user->id);
}</code></pre>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Success Metrics -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Trusted Across Africa</h2>
                    <p class="text-lg" style="color: var(--gray);">Powering internet service providers in 15+ African countries</p>
                </div>
            </div>
            <div class="metrics-grid" data-aos="fade-up" data-aos-delay="200">
                <div class="metric-item">
                    <div class="metric-value" id="activeISPs">2,500+</div>
                    <div class="metric-label">Active ISPs</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="endUsers">850K+</div>
                    <div class="metric-label">End Users</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="uptime">99.9%</div>
                    <div class="metric-label">Uptime</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="countries">15+</div>
                    <div class="metric-label">Countries</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Use Cases -->
    <section class="demo-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Perfect for Every Business Model</h2>
                    <p class="text-lg" style="color: var(--gray);">From small WiFi hotspots to enterprise ISP operations</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-coffee"></i>
                        </div>
                        <h5>Café & Restaurant WiFi</h5>
                        <p class="text-sm" style="color: var(--gray);">Offer premium internet to customers with time-based or data packages. Accept mobile money payments instantly.</p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-building"></i>
                        </div>
                        <h5>Community Networks</h5>
                        <p class="text-sm" style="color: var(--gray);">Deploy neighborhood-wide internet with centralized billing, customer management, and support ticketing.</p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-city"></i>
                        </div>
                        <h5>Enterprise ISP</h5>
                        <p class="text-sm" style="color: var(--gray);">Scale to thousands of subscribers with advanced features like PPPoE, RADIUS, and network automation.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">Ready to Transform Your ISP Business?</h2>
                    <p class="text-lg mb-4" style="color: rgba(255,255,255,0.9);">Get started with a free demo and see how Glinta can revolutionize your operations.</p>
                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-accent">
                            <i class="fas fa-rocket me-2"></i>Launch Demo Dashboard
                        </a>
                        <a href="https://wa.me/254711503023" target="_blank" class="btn btn-outline-primary" style="color: white; border-color: white;">
                            <i class="fab fa-whatsapp me-2"></i>WhatsApp: +254 711 503 023
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h6>Glinta Africa</h6>
                    <p class="text-sm mb-3" style="color: var(--gray);">Professional ISP billing and network management platform designed for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" style="color: var(--gold);"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="color: var(--gold);"><i class="fab fa-linkedin"></i></a>
                        <a href="#" style="color: var(--gold);"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Platform</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/features">Features</a>
                        <a href="{$app_url}/pricing">Pricing</a>
                        <a href="https://glintaafrica.com/admin" target="_blank">Dashboard</a>
                        <a href="#">API Docs</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Solutions</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/services">ISP Billing</a>
                        <a href="{$app_url}/services">Hotspot WiFi</a>
                        <a href="{$app_url}/services">Mobile Money</a>
                        <a href="{$app_url}/services">RADIUS Server</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Resources</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/blog">Blog</a>
                        <a href="#">Documentation</a>
                        <a href="{$app_url}/about">About</a>
                        <a href="#">Support</a>
                    </div>
                </div>
                <div class="col-lg-2">
                    <h6>Contact</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="mailto:watsonwambugu@yahoo.com">Email Support</a>
                        <a href="https://wa.me/254711503023" target="_blank">WhatsApp</a>
                        <a href="{$app_url}/contact">Contact Form</a>
                    </div>
                </div>
            </div>
            <hr class="my-4" style="border-color: var(--gray-700);">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="text-sm mb-0" style="color: var(--gray);">&copy; 2024 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-sm mb-0" style="color: var(--gray);">Built for African telecommunications</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

    <script>
        // Initialize AOS
        AOS.init({
            duration: 600,
            easing: 'ease-out-sine',
            once: true,
            offset: 100
        });

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Animate counter values
        function animateCounter(element, target) {
            let current = 0;
            const increment = target / 100;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = target;
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current);
                }
            }, 20);
        }

        // Initialize metric animations on scroll
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const metrics = entry.target.querySelectorAll('.metric-value');
                    metrics.forEach(metric => {
                        const id = metric.id;
                        if (id === 'activeISPs') metric.textContent = '2,500+';
                        else if (id === 'endUsers') metric.textContent = '850K+';
                        else if (id === 'uptime') metric.textContent = '99.9%';
                        else if (id === 'countries') metric.textContent = '15+';
                    });
                    observer.unobserve(entry.target);
                }
            });
        });

        const metricsGrid = document.querySelector('.metrics-grid');
        if (metricsGrid) {
            observer.observe(metricsGrid);
        }
    </script>
</body>
</html>