<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Discover powerful features of Glinta Africa's internet billing platform. Mobile money integration, real-time analytics, automated billing, and more.">
    <meta name="keywords" content="ISP features, billing automation, mobile money, network monitoring, customer portal, hotspot management">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/features">
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

        /* Feature Cards */
        .feature-card {
            background: var(--white);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow);
            transition: all 0.4s ease;
            border: 1px solid rgba(212, 175, 55, 0.1);
            height: 100%;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-gold);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            background: var(--gradient-gold);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            color: var(--black);
        }

        .feature-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 1rem;
        }

        .feature-description {
            color: var(--gray);
            line-height: 1.6;
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
                    <h1>Platform Features</h1>
                    <p class="lead" style="color: rgba(255, 255, 255, 0.9);">
                        Powerful features designed to streamline your ISP operations and maximize revenue.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h3 class="feature-title">Mobile Money Integration</h3>
                        <p class="feature-description">
                            Seamless integration with M-Pesa, Airtel Money, MTN MoMo, and other African mobile money platforms for instant payment processing.
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h3 class="feature-title">Real-time Analytics</h3>
                        <p class="feature-description">
                            Comprehensive dashboards with real-time revenue tracking, usage analytics, and customer insights to make data-driven decisions.
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-cog"></i>
                        </div>
                        <h3 class="feature-title">Automated Billing</h3>
                        <p class="feature-description">
                            Fully automated billing cycles with recurring payments, invoice generation, and automatic service activation/suspension.
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-wifi"></i>
                        </div>
                        <h3 class="feature-title">Captive Portal</h3>
                        <p class="feature-description">
                            Customizable captive portal for hotspot authentication with branding options, terms acceptance, and payment integration.
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3 class="feature-title">Customer Portal</h3>
                        <p class="feature-description">
                            Self-service customer portal for account management, payment history, package purchases, and support ticket submission.
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-tachometer-alt"></i>
                        </div>
                        <h3 class="feature-title">Bandwidth Management</h3>
                        <p class="feature-description">
                            Advanced bandwidth control with speed profiles, fair usage policies, and dynamic bandwidth allocation based on usage patterns.
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-bell"></i>
                        </div>
                        <h3 class="feature-title">Automated Notifications</h3>
                        <p class="feature-description">
                            Smart notification system via SMS, email, and in-app messages for payment reminders, service updates, and promotional offers.
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="700">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3 class="feature-title">Security & Fraud Protection</h3>
                        <p class="feature-description">
                            Enterprise-grade security with fraud detection, secure payment processing, and compliance with data protection regulations.
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="800">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-api"></i>
                        </div>
                        <h3 class="feature-title">API Integration</h3>
                        <p class="feature-description">
                            RESTful APIs for third-party integrations, custom applications, and connection with existing business systems and tools.
                        </p>
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