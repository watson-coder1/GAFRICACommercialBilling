<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Learn about Glinta Africa's mission to transform African telecommunications. Professional ISP billing solutions built for African markets with mobile money integration.">
    <meta name="keywords" content="Glinta Africa, ISP solutions, African telecommunications, mobile money billing, professional network management, enterprise ISP platform">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/about">
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

        /* Stats Cards */
        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            text-align: center;
            height: 100%;
        }

        .stats-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            font-family: 'JetBrains Mono', monospace;
            margin-bottom: 0.5rem;
        }

        .stats-label {
            font-weight: 500;
            color: var(--gray-700);
            font-size: 0.875rem;
        }

        /* Mission Section */
        .mission-section {
            background: var(--gray-50);
            padding: 4rem 0;
        }

        .mission-card {
            background: white;
            border-radius: 12px;
            padding: 3rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            text-align: center;
        }

        .mission-icon {
            width: 80px;
            height: 80px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 2rem;
        }

        /* Values Section */
        .value-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            text-align: center;
            height: 100%;
        }

        .value-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .value-icon {
            width: 64px;
            height: 64px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.75rem;
            margin: 0 auto 1.5rem;
        }

        /* Timeline */
        .timeline {
            position: relative;
            padding: 2rem 0;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 2px;
            height: 100%;
            background: var(--gray-300);
        }

        .timeline-item {
            position: relative;
            margin-bottom: 3rem;
        }

        .timeline-content {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            width: 45%;
        }

        .timeline-item:nth-child(odd) .timeline-content {
            margin-left: auto;
        }

        .timeline-item:nth-child(even) .timeline-content {
            margin-right: auto;
        }

        .timeline-badge {
            position: absolute;
            top: 1rem;
            left: 50%;
            transform: translateX(-50%);
            width: 40px;
            height: 40px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .timeline-year {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        /* Team Section */
        .team-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            text-align: center;
            height: 100%;
        }

        .team-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .team-avatar {
            width: 100px;
            height: 100px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 1.5rem;
        }

        .team-name {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .team-role {
            color: var(--accent);
            font-weight: 500;
            font-size: 0.875rem;
            margin-bottom: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Impact Section */
        .impact-section {
            background: var(--primary);
            color: white;
            padding: 4rem 0;
        }

        .impact-item {
            text-align: center;
            padding: 1.5rem;
        }

        .impact-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--accent);
            font-family: 'JetBrains Mono', monospace;
            margin-bottom: 0.5rem;
        }

        .impact-label {
            font-size: 0.875rem;
            color: rgba(255, 255, 255, 0.9);
        }

        /* CTA Section */
        .cta-section {
            background: var(--gray-50);
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
            
            .timeline::before {
                left: 2rem;
            }
            
            .timeline-content {
                width: calc(100% - 5rem);
                margin-left: 5rem !important;
            }
            
            .timeline-badge {
                left: 2rem;
                transform: translateX(-50%);
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
                    <h1 class="display-2">About Glinta Africa</h1>
                    <p class="lead">Professional ISP solutions built for African telecommunications. We provide enterprise-grade billing and network management platforms designed specifically for African markets.</p>
                    <div class="mt-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-accent me-3">
                            <i class="fas fa-external-link-alt me-2"></i>View Platform
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary">
                            <i class="fas fa-envelope me-2"></i>Contact Us
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Mission Section -->
    <section class="mission-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="mission-card" data-aos="fade-up">
                        <div class="mission-icon">
                            <i class="fas fa-bullseye"></i>
                        </div>
                        <h2 class="mb-3">Our Mission</h2>
                        <p class="text-lg text-gray-600 mb-4">To empower African telecommunications infrastructure with professional-grade billing and network management solutions that integrate seamlessly with local payment systems and business practices.</p>
                        <p class="text-gray-600">We believe that reliable internet connectivity is fundamental to economic growth, education, and innovation across Africa. Our platform enables ISPs to build sustainable businesses while serving their communities with professional, efficient network services.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Trusted by ISPs Across Africa</h2>
                    <p class="text-lg text-gray-600">Professional solutions powering telecommunications infrastructure</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="stats-card">
                        <div class="stats-number" id="isps">150+</div>
                        <div class="stats-label">ISPs Deployed</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="stats-card">
                        <div class="stats-number" id="customers">500K+</div>
                        <div class="stats-label">End Users Served</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="stats-card">
                        <div class="stats-number" id="countries">15</div>
                        <div class="stats-label">African Countries</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="stats-card">
                        <div class="stats-number" id="uptime">99.9%</div>
                        <div class="stats-label">Platform Uptime</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Story Timeline -->
    <section class="py-5" style="background: white;">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Our Journey</h2>
                    <p class="text-lg text-gray-600">Building professional ISP solutions for African markets</p>
                </div>
            </div>
            <div class="timeline">
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-badge">2020</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2020</div>
                        <h5>Platform Foundation</h5>
                        <p class="text-gray-600">Launched the first professional ISP billing platform designed specifically for African telecommunications markets with native mobile money integration.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-left">
                    <div class="timeline-badge">2021</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2021</div>
                        <h5>RADIUS Integration</h5>
                        <p class="text-gray-600">Introduced enterprise-grade RADIUS authentication with AAA support, enabling professional network access control for ISPs across East Africa.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-badge">2022</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2022</div>
                        <h5>Network Automation</h5>
                        <p class="text-gray-600">Launched automated network device management with support for Mikrotik, Ubiquiti, and SNMP-enabled equipment, reducing operational overhead by 60%.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-left">
                    <div class="timeline-badge">2023</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2023</div>
                        <h5>Enterprise Features</h5>
                        <p class="text-gray-600">Introduced enterprise-grade security, compliance management, and advanced analytics to serve large-scale ISP deployments across multiple African countries.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-badge">2024</div>
                    <div class="timeline-content">
                        <div class="timeline-year">2024</div>
                        <h5>Platform Evolution</h5>
                        <p class="text-gray-600">Launched next-generation platform with advanced technical capabilities, serving professional ISPs across 15 African countries with enterprise-grade reliability.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Values Section -->
    <section class="py-5" style="background: var(--gray-50);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Our Values</h2>
                    <p class="text-lg text-gray-600">Principles that guide our platform development and customer service</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <h5>Technical Excellence</h5>
                        <p class="text-sm text-gray-600">We build enterprise-grade solutions with industry-standard protocols, security frameworks, and performance optimization for professional ISP operations.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-globe-africa"></i>
                        </div>
                        <h5>African-Focused</h5>
                        <p class="text-sm text-gray-600">Our platform is designed for African telecommunications infrastructure, with native support for local payment systems and regulatory requirements.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5>Enterprise Security</h5>
                        <p class="text-sm text-gray-600">Bank-grade security with compliance management, audit trails, and enterprise authentication for mission-critical ISP operations.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>Professional Support</h5>
                        <p class="text-sm text-gray-600">24/7 technical support with dedicated account management and SLA-backed response times for enterprise customers.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5>Scalable Architecture</h5>
                        <p class="text-sm text-gray-600">Cloud-native architecture that scales from small ISPs to enterprise deployments with multi-tenant support and unlimited growth potential.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-sync-alt"></i>
                        </div>
                        <h5>Continuous Innovation</h5>
                        <p class="text-sm text-gray-600">Regular platform updates with new features, security enhancements, and technology integrations to stay ahead of industry requirements.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Impact Section -->
    <section class="impact-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2 style="color: white;">Platform Impact</h2>
                    <p class="text-lg" style="color: rgba(255,255,255,0.9);">Measurable results from our professional ISP solutions</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="impact-item">
                        <div class="impact-number">98%</div>
                        <div class="impact-label">Payment Success Rate</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="impact-item">
                        <div class="impact-number">65%</div>
                        <div class="impact-label">Operational Cost Reduction</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="impact-item">
                        <div class="impact-number">3x</div>
                        <div class="impact-label">Faster Customer Onboarding</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="impact-item">
                        <div class="impact-number">24/7</div>
                        <div class="impact-label">Technical Support</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">Ready to Transform Your ISP Operations?</h2>
                    <p class="text-lg text-gray-600 mb-4">Contact our technical team to discuss your requirements and see how our professional platform can enhance your telecommunications infrastructure.</p>
                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-primary">
                            <i class="fas fa-envelope me-2"></i>Email: watsonwambugu@yahoo.com
                        </a>
                        <a href="https://wa.me/254711503023" target="_blank" class="btn btn-accent">
                            <i class="fab fa-whatsapp me-2"></i>WhatsApp: +254 711 503 023
                        </a>
                    </div>
                    <div class="mt-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-outline-primary">
                            <i class="fas fa-external-link-alt me-2"></i>Explore Platform
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
                    <p class="text-sm text-gray-400 mb-3">Professional ISP billing and network management solutions for African telecommunications infrastructure. Enterprise-grade platform built for African markets.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-gray-400"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Company</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/about">About Us</a>
                        <a href="{$app_url}/blog">Blog</a>
                        <a href="#">Careers</a>
                        <a href="#">Press</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Platform</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/features">Features</a>
                        <a href="{$app_url}/services">Services</a>
                        <a href="{$app_url}/pricing">Pricing</a>
                        <a href="https://glintaafrica.com/admin" target="_blank">Dashboard</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Support</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="#">Documentation</a>
                        <a href="{$app_url}/contact">Contact</a>
                        <a href="#">API Reference</a>
                        <a href="#">System Status</a>
                    </div>
                </div>
                <div class="col-lg-2">
                    <h6>Contact</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="mailto:watsonwambugu@yahoo.com">Technical Sales</a>
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
                    <p class="text-sm text-gray-500 mb-0">Professional solutions for African telecommunications</p>
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

        // Animate stats counters
        function animateCounter(element, target, suffix = '') {
            let current = 0;
            const increment = target / 100;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = target + suffix;
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current) + suffix;
                }
            }, 20);
        }

        // Animate counters when they come into view
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const element = entry.target;
                    const text = element.textContent;
                    
                    if (text.includes('+')) {
                        const num = parseInt(text.replace(/[^\d]/g, ''));
                        const suffix = text.includes('K') ? 'K+' : '+';
                        animateCounter(element, num, suffix);
                    } else if (text.includes('%')) {
                        const num = parseFloat(text.replace('%', ''));
                        animateCounter(element, num, '%');
                    } else if (text.includes('x')) {
                        const num = parseInt(text.replace('x', ''));
                        animateCounter(element, num, 'x');
                    } else if (!isNaN(parseInt(text))) {
                        const num = parseInt(text);
                        animateCounter(element, num);
                    }
                }
            });
        });

        // Observe all stat numbers
        document.querySelectorAll('.stats-number, .impact-number').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>