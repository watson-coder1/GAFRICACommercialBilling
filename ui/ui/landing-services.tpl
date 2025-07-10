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
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
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

        /* Hero Section with Tech Background */
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 80vh;
            color: white;
            padding: 8rem 0 4rem;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
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

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 80px;
            height: 80px;
            background: linear-gradient(45deg, var(--gold) 0%, var(--gold-light) 100%);
            opacity: 0.05;
            border-radius: 50%;
            transform: translate(25px, -25px);
            transition: all 0.3s ease;
        }

        .service-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }
        
        .service-card:hover::before {
            opacity: 0.1;
            transform: translate(20px, -20px) scale(1.1);
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

        /* Process Section with Pattern */
        .process-section {
            background: linear-gradient(rgba(248, 248, 248, 0.95), rgba(248, 248, 248, 0.95)),
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 60 60"><defs><pattern id="dots" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="2" fill="%23D4AF37" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23dots)"/></svg>');
            padding: 4rem 0;
            position: relative;
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
                        <a class="btn btn-primary" href="#demo-section">
                            <i class="fas fa-play me-1"></i>Live Demo
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
                    <h1 class="display-2">🚀 Services That Actually <span style="color: var(--gold); animation: glow 2s ease-in-out infinite alternate;">Work</span>!</h1>
                    <p class="lead">Forget complicated setups and midnight debugging sessions 🌙<br>
We've built everything you need to run a successful ISP without losing your sanity! 🤪</p>
                    <div class="mt-4">
                        <a href="#demo-section" class="btn btn-accent me-3">
                            <i class="fas fa-play me-2"></i>Try Demo
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary">
                            <i class="fas fa-envelope me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Visual Showcase -->
    <section class="py-5" style="background: url('https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <div class="bg-white p-4 rounded shadow">
                        <h3 class="text-dark">Live System Overview</h3>
                        <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=300&q=80" 
                             alt="Dashboard Preview" class="img-fluid rounded mb-3">
                        <p class="text-muted">Real-time monitoring of your entire network infrastructure</p>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <div class="bg-white p-4 rounded shadow">
                        <h3 class="text-dark">Mobile Integration</h3>
                        <img src="https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=300&q=80" 
                             alt="Mobile Payments" class="img-fluid rounded mb-3">
                        <p class="text-muted">Seamless mobile money integration for African markets</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Core Services -->
    <section class="py-5" style="background: linear-gradient(rgba(248,248,248,0.9), rgba(248,248,248,0.9)), url('https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                         alt="ISP Services" class="img-fluid rounded shadow">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h2>Core Services</h2>
                    <p class="text-lg text-gray-600">Professional services for modern ISPs</p>
                    <div class="row g-3 mt-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">5+</h4>
                                <small class="text-muted">Core Services</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">24/7</h4>
                                <small class="text-muted">Support</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="RADIUS Server" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <h5 class="service-title">RADIUS Authentication</h5>
                        <p class="service-description">Enterprise RADIUS server with AAA support.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">RFC Compliant</span>
                            <span class="badge bg-light text-dark">CoA Support</span>
                            <span class="badge bg-light text-dark">Load Balancing</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">RADIUS</span>
                            <span class="badge bg-light text-dark me-1">AAA</span>
                            <span class="badge bg-light text-dark">CoA</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Mobile Money" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h5 class="service-title">Mobile Money Integration</h5>
                        <p class="service-description">Native API integration with African mobile money platforms.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">M-Pesa STK</span>
                            <span class="badge bg-light text-dark">Airtel Money</span>
                            <span class="badge bg-light text-dark">MTN MoMo</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">M-Pesa</span>
                            <span class="badge bg-light text-dark me-1">API</span>
                            <span class="badge bg-light text-dark">Webhooks</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1544197150-b99a580bb7a8?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Network Automation" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <h5 class="service-title">Network Automation</h5>
                        <p class="service-description">Automated network provisioning via SNMP, SSH, and APIs.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">Mikrotik API</span>
                            <span class="badge bg-light text-dark">UniFi</span>
                            <span class="badge bg-light text-dark">SNMP</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">SNMP</span>
                            <span class="badge bg-light text-dark me-1">SSH</span>
                            <span class="badge bg-light text-dark">API</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Analytics Dashboard" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5 class="service-title">Analytics & Monitoring</h5>
                        <p class="service-description">Real-time monitoring with customizable dashboards and alerts.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">Real-time</span>
                            <span class="badge bg-light text-dark">Dashboards</span>
                            <span class="badge bg-light text-dark">Alerts</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">InfluxDB</span>
                            <span class="badge bg-light text-dark me-1">Grafana</span>
                            <span class="badge bg-light text-dark">Alerts</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1563013544-824ae1b704d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Security" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="service-title">Security & Compliance</h5>
                        <p class="service-description">Enterprise security with compliance management and audit trails.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">PCI DSS</span>
                            <span class="badge bg-light text-dark">GDPR</span>
                            <span class="badge bg-light text-dark">SOC 2</span>
                        </div>
                        <div class="mt-3">
                            <span class="badge bg-light text-dark me-1">Security</span>
                            <span class="badge bg-light text-dark me-1">Compliance</span>
                            <span class="badge bg-light text-dark">Audit</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="service-card">
                        <div class="mb-3">
                            <img src="https://images.unsplash.com/photo-1556761175-b413da4baf72?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=200&q=80" 
                                 alt="Support Team" class="img-fluid rounded" style="height: 150px; width: 100%; object-fit: cover;">
                        </div>
                        <div class="service-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h5 class="service-title">Support & Maintenance</h5>
                        <p class="service-description">24/7 technical support with proactive monitoring and updates.</p>
                        <div class="d-flex flex-wrap gap-1 mb-3">
                            <span class="badge bg-light text-dark">24/7 Support</span>
                            <span class="badge bg-light text-dark">Monitoring</span>
                            <span class="badge bg-light text-dark">SLA</span>
                        </div>
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

    <!-- Visual Implementation Process -->
    <section class="py-5" style="background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2 class="text-white">Quick Implementation</h2>
                    <p class="text-white-50 mb-4">Get your ISP services running in days, not months.</p>
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded">
                                <h4 class="text-primary mb-1">3</h4>
                                <small class="text-muted">Days Setup</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded">
                                <h4 class="text-primary mb-1">24/7</h4>
                                <small class="text-muted">Support</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                         alt="Implementation Process" class="img-fluid rounded shadow">
                </div>
            </div>
        </div>
    </section>

    <!-- Technology Stack -->
    <section class="py-5" style="background: var(--gray-50);">
        <div class="container">
            <div class="row align-items-center mb-4">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2>Enterprise Technology</h2>
                    <p class="text-lg text-gray-600">Built with proven enterprise technologies.</p>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <img src="https://images.unsplash.com/photo-1518709268805-4e9042af2176?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&h=300&q=80" 
                         alt="Technology Stack" class="img-fluid rounded">
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

    <!-- Visual Packages Section -->
    <section class="py-5" style="background: linear-gradient(rgba(255,255,255,0.9), rgba(255,255,255,0.9)), url('https://images.unsplash.com/photo-1544197150-b99a580bb7a8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center;">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <img src="https://images.unsplash.com/photo-1521017432531-fbd92d768814?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                         alt="Hotspot Packages" class="img-fluid rounded shadow">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h2>Ready-to-Use Packages</h2>
                    <p class="text-lg text-gray-600">Pre-configured hotspot packages for instant deployment.</p>
                    <div class="row g-3 mt-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">50+</h4>
                                <small class="text-muted">Package Templates</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-white rounded shadow-sm">
                                <h4 class="text-primary mb-1">Auto</h4>
                                <small class="text-muted">Configuration</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-3">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center p-3 bg-white rounded shadow-sm">
                        <i class="fas fa-clock text-primary fs-2 mb-2"></i>
                        <h6>Hourly</h6>
                        <small class="text-muted">KSh 5-20</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center p-3 bg-white rounded shadow-sm">
                        <i class="fas fa-calendar-day text-primary fs-2 mb-2"></i>
                        <h6>Daily</h6>
                        <small class="text-muted">KSh 30-50</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center p-3 bg-white rounded shadow-sm">
                        <i class="fas fa-calendar-week text-primary fs-2 mb-2"></i>
                        <h6>Weekly</h6>
                        <small class="text-muted">KSh 150-300</small>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center p-3 bg-white rounded shadow-sm">
                        <i class="fas fa-calendar-alt text-primary fs-2 mb-2"></i>
                        <h6>Monthly</h6>
                        <small class="text-muted">KSh 500+</small>
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
                        <a href="#demo-section" class="btn btn-outline-primary" style="color: white; border-color: white;">
                            <i class="fas fa-play me-2"></i>Try Demo
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Demo Section -->
    <section class="py-5" id="demo-section" style="background: var(--gray-50);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2>Try Our Services</h2>
                    <p class="text-gray-600 mb-4">Experience the complete ISP services platform with live dashboard access.</p>
                    <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-primary btn-lg">
                        <i class="fas fa-external-link-alt me-2"></i>Launch Demo Dashboard
                    </a>
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
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-linkedin"></i></a>
                        <a href="#" style="color: var(--gold); font-size: 1.2rem; transition: all 0.3s ease;" onmouseover="this.style.color='var(--gold-light)'" onmouseout="this.style.color='var(--gold)'"><i class="fab fa-github"></i></a>
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
                        <a href="#demo-section">Demo</a>
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