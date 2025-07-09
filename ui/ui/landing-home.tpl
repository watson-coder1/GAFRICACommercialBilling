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
    
    <!-- Professional Typography - Industry Standard -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Chart.js for Technical Visualizations -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        :root {
            --primary: #1a365d;
            --primary-light: #2d5282;
            --primary-dark: #0f2a44;
            --accent: #d4af37;
            --accent-light: #f4e4c1;
            --accent-dark: #b8941f;
            --secondary: #4a5568;
            --success: #38a169;
            --warning: #ed8936;
            --danger: #e53e3e;
            --info: #3182ce;
            --light: #f7fafc;
            --dark: #1a202c;
            --gray-50: #fafafa;
            --gray-100: #f5f5f5;
            --gray-200: #e5e5e5;
            --gray-300: #d4d4d4;
            --gray-400: #a3a3a3;
            --gray-500: #737373;
            --gray-600: #525252;
            --gray-700: #404040;
            --gray-800: #262626;
            --gray-900: #171717;
            --gradient-primary: linear-gradient(135deg, #1a365d 0%, #2d5282 100%);
            --gradient-accent: linear-gradient(135deg, #d4af37 0%, #f4e4c1 100%);
            --gradient-hero: linear-gradient(135deg, #0f2a44 0%, #1a365d 50%, #2d5282 100%);
            --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);
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
            color: var(--gray-700);
            background: var(--light);
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        /* Professional Typography */
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Manrope', sans-serif;
            font-weight: 600;
            line-height: 1.2;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        h1 { font-size: 2.5rem; }
        h2 { font-size: 2rem; }
        h3 { font-size: 1.5rem; }
        h4 { font-size: 1.25rem; }
        h5 { font-size: 1.125rem; }
        h6 { font-size: 1rem; }

        .display-1 { font-size: 3.5rem; font-weight: 700; }
        .display-2 { font-size: 3rem; font-weight: 700; }
        .display-3 { font-size: 2.5rem; font-weight: 600; }

        .text-lg { font-size: 1.125rem; }
        .text-sm { font-size: 0.875rem; }
        .text-xs { font-size: 0.75rem; }

        .font-mono { font-family: 'JetBrains Mono', monospace; }

        /* Logo */
        .logo-brand {
            font-family: 'Manrope', sans-serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
            letter-spacing: -0.025em;
        }

        .logo-brand:hover {
            color: var(--primary-light);
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
            color: var(--gray-600);
            font-weight: 500;
            font-size: 0.875rem;
            margin: 0 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            color: var(--primary);
            background: var(--gray-50);
        }

        /* Hero Section with Technical Visualization */
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

        /* Technical Stats Grid */
        .tech-stats {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--gray-200);
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
        }

        .stat-number {
            font-family: 'JetBrains Mono', monospace;
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 0.75rem;
            color: var(--gray-600);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        /* Architecture Diagram */
        .architecture-section {
            background: var(--gray-50);
            padding: 4rem 0;
        }

        .arch-component {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.2s ease;
            text-align: center;
        }

        .arch-component:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
        }

        .arch-icon {
            width: 48px;
            height: 48px;
            background: var(--gradient-accent);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: var(--primary);
        }

        /* Technical Features Cards */
        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            height: 100%;
        }

        .feature-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .feature-icon {
            width: 56px;
            height: 56px;
            background: var(--gradient-primary);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .feature-title {
            font-size: 1.125rem;
            margin-bottom: 1rem;
        }

        .feature-description {
            color: var(--gray-600);
            font-size: 0.875rem;
        }

        /* Network Topology Visualization */
        .topology-section {
            background: var(--primary);
            color: white;
            padding: 4rem 0;
            position: relative;
        }

        .topology-node {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid var(--accent);
            border-radius: 50%;
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: var(--accent);
        }

        .topology-connection {
            position: absolute;
            height: 2px;
            background: var(--accent);
            top: 50%;
            opacity: 0.6;
        }

        /* API Documentation Preview */
        .api-preview {
            background: var(--dark);
            border-radius: 8px;
            padding: 1.5rem;
            color: var(--gray-300);
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            line-height: 1.6;
            overflow-x: auto;
        }

        .api-method {
            color: var(--success);
            font-weight: 600;
        }

        .api-endpoint {
            color: var(--accent);
        }

        .api-response {
            color: var(--gray-400);
        }

        /* Dashboard Preview */
        .dashboard-preview {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--gray-200);
        }

        .dashboard-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .metric-card {
            background: var(--gray-50);
            border-radius: 8px;
            padding: 1.5rem;
            border: 1px solid var(--gray-200);
        }

        .metric-value {
            font-family: 'JetBrains Mono', monospace;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary);
        }

        .metric-label {
            font-size: 0.75rem;
            color: var(--gray-600);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        /* Contact Section */
        .contact-section {
            background: white;
            padding: 4rem 0;
        }

        .contact-card {
            background: var(--gray-50);
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            text-align: center;
        }

        .contact-icon {
            width: 64px;
            height: 64px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin: 0 auto 1rem;
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
            background: var(--gradient-primary);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow);
            color: white;
        }

        .btn-outline-primary {
            border: 1px solid var(--primary);
            color: var(--primary);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
        }

        .btn-accent {
            background: var(--gradient-accent);
            color: var(--primary);
        }

        .btn-accent:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow);
            color: var(--primary);
        }

        /* Footer */
        .footer {
            background: var(--dark);
            color: var(--gray-300);
            padding: 3rem 0 1rem;
        }

        .footer h6 {
            color: white;
            margin-bottom: 1rem;
        }

        .footer a {
            color: var(--gray-400);
            text-decoration: none;
            font-size: 0.875rem;
            transition: color 0.2s ease;
        }

        .footer a:hover {
            color: var(--accent);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .display-1 { font-size: 2.5rem; }
            .display-2 { font-size: 2rem; }
            .display-3 { font-size: 1.75rem; }
            h1 { font-size: 2rem; }
            h2 { font-size: 1.75rem; }
            
            .hero {
                padding: 6rem 0 3rem;
            }
            
            .tech-stats {
                padding: 1.5rem;
            }
        }

        /* Loading Animation */
        .loading-spinner {
            width: 40px;
            height: 40px;
            border: 3px solid var(--gray-200);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Status Indicators */
        .status-indicator {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 0.5rem;
        }

        .status-online { background: var(--success); }
        .status-warning { background: var(--warning); }
        .status-offline { background: var(--gray-400); }

        /* Code Block */
        .code-block {
            background: var(--gray-900);
            color: var(--gray-300);
            padding: 1rem;
            border-radius: 6px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            overflow-x: auto;
        }

        .code-comment {
            color: var(--gray-500);
        }

        .code-string {
            color: var(--success);
        }

        .code-number {
            color: var(--accent);
        }

        .code-keyword {
            color: var(--info);
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
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h1 class="display-2">Enterprise ISP Billing Platform for Africa</h1>
                    <p class="lead">Professional-grade network billing and management solution designed for African telecommunications infrastructure. RADIUS integration, real-time analytics, and mobile money processing.</p>
                    <div class="d-flex flex-wrap gap-3 mb-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-accent">
                            <i class="fas fa-external-link-alt me-2"></i>Launch Dashboard
                        </a>
                        <a href="{$app_url}/contact" class="btn btn-outline-primary">
                            <i class="fas fa-phone me-2"></i>Schedule Demo
                        </a>
                    </div>
                    <div class="d-flex align-items-center gap-4 text-sm">
                        <div class="d-flex align-items-center">
                            <span class="status-indicator status-online"></span>
                            System Operational
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="status-indicator status-online"></span>
                            99.9% Uptime
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="status-indicator status-online"></span>
                            24/7 Support
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <div class="tech-stats">
                        <div class="row">
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number" data-count="2500">0</div>
                                    <div class="stat-label">Active ISPs</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number" data-count="850000">0</div>
                                    <div class="stat-label">Subscribers</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number" data-count="15">0</div>
                                    <div class="stat-label">Countries</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number">24/7</div>
                                    <div class="stat-label">Monitoring</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number">99.9%</div>
                                    <div class="stat-label">Uptime SLA</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-item">
                                    <div class="stat-number">&lt;50ms</div>
                                    <div class="stat-label">Response Time</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- System Architecture -->
    <section class="architecture-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Technical Architecture</h2>
                    <p class="text-lg text-gray-600">Enterprise-grade infrastructure built for scale and reliability</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="arch-component">
                        <div class="arch-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <h6>RADIUS Server</h6>
                        <p class="text-sm text-gray-600">Authentication, authorization, and accounting for network access control</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="arch-component">
                        <div class="arch-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <h6>MySQL Cluster</h6>
                        <p class="text-sm text-gray-600">High-availability database with automatic failover and replication</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="arch-component">
                        <div class="arch-icon">
                            <i class="fas fa-cloud"></i>
                        </div>
                        <h6>API Gateway</h6>
                        <p class="text-sm text-gray-600">RESTful APIs with rate limiting, authentication, and monitoring</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="arch-component">
                        <div class="arch-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h6>Security Layer</h6>
                        <p class="text-sm text-gray-600">WAF, DDoS protection, SSL/TLS encryption, and intrusion detection</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Network Topology Visualization -->
    <section class="topology-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Network Integration Model</h2>
                    <p class="text-lg" style="color: rgba(255,255,255,0.8);">Seamless integration with existing network infrastructure</p>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="row align-items-center position-relative">
                        <div class="col-md-3 text-center" data-aos="fade-up" data-aos-delay="100">
                            <div class="topology-node">
                                <i class="fas fa-wifi"></i>
                            </div>
                            <h6>Access Points</h6>
                            <p class="text-sm" style="color: rgba(255,255,255,0.7);">Mikrotik, Ubiquiti, TP-Link</p>
                        </div>
                        <div class="col-md-3 text-center" data-aos="fade-up" data-aos-delay="200">
                            <div class="topology-node">
                                <i class="fas fa-network-wired"></i>
                            </div>
                            <h6>Core Switch</h6>
                            <p class="text-sm" style="color: rgba(255,255,255,0.7);">VLAN & QoS Management</p>
                        </div>
                        <div class="col-md-3 text-center" data-aos="fade-up" data-aos-delay="300">
                            <div class="topology-node">
                                <i class="fas fa-server"></i>
                            </div>
                            <h6>Billing Server</h6>
                            <p class="text-sm" style="color: rgba(255,255,255,0.7);">Glinta Platform</p>
                        </div>
                        <div class="col-md-3 text-center" data-aos="fade-up" data-aos-delay="400">
                            <div class="topology-node">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <h6>Payment Gateway</h6>
                            <p class="text-sm" style="color: rgba(255,255,255,0.7);">M-Pesa, Airtel Money</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Technical Features -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Core Technical Capabilities</h2>
                    <p class="text-lg text-gray-600">Advanced features designed for professional network operations</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-code"></i>
                        </div>
                        <h5 class="feature-title">RESTful API Integration</h5>
                        <p class="feature-description">Complete API suite for third-party integrations, automated provisioning, and custom applications. OpenAPI 3.0 specification included.</p>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">REST</span>
                            <span class="badge bg-light text-dark me-1">JSON</span>
                            <span class="badge bg-light text-dark">OAuth 2.0</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="feature-title">RADIUS Authentication</h5>
                        <p class="feature-description">Full RADIUS server implementation with CoA, accounting, and dynamic authorization. Supports RFC 2865, 2866, and 3576 standards.</p>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">RADIUS</span>
                            <span class="badge bg-light text-dark me-1">CoA</span>
                            <span class="badge bg-light text-dark">RFC 3576</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5 class="feature-title">Real-time Analytics</h5>
                        <p class="feature-description">Advanced telemetry with sub-second data processing, custom metrics, alerting, and machine learning-powered insights.</p>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">InfluxDB</span>
                            <span class="badge bg-light text-dark me-1">Grafana</span>
                            <span class="badge bg-light text-dark">ML</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5 class="feature-title">Mobile Money APIs</h5>
                        <p class="feature-description">Native integration with Safaricom M-Pesa, Airtel Money, MTN MoMo APIs. Automated reconciliation and webhook support.</p>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">M-Pesa</span>
                            <span class="badge bg-light text-dark me-1">STK Push</span>
                            <span class="badge bg-light text-dark">Webhooks</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h5 class="feature-title">Network Automation</h5>
                        <p class="feature-description">Automated provisioning via SNMP, SSH, and vendor APIs. Support for Mikrotik, Ubiquiti, Cisco, and Huawei equipment.</p>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">SNMP</span>
                            <span class="badge bg-light text-dark me-1">SSH</span>
                            <span class="badge bg-light text-dark">Ansible</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <h5 class="feature-title">Security & Compliance</h5>
                        <p class="feature-description">PCI DSS compliant payment processing, GDPR data protection, ISO 27001 security controls, and SOC 2 Type II certification.</p>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">PCI DSS</span>
                            <span class="badge bg-light text-dark me-1">GDPR</span>
                            <span class="badge bg-light text-dark">SOC 2</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- API Documentation Preview -->
    <section class="py-5 bg-gray-50">
        <div class="container">
            <div class="row">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2>Developer-First Approach</h2>
                    <p class="text-lg text-gray-600 mb-4">Comprehensive APIs and SDKs for seamless integration with your existing systems and workflows.</p>
                    <div class="api-preview">
<span class="code-comment"># Create new subscriber</span>
<span class="code-keyword">POST</span> <span class="code-endpoint">/api/v1/subscribers</span>
{
  <span class="code-string">"username"</span>: <span class="code-string">"user@example.com"</span>,
  <span class="code-string">"plan_id"</span>: <span class="code-number">123</span>,
  <span class="code-string">"auto_renewal"</span>: <span class="code-keyword">true</span>
}

<span class="code-comment"># Response</span>
{
  <span class="code-string">"id"</span>: <span class="code-number">45678</span>,
  <span class="code-string">"status"</span>: <span class="code-string">"active"</span>,
  <span class="code-string">"expires_at"</span>: <span class="code-string">"2024-08-01T12:00:00Z"</span>
}
                    </div>
                    <div class="mt-4">
                        <a href="#" class="btn btn-outline-primary me-3">
                            <i class="fas fa-book me-2"></i>API Documentation
                        </a>
                        <a href="#" class="btn btn-outline-primary">
                            <i class="fab fa-github me-2"></i>SDK Downloads
                        </a>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <div class="dashboard-preview">
                        <div class="dashboard-header">
                            <h6>Live Dashboard Preview</h6>
                            <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-primary btn-sm">
                                <i class="fas fa-external-link-alt me-1"></i>Launch Full Dashboard
                            </a>
                        </div>
                        <div class="row g-3">
                            <div class="col-6">
                                <div class="metric-card">
                                    <div class="metric-value" id="revenue-today">$12,450</div>
                                    <div class="metric-label">Revenue Today</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="metric-card">
                                    <div class="metric-value" id="active-sessions">1,247</div>
                                    <div class="metric-label">Active Sessions</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="metric-card">
                                    <div class="metric-value" id="network-usage">73%</div>
                                    <div class="metric-label">Network Usage</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="metric-card">
                                    <div class="metric-value" id="system-uptime">99.97%</div>
                                    <div class="metric-label">System Uptime</div>
                                </div>
                            </div>
                        </div>
                        <div class="mt-3">
                            <canvas id="realtimeChart" height="100"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Success Stories -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Trusted by Leading ISPs</h2>
                    <p class="text-lg text-gray-600">Empowering internet providers across Africa with enterprise-grade solutions</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1606914469633-39fe4a57c72b?w=400&h=200&fit=crop" alt="Nairobi ISP" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <h6>Metro Networks Kenya</h6>
                        <p class="text-sm text-gray-600">"Glinta's RADIUS integration helped us scale from 500 to 5,000 subscribers in 6 months while maintaining 99.9% uptime."</p>
                        <div class="d-flex justify-content-center gap-3 mt-3">
                            <small class="text-gray-500">Nairobi, Kenya</small>
                            <small class="text-gray-500">5,000+ subscribers</small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1584464491033-06628f3a6b7b?w=400&h=200&fit=crop" alt="Lagos ISP" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <h6>Lagos Fiber Network</h6>
                        <p class="text-sm text-gray-600">"The mobile money integration transformed our payment collection. Customer satisfaction increased by 40% with instant service activation."</p>
                        <div class="d-flex justify-content-center gap-3 mt-3">
                            <small class="text-gray-500">Lagos, Nigeria</small>
                            <small class="text-gray-500">12,000+ subscribers</small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card text-center">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1564759298141-2ba484bf9398?w=400&h=200&fit=crop" alt="Cape Town ISP" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <h6>Cape Connect Wireless</h6>
                        <p class="text-sm text-gray-600">"Real-time analytics and automated billing reduced our operational costs by 60% while improving service quality."</p>
                        <div class="d-flex justify-content-center gap-3 mt-3">
                            <small class="text-gray-500">Cape Town, South Africa</small>
                            <small class="text-gray-500">8,500+ subscribers</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="contact-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Get Started Today</h2>
                    <p class="text-lg text-gray-600">Ready to transform your ISP operations? Contact our technical team for a personalized demo.</p>
                </div>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h6>Email Support</h6>
                        <p class="text-sm text-gray-600 mb-3">Get technical assistance and sales information</p>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary">
                            watsonwambugu@yahoo.com
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fab fa-whatsapp"></i>
                        </div>
                        <h6>WhatsApp Support</h6>
                        <p class="text-sm text-gray-600 mb-3">Instant messaging for quick technical support</p>
                        <a href="https://wa.me/254711503023" target="_blank" class="btn btn-outline-primary">
                            +254 711 503 023
                        </a>
                    </div>
                </div>
            </div>
            <div class="text-center mt-5" data-aos="fade-up" data-aos-delay="300">
                <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-primary btn-lg">
                    <i class="fas fa-rocket me-2"></i>Launch Dashboard Now
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h6>Glinta Africa</h6>
                    <p class="text-sm text-gray-400 mb-3">Enterprise-grade ISP billing and network management platform designed for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-gray-400"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-github"></i></a>
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
                        <a href="{$app_url}/services">RADIUS Server</a>
                        <a href="{$app_url}/services">Mobile Money</a>
                        <a href="{$app_url}/services">Network Monitoring</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Resources</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/blog">Blog</a>
                        <a href="#">Documentation</a>
                        <a href="#">Support</a>
                        <a href="{$app_url}/about">About</a>
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
                    <p class="text-sm text-gray-500 mb-0">&copy; 2024 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-sm text-gray-500 mb-0">Built with excellence in Africa</p>
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

        // Animated counters
        function animateCounter(element, target, duration = 2000) {
            const start = 0;
            const increment = target / (duration / 16);
            let current = start;

            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = target.toLocaleString();
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current).toLocaleString();
                }
            }, 16);
        }

        // Initialize counters when they come into view
        const observerOptions = {
            threshold: 0.5,
            rootMargin: '0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const element = entry.target;
                    const count = parseInt(element.getAttribute('data-count'));
                    if (count) {
                        animateCounter(element, count);
                        observer.unobserve(element);
                    }
                }
            });
        }, observerOptions);

        // Observe all counter elements
        document.querySelectorAll('[data-count]').forEach(el => {
            observer.observe(el);
        });

        // Live dashboard metrics simulation
        function updateDashboardMetrics() {
            const metrics = {
                'revenue-today': { base: 12450, variance: 200 },
                'active-sessions': { base: 1247, variance: 50 },
                'network-usage': { base: 73, variance: 5, suffix: '%' },
                'system-uptime': { base: 99.97, variance: 0.01, suffix: '%' }
            };

            Object.keys(metrics).forEach(id => {
                const element = document.getElementById(id);
                if (element) {
                    const metric = metrics[id];
                    const variance = (Math.random() - 0.5) * metric.variance;
                    const newValue = metric.base + variance;
                    
                    if (id === 'revenue-today') {
                        element.textContent = '$' + Math.floor(newValue).toLocaleString();
                    } else if (metric.suffix) {
                        element.textContent = newValue.toFixed(2) + metric.suffix;
                    } else {
                        element.textContent = Math.floor(newValue).toLocaleString();
                    }
                }
            });
        }

        // Real-time chart
        function initRealtimeChart() {
            const ctx = document.getElementById('realtimeChart');
            if (!ctx) return;

            const chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: Array.from({length: 20}, (_, i) => ''),
                    datasets: [{
                        label: 'Bandwidth Usage',
                        data: Array.from({length: 20}, () => Math.random() * 100),
                        borderColor: 'rgb(26, 54, 93)',
                        backgroundColor: 'rgba(26, 54, 93, 0.1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        x: {
                            display: false
                        },
                        y: {
                            display: false,
                            beginAtZero: true,
                            max: 100
                        }
                    },
                    elements: {
                        point: {
                            radius: 0
                        }
                    }
                }
            });

            // Update chart every 2 seconds
            setInterval(() => {
                chart.data.datasets[0].data.shift();
                chart.data.datasets[0].data.push(Math.random() * 100);
                chart.update('none');
            }, 2000);
        }

        // Update metrics every 3 seconds
        setInterval(updateDashboardMetrics, 3000);

        // Initialize chart when page loads
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(initRealtimeChart, 1000);
        });
    </script>
</body>
</html>