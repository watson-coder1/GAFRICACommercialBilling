<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Learn about Glinta Africa's mission to transform internet access across Africa through innovative billing solutions and mobile money integration.">
    <meta name="keywords" content="Glinta Africa, ISP solutions, African internet, mobile money billing, internet billing company">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/about">
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

        /* Content Sections */
        .content-section {
            padding: 5rem 0;
        }

        .content-section h2 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 2.5rem;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 2rem;
        }

        .content-section .lead {
            font-size: 1.2rem;
            color: var(--gray);
            margin-bottom: 3rem;
        }

        /* Stats Cards */
        .stats-card {
            background: var(--white);
            border-radius: 20px;
            padding: 3rem 2rem;
            box-shadow: var(--shadow);
            transition: all 0.4s ease;
            border: 1px solid rgba(212, 175, 55, 0.1);
            text-align: center;
        }

        .stats-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-gold);
        }

        .stats-number {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 3rem;
            font-weight: 700;
            color: var(--gold);
            margin-bottom: 1rem;
        }

        .stats-label {
            font-weight: 600;
            color: var(--black);
        }

        /* Team Section */
        .team-card {
            background: var(--white);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow);
            transition: all 0.4s ease;
            text-align: center;
        }

        .team-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-gold);
        }

        .team-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: var(--gradient-gold);
            margin: 0 auto 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: var(--black);
        }

        .team-name {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 0.5rem;
        }

        .team-role {
            color: var(--gold);
            font-weight: 600;
            margin-bottom: 1rem;
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
            
            .content-section h2 {
                font-size: 2rem;
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
                    <h1>About Glinta Africa</h1>
                    <p class="lead" style="color: rgba(255, 255, 255, 0.9);">
                        Transforming internet access across Africa through innovative billing solutions and mobile money integration.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Mission Section -->
    <section class="content-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2>Our Mission</h2>
                    <p class="lead">
                        To democratize internet access across Africa by providing ISPs with cutting-edge billing solutions that integrate seamlessly with local payment systems and cultural preferences.
                    </p>
                    <p style="color: var(--gray); font-size: 1.1rem;">
                        We believe that internet connectivity is a fundamental driver of economic growth, education, and social development. Our platform empowers African ISPs to build sustainable businesses while serving their communities with reliable, affordable internet access.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="py-5" style="background: var(--white-soft);">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-3 col-md-6" data-aos="fade-up">
                    <div class="stats-card">
                        <div class="stats-number">500+</div>
                        <div class="stats-label">ISPs Served</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="stats-card">
                        <div class="stats-number">2M+</div>
                        <div class="stats-label">Customers Connected</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="stats-card">
                        <div class="stats-number">25</div>
                        <div class="stats-label">Countries</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="stats-card">
                        <div class="stats-number">99.9%</div>
                        <div class="stats-label">Uptime</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Story Section -->
    <section class="content-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-6" data-aos="fade-right">
                    <h2>Our Story</h2>
                    <p style="color: var(--gray); font-size: 1.1rem;">
                        Founded in 2018, Glinta Africa emerged from a simple observation: traditional internet billing solutions weren't designed for African markets. While global platforms focused on credit card payments and Western banking systems, African ISPs struggled with customer acquisition and payment collection.
                    </p>
                    <p style="color: var(--gray); font-size: 1.1rem;">
                        Our founders recognized that mobile money adoption across Africa presented a unique opportunity to reimagine internet billing. By building the first ISP platform natively integrated with M-Pesa, Airtel Money, and other African payment systems, we've helped ISPs reduce payment friction by over 80%.
                    </p>
                    <p style="color: var(--gray); font-size: 1.1rem;">
                        Today, we're proud to power internet connectivity for millions of Africans, from bustling cities to remote rural communities. Our platform has become the backbone for ISPs across 25 African countries, processing millions of payments monthly and enabling new business models that were previously impossible.
                    </p>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <img src="https://images.unsplash.com/photo-1573164713714-d95e436ab8d6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="African Technology" class="img-fluid rounded-3 shadow-lg">
                </div>
            </div>
        </div>
    </section>

    <!-- Values Section -->
    <section class="py-5" style="background: var(--white-soft);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2>Our Values</h2>
                    <p class="lead" style="color: var(--gray);">
                        The principles that guide everything we do.
                    </p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4" data-aos="fade-up">
                    <div class="text-center">
                        <div style="color: var(--gold); font-size: 3rem; margin-bottom: 1rem;">
                            <i class="fas fa-heart"></i>
                        </div>
                        <h4 style="color: var(--black); margin-bottom: 1rem;">African-First</h4>
                        <p style="color: var(--gray);">
                            We design solutions specifically for African markets, understanding local needs, payment preferences, and business cultures.
                        </p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center">
                        <div style="color: var(--gold); font-size: 3rem; margin-bottom: 1rem;">
                            <i class="fas fa-users"></i>
                        </div>
                        <h4 style="color: var(--black); margin-bottom: 1rem;">Community Impact</h4>
                        <p style="color: var(--gray);">
                            Every ISP we empower creates jobs, enables education, and drives economic growth in their community.
                        </p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center">
                        <div style="color: var(--gold); font-size: 3rem; margin-bottom: 1rem;">
                            <i class="fas fa-rocket"></i>
                        </div>
                        <h4 style="color: var(--black); margin-bottom: 1rem;">Innovation</h4>
                        <p style="color: var(--gray);">
                            We continuously innovate to leapfrog traditional limitations and create new possibilities for African connectivity.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="content-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2>Leadership Team</h2>
                    <p class="lead" style="color: var(--gray);">
                        Experienced leaders driving Africa's digital transformation.
                    </p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4" data-aos="fade-up">
                    <div class="team-card">
                        <div class="team-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h4 class="team-name">Samuel Kiprotich</h4>
                        <div class="team-role">Chief Executive Officer</div>
                        <p style="color: var(--gray);">
                            15+ years in African telecommunications, former Safaricom executive with deep expertise in mobile money systems.
                        </p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="team-card">
                        <div class="team-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h4 class="team-name">Amina Hassan</h4>
                        <div class="team-role">Chief Technology Officer</div>
                        <p style="color: var(--gray);">
                            Software architect with 12 years building scalable platforms for emerging markets, PhD in Computer Science.
                        </p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="team-card">
                        <div class="team-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h4 class="team-name">Michael Ochieng</h4>
                        <div class="team-role">VP of Business Development</div>
                        <p style="color: var(--gray);">
                            Former ISP operator with 10 years experience building networks across Kenya, Uganda, and Tanzania.
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