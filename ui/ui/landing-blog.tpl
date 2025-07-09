<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Latest insights on internet billing, ISP management, and hotspot solutions in Africa. Expert tips for growing your internet business.">
    <meta name="keywords" content="ISP blog, internet billing, hotspot business, Africa ISP, WiFi monetization, internet service provider">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/blog">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Dynamic Visual Styles -->
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

        /* Blog Cards */
        .blog-card {
            background: var(--white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.4s ease;
            border: 1px solid rgba(212, 175, 55, 0.1);
            height: 100%;
        }

        .blog-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-gold);
        }

        .blog-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .blog-card:hover .blog-image {
            transform: scale(1.05);
        }

        .blog-content {
            padding: 2rem;
        }

        .blog-category {
            background: var(--gradient-gold);
            color: var(--black);
            padding: 0.3rem 1rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 1rem;
            display: inline-block;
        }

        .blog-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 1rem;
            line-height: 1.3;
        }

        .blog-excerpt {
            color: var(--gray);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .blog-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .blog-date {
            color: var(--gray);
            font-size: 0.9rem;
        }

        .blog-read-time {
            color: var(--gold);
            font-size: 0.9rem;
            font-weight: 600;
        }

        .blog-link {
            display: inline-flex;
            align-items: center;
            color: var(--gold);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .blog-link:hover {
            color: var(--gold-dark);
            transform: translateX(5px);
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
            
            .blog-image {
                height: 200px;
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
                    <h1>ISP & Hotspot Insights</h1>
                    <p class="lead" style="color: rgba(255, 255, 255, 0.9);">
                        Expert insights on internet service provision, hotspot billing, and growing your ISP business in Africa.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Blog Articles -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Internet Infrastructure Africa" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">ISP Business</div>
                            <h2 class="blog-title">The Future of Internet Service Provision in Africa</h2>
                            <div class="blog-meta">
                                <span class="blog-date">December 15, 2024</span>
                                <span class="blog-read-time">5 min read</span>
                            </div>
                            <p class="blog-excerpt">
                                Discover how African ISPs are revolutionizing internet access with innovative billing solutions, mobile money integration, and community-focused approaches.
                            </p>
                            <a href="{$app_url}/blog/future-isp-africa" class="blog-link">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Kenya Internet Market" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Kenya Market</div>
                            <h2 class="blog-title">Kenya's Internet Market: Opportunities for ISPs in 2025</h2>
                            <div class="blog-meta">
                                <span class="blog-date">December 10, 2024</span>
                                <span class="blog-read-time">6 min read</span>
                            </div>
                            <p class="blog-excerpt">
                                Kenya leads Africa in internet penetration. Learn how ISPs can capitalize on growing demand for reliable, affordable connectivity in urban and rural areas.
                            </p>
                            <a href="{$app_url}/blog/kenya-internet-market-2025" class="blog-link">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1556075798-4825dfaaf498?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Hotspot Business Model" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Hotspot Business</div>
                            <h2 class="blog-title">Building a Profitable Hotspot Business: Complete Guide</h2>
                            <div class="blog-meta">
                                <span class="blog-date">December 5, 2024</span>
                                <span class="blog-read-time">8 min read</span>
                            </div>
                            <p class="blog-excerpt">
                                From location selection to billing software, learn everything you need to know to build and scale a successful WiFi hotspot business across Africa.
                            </p>
                            <a href="{$app_url}/blog/profitable-hotspot-business-guide" class="blog-link">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Mobile Money Internet" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Payment Systems</div>
                            <h2 class="blog-title">Mobile Money Revolution: Transforming Internet Payments</h2>
                            <div class="blog-meta">
                                <span class="blog-date">November 30, 2024</span>
                                <span class="blog-read-time">4 min read</span>
                            </div>
                            <p class="blog-excerpt">
                                How M-Pesa and other mobile money platforms are revolutionizing how Africans pay for internet services, making connectivity more accessible than ever.
                            </p>
                            <a href="{$app_url}/blog/mobile-money-internet-payments" class="blog-link">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1573164713712-03790a178651?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Rural Internet Access" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Rural Development</div>
                            <h2 class="blog-title">Bridging the Digital Divide: Rural Internet Solutions</h2>
                            <div class="blog-meta">
                                <span class="blog-date">November 25, 2024</span>
                                <span class="blog-read-time">7 min read</span>
                            </div>
                            <p class="blog-excerpt">
                                Innovative approaches to bringing affordable internet to rural African communities, including satellite, microwave, and community-owned networks.
                            </p>
                            <a href="{$app_url}/blog/rural-internet-solutions-africa" class="blog-link">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="ISP Technology Trends" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Technology</div>
                            <h2 class="blog-title">ISP Technology Trends: What's Next for African Internet</h2>
                            <div class="blog-meta">
                                <span class="blog-date">November 20, 2024</span>
                                <span class="blog-read-time">6 min read</span>
                            </div>
                            <p class="blog-excerpt">
                                Explore emerging technologies reshaping the ISP landscape in Africa, from 5G deployment to AI-powered network management and edge computing.
                            </p>
                            <a href="{$app_url}/blog/isp-technology-trends-africa" class="blog-link">
                                Read More <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </article>
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