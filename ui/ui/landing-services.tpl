<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Professional ISP billing services for African telecommunications. RADIUS authentication, mobile money integration, network automation, and enterprise-grade support.">
    <meta name="keywords" content="ISP billing services, RADIUS server, mobile money integration, network automation, telecommunications billing, African ISP solutions">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/services">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
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

        .display-2 { font-size: 3rem; font-weight: 700; }
        .text-lg { font-size: 1.125rem; }
        .text-sm { font-size: 0.875rem; }
        .text-xs { font-size: 0.75rem; }

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

        /* Service Cards */
        .service-card {
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

        .service-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .service-card.featured {
            border-color: var(--accent);
            position: relative;
            transform: scale(1.02);
        }

        .featured-badge {
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--gradient-primary);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .service-icon {
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

        .price-tag {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1rem;
            font-family: 'JetBrains Mono', monospace;
        }

        .service-title {
            font-size: 1.25rem;
            margin-bottom: 1rem;
            color: var(--dark);
        }

        .service-description {
            color: var(--gray-600);
            font-size: 0.875rem;
            margin-bottom: 1.5rem;
        }

        .service-features {
            list-style: none;
            padding: 0;
            margin-bottom: 2rem;
        }

        .service-features li {
            padding: 0.5rem 0;
            color: var(--gray-600);
            font-size: 0.875rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .service-features li:last-child {
            border-bottom: none;
        }

        .service-features li i {
            color: var(--success);
            margin-right: 0.5rem;
            font-size: 0.75rem;
        }

        /* Process Section */
        .process-section {
            background: white;
            padding: 4rem 0;
        }

        .process-step {
            text-align: center;
            padding: 1.5rem;
            position: relative;
        }

        .process-number {
            width: 60px;
            height: 60px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            font-weight: 600;
            color: white;
            font-family: 'JetBrains Mono', monospace;
        }

        /* Tech Stack */
        .tech-stack {
            background: var(--gray-50);
            padding: 4rem 0;
        }

        .tech-item {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            text-align: center;
            border: 1px solid var(--gray-200);
            transition: all 0.3s ease;
        }

        .tech-item:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
        }

        .tech-icon {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        /* CTA Section */
        .cta-section {
            background: var(--primary);
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
            .hero {
                padding: 6rem 0 3rem;
            }
            
            h1 { font-size: 2rem; }
            h2 { font-size: 1.75rem; }
            
            .service-card {
                padding: 1.5rem;
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
                    <h1 class="display-2">Professional ISP Services</h1>
                    <p class="lead">Comprehensive billing, authentication, and network management services designed for African telecommunications infrastructure. Enterprise-grade solutions with local payment integration.</p>
                    <div class="mt-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-accent me-3">
                            <i class="fas fa-external-link-alt me-2"></i>Launch Dashboard
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary">
                            <i class="fas fa-envelope me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Core Services -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Core Services</h2>
                    <p class="text-lg text-gray-600">Professional services designed for modern ISP operations</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <h5 class="service-title">RADIUS Authentication</h5>
                        <p class="service-description">Enterprise-grade RADIUS server with full AAA (Authentication, Authorization, Accounting) support for network access control.</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> RFC 2865/2866 compliant</li>
                            <li><i class="fas fa-check"></i> CoA (Change of Authorization)</li>
                            <li><i class="fas fa-check"></i> Dynamic VLAN assignment</li>
                            <li><i class="fas fa-check"></i> Load balancing & failover</li>
                            <li><i class="fas fa-check"></i> Real-time accounting</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">RADIUS</span>
                            <span class="badge bg-light text-dark me-1">AAA</span>
                            <span class="badge bg-light text-dark">CoA</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5 class="service-title">Mobile Money Integration</h5>
                        <p class="service-description">Native API integration with major African mobile money platforms for seamless payment processing and automated reconciliation.</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> M-Pesa STK Push integration</li>
                            <li><i class="fas fa-check"></i> Airtel Money API support</li>
                            <li><i class="fas fa-check"></i> MTN MoMo compatibility</li>
                            <li><i class="fas fa-check"></i> Automated reconciliation</li>
                            <li><i class="fas fa-check"></i> Real-time transaction status</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">M-Pesa</span>
                            <span class="badge bg-light text-dark me-1">API</span>
                            <span class="badge bg-light text-dark">Webhooks</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h5 class="service-title">Network Automation</h5>
                        <p class="service-description">Automated network provisioning and management via SNMP, SSH, and vendor-specific APIs for major equipment manufacturers.</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> Mikrotik RouterOS API</li>
                            <li><i class="fas fa-check"></i> Ubiquiti UniFi integration</li>
                            <li><i class="fas fa-check"></i> SNMP v2/v3 support</li>
                            <li><i class="fas fa-check"></i> SSH automation scripts</li>
                            <li><i class="fas fa-check"></i> Bulk configuration management</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">SNMP</span>
                            <span class="badge bg-light text-dark me-1">SSH</span>
                            <span class="badge bg-light text-dark">API</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5 class="service-title">Analytics & Monitoring</h5>
                        <p class="service-description">Real-time network monitoring, performance analytics, and business intelligence with customizable dashboards and alerting.</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> Real-time metrics collection</li>
                            <li><i class="fas fa-check"></i> Custom dashboard creation</li>
                            <li><i class="fas fa-check"></i> Automated alerting system</li>
                            <li><i class="fas fa-check"></i> Performance trend analysis</li>
                            <li><i class="fas fa-check"></i> SLA monitoring & reporting</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">InfluxDB</span>
                            <span class="badge bg-light text-dark me-1">Grafana</span>
                            <span class="badge bg-light text-dark">Alerts</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="service-title">Security & Compliance</h5>
                        <p class="service-description">Enterprise security framework with compliance management, audit trails, and security monitoring for regulated environments.</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> PCI DSS compliance</li>
                            <li><i class="fas fa-check"></i> GDPR data protection</li>
                            <li><i class="fas fa-check"></i> SOC 2 Type II controls</li>
                            <li><i class="fas fa-check"></i> Audit trail management</li>
                            <li><i class="fas fa-check"></i> Security incident response</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">PCI DSS</span>
                            <span class="badge bg-light text-dark me-1">GDPR</span>
                            <span class="badge bg-light text-dark">SOC 2</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h5 class="service-title">Support & Maintenance</h5>
                        <p class="service-description">24/7 technical support, proactive monitoring, regular updates, and dedicated account management for mission-critical operations.</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> 24/7 technical support</li>
                            <li><i class="fas fa-check"></i> Proactive system monitoring</li>
                            <li><i class="fas fa-check"></i> Regular security updates</li>
                            <li><i class="fas fa-check"></i> Dedicated account manager</li>
                            <li><i class="fas fa-check"></i> SLA-backed response times</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">24/7</span>
                            <span class="badge bg-light text-dark me-1">SLA</span>
                            <span class="badge bg-light text-dark">Support</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Implementation Process -->
    <section class="process-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Implementation Process</h2>
                    <p class="text-lg text-gray-600">Structured approach to deploying your ISP infrastructure</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="process-step">
                        <div class="process-number">1</div>
                        <h6>Requirements Analysis</h6>
                        <p class="text-sm text-gray-600">Technical assessment of your infrastructure and business requirements</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="process-step">
                        <div class="process-number">2</div>
                        <h6>System Configuration</h6>
                        <p class="text-sm text-gray-600">Custom configuration and integration with existing network equipment</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="process-step">
                        <div class="process-number">3</div>
                        <h6>Testing & Validation</h6>
                        <p class="text-sm text-gray-600">Comprehensive testing of all systems and failover procedures</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="process-step">
                        <div class="process-number">4</div>
                        <h6>Go-Live & Support</h6>
                        <p class="text-sm text-gray-600">Production deployment with ongoing monitoring and support</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Technology Stack -->
    <section class="tech-stack">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Technology Stack</h2>
                    <p class="text-lg text-gray-600">Built with enterprise-grade technologies and industry standards</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fab fa-php"></i>
                        </div>
                        <h6 class="text-sm">PHP 8.2</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <h6 class="text-sm">MySQL 8.0</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <h6 class="text-sm">FreeRADIUS</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fab fa-docker"></i>
                        </div>
                        <h6 class="text-sm">Docker</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h6 class="text-sm">InfluxDB</h6>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h6 class="text-sm">OpenSSL</h6>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Sample Hotspot Packages -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Sample Customer Packages</h2>
                    <p class="text-lg text-gray-600">Ready-to-use hotspot packages your customers will love - all configured automatically</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="service-card text-center">
                        <div class="service-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h5>Quick Access</h5>
                        <div class="price-tag">KSh 5 / 1 Hour</div>
                        <p class="text-sm text-gray-600 mb-3">Perfect for quick browsing and social media</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> 1 Hour Access</li>
                            <li><i class="fas fa-check"></i> Unlimited Bandwidth</li>
                            <li><i class="fas fa-check"></i> All Devices</li>
                            <li><i class="fas fa-check"></i> Instant Activation</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="service-card text-center">
                        <div class="service-icon">
                            <i class="fas fa-wifi"></i>
                        </div>
                        <h5>Extended Browse</h5>
                        <div class="price-tag">KSh 10 / 2 Hours</div>
                        <p class="text-sm text-gray-600 mb-3">Great for work sessions and streaming</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> 2 Hours Access</li>
                            <li><i class="fas fa-check"></i> Unlimited Bandwidth</li>
                            <li><i class="fas fa-check"></i> Multiple Devices</li>
                            <li><i class="fas fa-check"></i> Priority Support</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="service-card text-center featured">
                        <div class="featured-badge">Most Popular</div>
                        <div class="service-icon">
                            <i class="fas fa-calendar-day"></i>
                        </div>
                        <h5>Full Day Pass</h5>
                        <div class="price-tag">KSh 30 / 24 Hours</div>
                        <p class="text-sm text-gray-600 mb-3">Complete day coverage for business and entertainment</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> 24 Hours Access</li>
                            <li><i class="fas fa-check"></i> Unlimited Bandwidth</li>
                            <li><i class="fas fa-check"></i> All Devices</li>
                            <li><i class="fas fa-check"></i> Premium Support</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="service-card text-center">
                        <div class="service-icon">
                            <i class="fas fa-calendar-week"></i>
                        </div>
                        <h5>Weekly Package</h5>
                        <div class="price-tag">KSh 150 / 7 Days</div>
                        <p class="text-sm text-gray-600 mb-3">Best value for regular users and students</p>
                        <ul class="service-features">
                            <li><i class="fas fa-check"></i> 7 Days Access</li>
                            <li><i class="fas fa-check"></i> Unlimited Bandwidth</li>
                            <li><i class="fas fa-check"></i> Multiple Devices</li>
                            <li><i class="fas fa-check"></i> 24/7 Support</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="text-center mt-5" data-aos="fade-up" data-aos-delay="500">
                <div class="alert alert-info d-inline-block">
                    <i class="fas fa-info-circle me-2"></i>
                    <strong>For ISP Owners:</strong> These packages are pre-configured in our system. You can customize prices, duration, and features to match your market.
                </div>
                <div class="mt-3">
                    <a href="{$app_url}/pricing" class="btn btn-primary me-3">
                        <i class="fas fa-dollar-sign me-2"></i>View Platform Pricing
                    </a>
                    <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-outline-primary">
                        <i class="fas fa-cogs me-2"></i>Configure Packages
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">Ready to Deploy Professional ISP Services?</h2>
                    <p class="text-lg mb-4" style="color: rgba(255,255,255,0.9);">Contact our technical team to discuss your requirements and get a customized solution.</p>
                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-accent">
                            <i class="fas fa-envelope me-2"></i>Email: watsonwambugu@yahoo.com
                        </a>
                        <a href="https://wa.me/254711503023" target="_blank" class="btn btn-outline-primary" style="color: white; border-color: white;">
                            <i class="fab fa-whatsapp me-2"></i>WhatsApp: +254 711 503 023
                        </a>
                    </div>
                    <div class="mt-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-outline-primary" style="color: white; border-color: white;">
                            <i class="fas fa-external-link-alt me-2"></i>Access Dashboard
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
                    <p class="text-sm text-gray-400 mb-3">Professional ISP billing and network management services for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-gray-400"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Services</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/services">RADIUS Server</a>
                        <a href="{$app_url}/services">Mobile Money</a>
                        <a href="{$app_url}/services">Network Automation</a>
                        <a href="{$app_url}/services">Analytics</a>
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
                    <h6>Support</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="#">Documentation</a>
                        <a href="{$app_url}/blog">Blog</a>
                        <a href="{$app_url}/about">About</a>
                        <a href="{$app_url}/contact">Contact</a>
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
                    <p class="text-sm text-gray-500 mb-0">Professional ISP solutions for Africa</p>
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
    </script>
</body>
</html>