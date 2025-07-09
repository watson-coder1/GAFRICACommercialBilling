<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Affordable pricing plans for African ISPs. Start from $29/month with mobile money integration, unlimited customers, and 24/7 support.">
    <meta name="keywords" content="ISP pricing, billing software cost, affordable ISP solution, mobile money billing, hotspot management pricing">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/pricing">
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

        /* Pricing Cards */
        .pricing-card {
            background: var(--white);
            border-radius: 20px;
            padding: 3rem 2rem;
            box-shadow: var(--shadow);
            transition: all 0.4s ease;
            border: 2px solid transparent;
            height: 100%;
            text-align: center;
        }

        .pricing-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-gold);
        }

        .pricing-card.featured {
            border-color: var(--gold);
            transform: scale(1.05);
        }

        .pricing-badge {
            background: var(--gradient-gold);
            color: var(--black);
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 2rem;
            display: inline-block;
        }

        .pricing-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 1rem;
        }

        .pricing-price {
            font-size: 3rem;
            font-weight: 700;
            color: var(--gold);
            margin-bottom: 0.5rem;
        }

        .pricing-period {
            color: var(--gray);
            margin-bottom: 2rem;
        }

        .pricing-features {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem;
            text-align: left;
        }

        .pricing-features li {
            padding: 0.8rem 0;
            color: var(--gray);
            border-bottom: 1px solid rgba(212, 175, 55, 0.1);
            display: flex;
            align-items: center;
        }

        .pricing-features li:last-child {
            border-bottom: none;
        }

        .pricing-features li i {
            color: var(--gold);
            margin-right: 1rem;
            width: 20px;
        }

        .btn-pricing {
            background: var(--gradient-gold);
            color: var(--black);
            border: none;
            padding: 1rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            width: 100%;
        }

        .btn-pricing:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-gold);
            color: var(--black);
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
            
            .pricing-card.featured {
                transform: none;
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
                    <h1>Simple, Transparent Pricing</h1>
                    <p class="lead" style="color: rgba(255, 255, 255, 0.9);">
                        Choose the perfect plan for your ISP business. All plans include mobile money integration and 24/7 support.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Starter</h3>
                        <div class="pricing-price">$29</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Up to 100 Customers</li>
                            <li><i class="fas fa-check"></i> Basic Hotspot Management</li>
                            <li><i class="fas fa-check"></i> Mobile Money Integration</li>
                            <li><i class="fas fa-check"></i> Customer Portal</li>
                            <li><i class="fas fa-check"></i> Email Support</li>
                            <li><i class="fas fa-check"></i> Basic Analytics</li>
                            <li><i class="fas fa-check"></i> 1 Router Support</li>
                        </ul>
                        <a href="{$app_url}/contact" class="btn-pricing">Get Started</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="pricing-card featured">
                        <div class="pricing-badge">Most Popular</div>
                        <h3 class="pricing-title">Professional</h3>
                        <div class="pricing-price">$79</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Up to 1,000 Customers</li>
                            <li><i class="fas fa-check"></i> Advanced Hotspot & PPPoE</li>
                            <li><i class="fas fa-check"></i> All Mobile Money Platforms</li>
                            <li><i class="fas fa-check"></i> Advanced Customer Portal</li>
                            <li><i class="fas fa-check"></i> Priority Support</li>
                            <li><i class="fas fa-check"></i> Advanced Analytics</li>
                            <li><i class="fas fa-check"></i> Up to 5 Routers</li>
                            <li><i class="fas fa-check"></i> Custom Branding</li>
                            <li><i class="fas fa-check"></i> API Access</li>
                        </ul>
                        <a href="{$app_url}/contact" class="btn-pricing">Get Started</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="pricing-card">
                        <h3 class="pricing-title">Enterprise</h3>
                        <div class="pricing-price">$199</div>
                        <div class="pricing-period">per month</div>
                        <ul class="pricing-features">
                            <li><i class="fas fa-check"></i> Unlimited Customers</li>
                            <li><i class="fas fa-check"></i> Full Platform Access</li>
                            <li><i class="fas fa-check"></i> Multi-location Support</li>
                            <li><i class="fas fa-check"></i> White-label Solution</li>
                            <li><i class="fas fa-check"></i> 24/7 Phone Support</li>
                            <li><i class="fas fa-check"></i> Advanced Reporting</li>
                            <li><i class="fas fa-check"></i> Unlimited Routers</li>
                            <li><i class="fas fa-check"></i> Custom Integrations</li>
                            <li><i class="fas fa-check"></i> Dedicated Account Manager</li>
                        </ul>
                        <a href="{$app_url}/contact" class="btn-pricing">Contact Sales</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Comparison -->
    <section class="py-5" style="background: var(--white-soft);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-5 fw-bold" style="color: var(--black);">All Plans Include</h2>
                    <p class="lead" style="color: var(--gray);">
                        Essential features included in every plan to help you succeed.
                    </p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6 text-center" data-aos="fade-up">
                    <div style="color: var(--gold); font-size: 3rem; margin-bottom: 1rem;">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <h4 style="color: var(--black);">Mobile Money</h4>
                    <p style="color: var(--gray);">M-Pesa, Airtel Money, MTN MoMo integration</p>
                </div>
                <div class="col-lg-3 col-md-6 text-center" data-aos="fade-up" data-aos-delay="100">
                    <div style="color: var(--gold); font-size: 3rem; margin-bottom: 1rem;">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h4 style="color: var(--black);">Security</h4>
                    <p style="color: var(--gray);">SSL encryption and fraud protection</p>
                </div>
                <div class="col-lg-3 col-md-6 text-center" data-aos="fade-up" data-aos-delay="200">
                    <div style="color: var(--gold); font-size: 3rem; margin-bottom: 1rem;">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h4 style="color: var(--black);">Support</h4>
                    <p style="color: var(--gray);">Email, chat, and phone support</p>
                </div>
                <div class="col-lg-3 col-md-6 text-center" data-aos="fade-up" data-aos-delay="300">
                    <div style="color: var(--gold); font-size: 3rem; margin-bottom: 1rem;">
                        <i class="fas fa-sync-alt"></i>
                    </div>
                    <h4 style="color: var(--black);">Updates</h4>
                    <p style="color: var(--gray);">Regular platform updates and new features</p>
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