<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Professional ISP billing platform pricing. Enterprise-grade features with transparent pricing for African telecommunications. Custom solutions available.">
    <meta name="keywords" content="ISP pricing, billing software cost, enterprise ISP solution, mobile money billing, professional network management pricing">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/pricing">
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
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.8)), 
                        url('https://images.unsplash.com/photo-1554224155-6726b3ff858f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
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

        /* Pricing Cards */
        .pricing-card {
            background: white;
            border-radius: 12px;
            padding: 2.5rem 2rem;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .pricing-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            background: linear-gradient(45deg, var(--gold) 0%, var(--gold-light) 100%);
            opacity: 0.03;
            border-radius: 50%;
            transform: translate(30px, -30px);
            transition: all 0.3s ease;
        }

        .pricing-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }
        
        .pricing-card:hover::before {
            opacity: 0.08;
            transform: translate(25px, -25px) scale(1.2);
        }

        .pricing-card.featured {
            border-color: var(--accent);
            box-shadow: var(--shadow-lg);
            transform: scale(1.02);
        }

        .pricing-card.featured::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-accent);
        }

        .pricing-badge {
            background: var(--gradient-accent);
            color: var(--primary);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1.5rem;
            display: inline-block;
        }

        .pricing-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .pricing-subtitle {
            color: var(--gray-600);
            font-size: 0.875rem;
            margin-bottom: 2rem;
        }

        .pricing-price {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            font-family: 'JetBrains Mono', monospace;
            margin-bottom: 0.25rem;
        }

        .pricing-period {
            color: var(--gray-500);
            font-size: 0.875rem;
            margin-bottom: 2rem;
        }

        .pricing-features {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem;
        }

        .pricing-features li {
            padding: 0.75rem 0;
            color: var(--gray-600);
            font-size: 0.875rem;
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            align-items: center;
        }

        .pricing-features li:last-child {
            border-bottom: none;
        }

        .pricing-features li i {
            color: var(--success);
            margin-right: 0.75rem;
            font-size: 0.75rem;
            width: 16px;
        }

        .pricing-features li.unavailable {
            color: var(--gray-400);
        }

        .pricing-features li.unavailable i {
            color: var(--gray-300);
        }

        /* Value Proposition */
        .value-section {
            background: var(--gray-50);
            padding: 4rem 0;
        }

        .value-card {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            text-align: center;
            border: 1px solid var(--gray-200);
            height: 100%;
            transition: all 0.3s ease;
        }

        .value-card:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
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

        /* ROI Calculator */
        .roi-section {
            background: white;
            padding: 4rem 0;
        }

        .roi-calculator {
            background: var(--gray-50);
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--gray-200);
        }

        .roi-metric {
            text-align: center;
            padding: 1.5rem;
            background: white;
            border-radius: 8px;
            border: 1px solid var(--gray-200);
        }

        .roi-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary);
            font-family: 'JetBrains Mono', monospace;
        }

        .roi-label {
            font-size: 0.875rem;
            color: var(--gray-600);
            margin-top: 0.5rem;
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

        .btn-pricing {
            width: 100%;
            justify-content: center;
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
            
            .pricing-card {
                padding: 2rem 1.5rem;
            }
            
            .pricing-card.featured {
                transform: none;
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
                    <h1 class="display-2">Enterprise Pricing</h1>
                    <p class="lead">Professional ISP billing solutions with transparent pricing. Choose the plan that scales with your business operations.</p>
                    <div class="mt-4">
                        <a href="https://glintaafrica.com/admin" target="_blank" class="btn btn-accent me-3">
                            <i class="fas fa-external-link-alt me-2"></i>View Demo
                        </a>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary">
                            <i class="fas fa-envelope me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Professional Plans</h2>
                    <p class="text-lg text-gray-600">Scalable solutions for ISPs of all sizes</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Starter</h3>
                        <p class="pricing-subtitle">Perfect for small ISPs getting started</p>
                        <div class="pricing-price">$10</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Up to 100 customers</li>
                            <li><i class="fas fa-check"></i> Basic RADIUS integration</li>
                            <li><i class="fas fa-check"></i> M-Pesa integration</li>
                            <li><i class="fas fa-check"></i> Customer portal</li>
                            <li><i class="fas fa-check"></i> Email support</li>
                            <li><i class="fas fa-check"></i> Basic reporting</li>
                            <li><i class="fas fa-check"></i> 2 network devices</li>
                            <li class="unavailable"><i class="fas fa-times"></i> API access</li>
                            <li class="unavailable"><i class="fas fa-times"></i> White-label branding</li>
                        </ul>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-primary btn-pricing">
                            <i class="fas fa-envelope me-2"></i>Get Started
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="pricing-card featured">
                        <div class="pricing-badge">Most Popular</div>
                        <h3 class="pricing-title">Professional</h3>
                        <p class="pricing-subtitle">Ideal for growing ISP operations</p>
                        <div class="pricing-price">$25</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Up to 500 customers</li>
                            <li><i class="fas fa-check"></i> Advanced RADIUS & CoA</li>
                            <li><i class="fas fa-check"></i> All mobile money platforms</li>
                            <li><i class="fas fa-check"></i> Advanced customer portal</li>
                            <li><i class="fas fa-check"></i> Priority support</li>
                            <li><i class="fas fa-check"></i> Advanced analytics</li>
                            <li><i class="fas fa-check"></i> 10 network devices</li>
                            <li><i class="fas fa-check"></i> REST API access</li>
                            <li><i class="fas fa-check"></i> Custom branding</li>
                        </ul>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-accent btn-pricing">
                            <i class="fas fa-envelope me-2"></i>Get Started
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Enterprise</h3>
                        <p class="pricing-subtitle">For large-scale ISP deployments</p>
                        <div class="pricing-price">$50</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Unlimited customers</li>
                            <li><i class="fas fa-check"></i> Full platform access</li>
                            <li><i class="fas fa-check"></i> Multi-tenant support</li>
                            <li><i class="fas fa-check"></i> White-label solution</li>
                            <li><i class="fas fa-check"></i> 24/7 phone support</li>
                            <li><i class="fas fa-check"></i> Custom integrations</li>
                            <li><i class="fas fa-check"></i> Unlimited devices</li>
                            <li><i class="fas fa-check"></i> Full API suite</li>
                            <li><i class="fas fa-check"></i> Dedicated support</li>
                        </ul>
                        <a href="mailto:watsonwambugu@yahoo.com" class="btn btn-outline-primary btn-pricing">
                            <i class="fas fa-envelope me-2"></i>Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Value Proposition -->
    <section class="value-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>Why Choose Glinta Africa</h2>
                    <p class="text-lg text-gray-600">Enterprise-grade features that deliver real business value</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h5>Faster Deployment</h5>
                        <p class="text-sm text-gray-600">Get up and running in 24 hours with our automated setup process</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5>Increased Revenue</h5>
                        <p class="text-sm text-gray-600">Average 35% revenue increase through automated billing and payments</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>Better Customer Experience</h5>
                        <p class="text-sm text-gray-600">Self-service portal reduces support tickets by 60%</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5>Enterprise Security</h5>
                        <p class="text-sm text-gray-600">Bank-grade security with 99.9% uptime SLA guarantee</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ROI Calculator -->
    <section class="roi-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="roi-calculator" data-aos="fade-up">
                        <div class="text-center mb-4">
                            <h3>Return on Investment</h3>
                            <p class="text-gray-600">See how much you can save with automated billing</p>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-3 col-sm-6">
                                <div class="roi-metric">
                                    <div class="roi-value">3x</div>
                                    <div class="roi-label">Faster Customer Onboarding</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="roi-metric">
                                    <div class="roi-value">60%</div>
                                    <div class="roi-label">Reduction in Support Tickets</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="roi-metric">
                                    <div class="roi-value">98%</div>
                                    <div class="roi-label">Payment Success Rate</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="roi-metric">
                                    <div class="roi-value">6</div>
                                    <div class="roi-label">Months to Break Even</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- All Plans Include -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5" data-aos="fade-up">
                    <h2>All Plans Include</h2>
                    <p class="text-lg text-gray-600">Essential features included in every plan</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center">
                        <div class="value-icon mx-auto mb-3">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h6>Mobile Money Integration</h6>
                        <p class="text-sm text-gray-600">M-Pesa, Airtel Money, MTN MoMo</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center">
                        <div class="value-icon mx-auto mb-3">
                            <i class="fas fa-server"></i>
                        </div>
                        <h6>RADIUS Authentication</h6>
                        <p class="text-sm text-gray-600">FreeRADIUS with AAA support</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center">
                        <div class="value-icon mx-auto mb-3">
                            <i class="fas fa-sync-alt"></i>
                        </div>
                        <h6>Regular Updates</h6>
                        <p class="text-sm text-gray-600">Monthly platform updates</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center">
                        <div class="value-icon mx-auto mb-3">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h6>24/7 Support</h6>
                        <p class="text-sm text-gray-600">Email and chat support</p>
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
                    <h2 class="mb-4">Ready to Transform Your ISP Operations?</h2>
                    <p class="text-lg mb-4" style="color: rgba(255,255,255,0.9);">Contact our sales team to discuss your requirements and get a customized quote.</p>
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
                            <i class="fas fa-external-link-alt me-2"></i>Explore Dashboard
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
                    <p class="text-sm text-gray-400 mb-3">Professional ISP billing and network management pricing for African telecommunications infrastructure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-gray-400"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Plans</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/pricing">Starter Plan</a>
                        <a href="{$app_url}/pricing">Professional</a>
                        <a href="{$app_url}/pricing">Enterprise</a>
                        <a href="{$app_url}/pricing">Custom Solutions</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Platform</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="{$app_url}/features">Features</a>
                        <a href="{$app_url}/services">Services</a>
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
                        <a href="mailto:watsonwambugu@yahoo.com">Email Sales</a>
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
                    <p class="text-sm text-gray-500 mb-0">Professional pricing for professional ISPs</p>
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

        // Animate ROI values
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const values = entry.target.querySelectorAll('.roi-value');
                    values.forEach(value => {
                        const text = value.textContent;
                        if (text.includes('x') || text.includes('%')) {
                            // Animate numeric values
                            const num = parseInt(text);
                            if (num) {
                                let current = 0;
                                const increment = num / 30;
                                const timer = setInterval(() => {
                                    current += increment;
                                    if (current >= num) {
                                        value.textContent = text;
                                        clearInterval(timer);
                                    } else {
                                        value.textContent = Math.floor(current) + text.replace(num, '');
                                    }
                                }, 50);
                            }
                        }
                    });
                }
            });
        });

        const roiSection = document.querySelector('.roi-calculator');
        if (roiSection) {
            observer.observe(roiSection);
        }
    </script>
</body>
</html>