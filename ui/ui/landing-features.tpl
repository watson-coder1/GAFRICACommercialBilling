<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Advanced features of Glinta Africa's enterprise ISP billing platform. Real-time monitoring, automated billing, mobile money integration, and comprehensive network management.">
    <meta name="keywords" content="ISP features, billing automation, mobile money, network monitoring, customer portal, hotspot management, RADIUS integration, enterprise features">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/features">
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
            font-size: 1.25rem;
            margin-bottom: 1rem;
            color: var(--dark);
        }

        .feature-description {
            color: var(--gray-600);
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
            color: var(--gray-600);
            font-size: 0.875rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .feature-list li:last-child {
            border-bottom: none;
        }

        .feature-list li i {
            color: var(--success);
            margin-right: 0.5rem;
            font-size: 0.75rem;
        }

        /* Technical Demo Section */
        .demo-section {
            background: var(--gray-50);
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
            background: var(--gradient-primary);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
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
            color: var(--primary);
            font-family: 'JetBrains Mono', monospace;
        }

        .metric-label {
            font-size: 0.875rem;
            color: var(--gray-600);
            margin-top: 0.5rem;
        }

        /* Code Demo */
        .code-demo {
            background: var(--dark);
            color: var(--gray-300);
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

        /* Footer with African Art Pattern */
        .footer {
            background: var(--gradient-black);
            color: var(--white);
            padding: 4rem 0 2rem;
            position: relative;
            overflow: hidden;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><pattern id="kente" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><rect width="10" height="10" fill="%23D4AF37" opacity="0.1"/><rect x="10" y="10" width="10" height="10" fill="%23D4AF37" opacity="0.1"/></pattern><rect width="100" height="100" fill="url(%23kente)"/></svg>');
            background-size: 100px 100px;
            opacity: 0.1;
        }

        .footer h6 {
            color: var(--gold);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .footer a {
            color: var(--white);
            text-decoration: none;
            font-size: 0.875rem;
            transition: all 0.3s ease;
            opacity: 0.8;
        }

        .footer a:hover {
            color: var(--gold);
            opacity: 1;
            transform: translateX(2px);
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
                    <h1 class="display-2">Enterprise Features</h1>
                    <p class="lead">Advanced capabilities designed for professional ISP operations. Real-time monitoring, automated billing, and comprehensive network management.</p>
                    <div class="mt-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-accent me-3">
                            <i class="fas fa-external-link-alt me-2"></i>Live Demo
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary">
                            <i class="fas fa-envelope me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Core Features -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Core Features</h2>
                    <p class="text-lg text-gray-600">Professional-grade capabilities for modern ISP operations</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-tachometer-alt"></i>
                        </div>
                        <h5 class="feature-title">Real-time Dashboard</h5>
                        <p class="feature-description">Comprehensive real-time monitoring with customizable widgets, alert systems, and performance metrics.</p>
                        <ul class="feature-list">
                            <li><i class="fas fa-check"></i> Live user sessions monitoring</li>
                            <li><i class="fas fa-check"></i> Bandwidth utilization graphs</li>
                            <li><i class="fas fa-check"></i> Revenue analytics</li>
                            <li><i class="fas fa-check"></i> Network topology view</li>
                            <li><i class="fas fa-check"></i> Custom alert configuration</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">Real-time</span>
                            <span class="badge bg-light text-dark me-1">Analytics</span>
                            <span class="badge bg-light text-dark">Alerts</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <h5 class="feature-title">Automated Billing</h5>
                        <p class="feature-description">Intelligent billing automation with flexible pricing models, tax calculations, and payment processing.</p>
                        <ul class="feature-list">
                            <li><i class="fas fa-check"></i> Recurring billing automation</li>
                            <li><i class="fas fa-check"></i> Multiple pricing models</li>
                            <li><i class="fas fa-check"></i> Pro-rata calculations</li>
                            <li><i class="fas fa-check"></i> Tax compliance engine</li>
                            <li><i class="fas fa-check"></i> Invoice generation</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">Automation</span>
                            <span class="badge bg-light text-dark me-1">Billing</span>
                            <span class="badge bg-light text-dark">Invoicing</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5 class="feature-title">Mobile Money Integration</h5>
                        <p class="feature-description">Native integration with African mobile money platforms for seamless payment processing.</p>
                        <ul class="feature-list">
                            <li><i class="fas fa-check"></i> M-Pesa STK Push</li>
                            <li><i class="fas fa-check"></i> Airtel Money support</li>
                            <li><i class="fas fa-check"></i> MTN MoMo integration</li>
                            <li><i class="fas fa-check"></i> Automated reconciliation</li>
                            <li><i class="fas fa-check"></i> Payment webhooks</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">M-Pesa</span>
                            <span class="badge bg-light text-dark me-1">Mobile Money</span>
                            <span class="badge bg-light text-dark">API</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h5 class="feature-title">Network Automation</h5>
                        <p class="feature-description">Automated network device management with bulk operations and configuration templates.</p>
                        <ul class="feature-list">
                            <li><i class="fas fa-check"></i> Mikrotik RouterOS API</li>
                            <li><i class="fas fa-check"></i> Ubiquiti UniFi integration</li>
                            <li><i class="fas fa-check"></i> SNMP monitoring</li>
                            <li><i class="fas fa-check"></i> Bulk user provisioning</li>
                            <li><i class="fas fa-check"></i> Configuration templates</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">API</span>
                            <span class="badge bg-light text-dark me-1">SNMP</span>
                            <span class="badge bg-light text-dark">Automation</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5 class="feature-title">Customer Management</h5>
                        <p class="feature-description">Comprehensive customer relationship management with support ticket system and communication tools.</p>
                        <ul class="feature-list">
                            <li><i class="fas fa-check"></i> Customer portal</li>
                            <li><i class="fas fa-check"></i> Support ticket system</li>
                            <li><i class="fas fa-check"></i> SMS notifications</li>
                            <li><i class="fas fa-check"></i> Usage analytics</li>
                            <li><i class="fas fa-check"></i> Service history tracking</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">CRM</span>
                            <span class="badge bg-light text-dark me-1">Support</span>
                            <span class="badge bg-light text-dark">Portal</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="feature-title">Security & Compliance</h5>
                        <p class="feature-description">Enterprise-grade security features with compliance management and audit trails.</p>
                        <ul class="feature-list">
                            <li><i class="fas fa-check"></i> Role-based access control</li>
                            <li><i class="fas fa-check"></i> Two-factor authentication</li>
                            <li><i class="fas fa-check"></i> Audit logging</li>
                            <li><i class="fas fa-check"></i> Data encryption</li>
                            <li><i class="fas fa-check"></i> GDPR compliance</li>
                        </ul>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">Security</span>
                            <span class="badge bg-light text-dark me-1">2FA</span>
                            <span class="badge bg-light text-dark">GDPR</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Technical Demos -->
    <section class="demo-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Technical Capabilities</h2>
                    <p class="text-lg text-gray-600">Live demonstrations of system functionality</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="demo-card">
                        <div class="demo-header">
                            <div class="demo-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div>
                                <h6 class="mb-0">Real-time Metrics</h6>
                                <small class="text-gray-600">Live system performance data</small>
                            </div>
                        </div>
                        <canvas id="metricsChart" width="400" height="200"></canvas>
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
                                <small class="text-gray-600">Mobile money payment flow</small>
                            </div>
                        </div>
                        <div class="code-demo">
                            <div class="code-header">
                                <div class="code-dot red"></div>
                                <div class="code-dot yellow"></div>
                                <div class="code-dot green"></div>
                                <span class="text-xs text-gray-400 ms-2">payment_api.php</span>
                            </div>
                            <pre><code>// M-Pesa STK Push Integration
$payment = new MpesaAPI($config);
$response = $payment->stkPush([
    'amount' => 500,
    'phone' => '254711503023',
    'reference' => 'INV-001',
    'description' => 'Internet Package'
]);

if ($response['success']) {
    // Auto-provision service
    $radius->createUser($username, $password);
    $billing->activatePackage($userId, $packageId);
}</code></pre>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Performance Metrics -->
            <div class="metrics-grid" data-aos="fade-up" data-aos-delay="300">
                <div class="metric-item">
                    <div class="metric-value" id="activeUsers">1,247</div>
                    <div class="metric-label">Active Users</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="throughput">2.4 Gbps</div>
                    <div class="metric-label">Network Throughput</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="uptime">99.9%</div>
                    <div class="metric-label">System Uptime</div>
                </div>
                <div class="metric-item">
                    <div class="metric-value" id="transactions">4,891</div>
                    <div class="metric-label">Daily Transactions</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Integration Features -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>System Integrations</h2>
                    <p class="text-lg text-gray-600">Seamless integration with essential business systems</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-3">
                            <i class="fas fa-server"></i>
                        </div>
                        <h6>RADIUS Server</h6>
                        <p class="text-sm text-gray-600">FreeRADIUS integration for authentication and accounting</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-3">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h6>Email & SMS</h6>
                        <p class="text-sm text-gray-600">Automated notifications and marketing campaigns</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-3">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h6>Analytics</h6>
                        <p class="text-sm text-gray-600">Advanced reporting with business intelligence</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-3">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <h6>API Access</h6>
                        <p class="text-sm text-gray-600">RESTful API for custom integrations and development</p>
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
                    <h2 class="mb-4">Experience These Features Live</h2>
                    <p class="text-lg mb-4" style="color: rgba(255,255,255,0.9);">Get hands-on experience with our enterprise features. Contact us for a personalized demonstration.</p>
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
                    <p class="text-sm text-gray-400 mb-3">Professional ISP billing and network management features for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-gray-400"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Features</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/features">Real-time Dashboard</a>
                        <a href="{$app_url}/features">Automated Billing</a>
                        <a href="{$app_url}/features">Mobile Money</a>
                        <a href="{$app_url}/features">Network Automation</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Platform</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/services">Services</a>
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
                    <p class="text-sm text-gray-500 mb-0">Advanced features for professional ISPs</p>
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

        // Real-time metrics chart
        const ctx = document.getElementById('metricsChart').getContext('2d');
        const metricsChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['00:00', '04:00', '08:00', '12:00', '16:00', '20:00', '24:00'],
                datasets: [{
                    label: 'Bandwidth (Mbps)',
                    data: [120, 90, 150, 280, 350, 420, 380],
                    borderColor: '#1a365d',
                    backgroundColor: 'rgba(26, 54, 93, 0.1)',
                    tension: 0.4,
                    fill: true
                }, {
                    label: 'Active Users',
                    data: [450, 320, 580, 890, 1200, 1450, 1380],
                    borderColor: '#d4af37',
                    backgroundColor: 'rgba(212, 175, 55, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0,0,0,0.1)'
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(0,0,0,0.1)'
                        }
                    }
                },
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
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

        // Animate counters when section comes into view
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const counters = entry.target.querySelectorAll('.metric-value');
                    counters.forEach(counter => {
                        const target = counter.textContent.replace(/[^\d]/g, '');
                        if (target) {
                            animateCounter(counter, parseInt(target));
                        }
                    });
                }
            });
        });

        observer.observe(document.querySelector('.metrics-grid'));

        // Live updates simulation
        setInterval(() => {
            const users = document.getElementById('activeUsers');
            const current = parseInt(users.textContent.replace(',', ''));
            const variation = Math.floor(Math.random() * 20) - 10;
            users.textContent = (current + variation).toLocaleString();
        }, 5000);
    </script>
</body>
</html>