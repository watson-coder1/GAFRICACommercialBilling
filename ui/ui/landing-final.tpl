<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Glinta Africa - Transform your WiFi into a revenue powerhouse. Professional hotspot billing solutions trusted by 10,000+ businesses across Africa.">
    <meta name="keywords" content="wifi monetization, hotspot billing, business wifi solutions, africa wifi management, restaurant wifi, hotel internet billing">
    <meta name="author" content="Glinta Africa">
    <meta property="og:title" content="Glinta Africa - WiFi Monetization Made Simple">
    <meta property="og:description" content="Turn your WiFi from a cost center into a profit driver. Professional billing solutions for modern businesses.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://glintaafrica.com">
    <meta name="twitter:card" content="summary_large_image">
    
    <link rel="canonical" href="https://glintaafrica.com">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    
    <!-- Professional Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Custom Styles -->
    <style>
        :root {
            --primary: #1e293b;
            --secondary: #0f172a;
            --accent: #f59e0b;
            --accent-light: #fbbf24;
            --accent-dark: #d97706;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --text-light: #94a3b8;
            --bg-primary: #ffffff;
            --bg-secondary: #f8fafc;
            --bg-accent: #fffbeb;
            --border: #e2e8f0;
            --shadow: rgba(30, 41, 59, 0.04);
            --shadow-lg: rgba(30, 41, 59, 0.08);
            --gradient-primary: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            --gradient-accent: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            --gradient-hero: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            overflow-x: hidden;
        }

        /* Custom Logo Typography */
        .logo-text {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
            letter-spacing: -0.02em;
            display: inline-block;
            position: relative;
            transition: all 0.3s ease;
        }

        .logo-text:hover {
            color: var(--accent);
            transform: translateY(-1px);
        }

        .logo-text::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--gradient-accent);
            transition: width 0.3s ease;
        }

        .logo-text:hover::after {
            width: 100%;
        }

        /* Advanced Typography */
        .display-1 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 4rem;
            font-weight: 800;
            line-height: 1.1;
            letter-spacing: -0.02em;
        }

        .display-2 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 3rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.01em;
        }

        /* Dynamic Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
            padding: 1rem 0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .navbar.scrolled {
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 4px 20px var(--shadow-lg);
            padding: 0.75rem 0;
        }

        .navbar-nav .nav-link {
            font-weight: 500;
            color: var(--text-primary);
            margin: 0 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            position: relative;
        }

        .navbar-nav .nav-link:hover {
            color: var(--accent);
            background: var(--bg-accent);
        }

        .navbar-nav .nav-link.active {
            color: var(--accent);
            background: var(--bg-accent);
        }

        /* Hero Section - Dynamic */
        .hero {
            background: var(--gradient-hero);
            min-height: 100vh;
            display: flex;
            align-items: center;
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
            background: url('https://images.unsplash.com/photo-1553484771-cc0d9b8c2b33?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80') center/cover;
            opacity: 0.05;
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: white;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            background: rgba(245, 158, 11, 0.1);
            border: 1px solid rgba(245, 158, 11, 0.3);
            color: var(--accent-light);
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            animation: fadeInUp 0.6s ease-out;
        }

        .hero h1 {
            color: white;
            margin-bottom: 1.5rem;
            animation: fadeInUp 0.6s ease-out 0.2s both;
        }

        .hero .lead {
            font-size: 1.25rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
            max-width: 600px;
            animation: fadeInUp 0.6s ease-out 0.4s both;
        }

        .hero-cta {
            animation: fadeInUp 0.6s ease-out 0.6s both;
        }

        .hero-stats {
            margin-top: 4rem;
            padding-top: 3rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            animation: fadeInUp 0.6s ease-out 0.8s both;
        }

        .hero-stat {
            text-align: center;
            padding: 1rem;
        }

        .hero-stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--accent-light);
            margin-bottom: 0.5rem;
            font-family: 'Space Grotesk', sans-serif;
        }

        .hero-stat-label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Floating Elements */
        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .floating-icon {
            position: absolute;
            color: rgba(245, 158, 11, 0.2);
            font-size: 1.5rem;
            animation: float 6s ease-in-out infinite;
        }

        .floating-icon:nth-child(1) { top: 20%; left: 10%; animation-delay: 0s; }
        .floating-icon:nth-child(2) { top: 30%; right: 15%; animation-delay: 1s; }
        .floating-icon:nth-child(3) { bottom: 30%; left: 20%; animation-delay: 2s; }
        .floating-icon:nth-child(4) { bottom: 20%; right: 25%; animation-delay: 3s; }
        .floating-icon:nth-child(5) { top: 60%; left: 5%; animation-delay: 4s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        /* Button Styles */
        .btn {
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--gradient-accent);
            color: white;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(245, 158, 11, 0.4);
            color: white;
        }

        .btn-outline-light {
            background: transparent;
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .btn-outline-light:hover {
            background: white;
            color: var(--primary);
            border-color: white;
        }

        /* Section Spacing */
        .section {
            padding: 5rem 0;
        }

        .section-sm {
            padding: 3rem 0;
        }

        /* Feature Cards */
        .feature-card {
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 2rem;
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-accent);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px var(--shadow-lg);
            border-color: var(--accent);
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-icon {
            width: 64px;
            height: 64px;
            background: var(--bg-accent);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            color: var(--accent);
            font-size: 1.5rem;
            transition: all 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            background: var(--accent);
            color: white;
            transform: scale(1.1);
        }

        /* Blog Section */
        .blog-card {
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
        }

        .blog-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px var(--shadow-lg);
        }

        .blog-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .blog-content {
            padding: 1.5rem;
        }

        .blog-meta {
            color: var(--text-light);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .blog-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.75rem;
            line-height: 1.4;
        }

        .blog-excerpt {
            color: var(--text-secondary);
            font-size: 0.875rem;
            line-height: 1.5;
            margin-bottom: 1rem;
        }

        .blog-link {
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            transition: all 0.3s ease;
        }

        .blog-link:hover {
            color: var(--accent-dark);
            gap: 0.5rem;
        }

        /* Testimonials */
        .testimonial-card {
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .testimonial-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px var(--shadow-lg);
        }

        .testimonial-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            object-fit: cover;
        }

        .testimonial-text {
            font-style: italic;
            color: var(--text-secondary);
            margin-bottom: 1rem;
            line-height: 1.6;
        }

        .testimonial-author {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .testimonial-company {
            color: var(--text-light);
            font-size: 0.875rem;
        }

        /* Pricing Cards */
        .pricing-card {
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .pricing-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px var(--shadow-lg);
        }

        .pricing-card.featured {
            border-color: var(--accent);
            transform: scale(1.05);
        }

        .pricing-card.featured::before {
            content: 'Most Popular';
            position: absolute;
            top: -12px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--gradient-accent);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .pricing-price {
            font-size: 3rem;
            font-weight: 800;
            color: var(--accent);
            margin-bottom: 0.5rem;
            font-family: 'Space Grotesk', sans-serif;
        }

        /* Footer */
        .footer {
            background: var(--primary);
            color: white;
            padding: 3rem 0 1rem;
        }

        .footer h5 {
            color: var(--accent-light);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: var(--accent-light);
        }

        .footer-bottom {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 1.5rem;
            margin-top: 2rem;
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Enhanced Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        .animate-on-scroll {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s ease;
        }

        .animate-on-scroll.animated {
            opacity: 1;
            transform: translateY(0);
        }

        .animate-slide-right {
            animation: slideInRight 0.8s ease-out;
        }

        .animate-slide-left {
            animation: slideInLeft 0.8s ease-out;
        }

        .animate-scale {
            animation: scaleIn 0.6s ease-out;
        }

        .animate-pulse {
            animation: pulse 2s infinite;
        }

        .animate-bounce {
            animation: bounce 2s infinite;
        }

        /* African-themed gradient overlays */
        .africa-gradient {
            background: linear-gradient(135deg, #FF6B35 0%, #F7931E 25%, #FFD700 50%, #00B04F 75%, #006400 100%);
            background-size: 400% 400%;
            animation: gradientShift 8s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Dynamic number counter */
        .counter-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--accent-light);
            margin-bottom: 0.5rem;
            font-family: 'Space Grotesk', sans-serif;
            transition: all 0.3s ease;
        }

        .counter-number:hover {
            transform: scale(1.1);
            color: var(--accent);
        }

        /* Parallax effect for hero background */
        .parallax-bg {
            background-attachment: fixed;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
        }

        /* Enhanced card hover effects */
        .dynamic-card {
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        .dynamic-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.5s;
        }

        .dynamic-card:hover::before {
            left: 100%;
        }

        .dynamic-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .logo-text {
                font-size: 1.5rem;
            }

            .display-1 {
                font-size: 2.5rem;
            }

            .display-2 {
                font-size: 2rem;
            }

            .hero {
                min-height: 80vh;
            }

            .hero-stats {
                margin-top: 2rem;
                padding-top: 2rem;
            }

            .section {
                padding: 3rem 0;
            }

            .pricing-card.featured {
                transform: none;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="logo-text" href="{$app_url}">
                <span style="color: var(--accent);">G</span>linta<span style="color: var(--accent);">A</span>frica
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#solutions">Solutions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#story">Our Story</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#blog">Insights</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#pricing">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="floating-elements">
            <i class="floating-icon fas fa-wifi"></i>
            <i class="floating-icon fas fa-chart-line"></i>
            <i class="floating-icon fas fa-mobile-alt"></i>
            <i class="floating-icon fas fa-shield-alt"></i>
            <i class="floating-icon fas fa-rocket"></i>
        </div>
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="hero-content">
                        <div class="hero-badge">
                            <i class="fas fa-heart me-2"></i>
                            Co-founded by Watson Wambugu & Dennis Mugo
                        </div>
                        <h1 class="display-1 mb-4">
                            Connecting Remote Africa<br>
                            <span style="color: var(--accent-light);">One Hotspot At A Time</span>
                        </h1>
                        <p class="lead">
                            Born from a mission to bridge the digital divide in Africa, we've helped over 10,000 businesses in remote areas transform their communities through affordable internet access.
                        </p>
                        <div class="hero-cta">
                            <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20turn%20my%20WiFi%20into%20a%20money-making%20machine" class="btn btn-primary btn-lg me-3" target="_blank">
                                <i class="fas fa-rocket me-2"></i>Start Making Money
                            </a>
                            <a href="#features" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-play me-2"></i>See How It Works
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="hero-stats">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="hero-stat">
                                    <div class="hero-stat-number" data-count="10000">0</div>
                                    <div class="hero-stat-label">Communities Connected</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="hero-stat">
                                    <div class="hero-stat-number" data-count="500000">0</div>
                                    <div class="hero-stat-label">Lives Impacted</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="hero-stat">
                                    <div class="hero-stat-number" data-count="15">0</div>
                                    <div class="hero-stat-label">African Countries</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="section" style="background: var(--bg-secondary);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-2 mb-4">Our Mission: Internet For All Africans</h2>
                    <p class="lead">Founded by Watson Wambugu and Dennis Mugo, we believe every African deserves access to affordable, reliable internet - especially in remote areas where connectivity can transform entire communities.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <h4>Community-First Approach</h4>
                        <p>We prioritize remote communities first. Our systems are designed to work in low-infrastructure areas, bringing internet access where it's needed most.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h4>Mobile Money Integration</h4>
                        <p>M-Pesa, Airtel Money, and local payment methods. Perfect for African communities where mobile money is the primary payment method.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h4>Impact Analytics</h4>
                        <p>Track not just revenue, but community impact. See how many students accessed education, farmers got market prices, and families stayed connected.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4>African-Built Security</h4>
                        <p>Security designed for African networks. We understand local challenges and have built solutions that work reliably in diverse environments.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h4>Local Support Team</h4>
                        <p>24/7 support from African tech experts who understand local challenges, languages, and cultural contexts.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-paint-brush"></i>
                        </div>
                        <h4>Community Branding</h4>
                        <p>Customize portals with local languages, currencies, and cultural elements. Make technology feel familiar and accessible.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Solutions Section -->
    <section id="solutions" class="section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-2 mb-4">Transforming African Communities</h2>
                    <p class="lead">From rural schools to urban centers, we've helped diverse African communities build sustainable internet businesses.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="African School" class="img-fluid rounded mb-3" style="width: 100%; height: 200px; object-fit: cover;">
                        <h4>Rural Schools & Education</h4>
                        <p>Connecting 2,500+ schools across Africa. Students now access online learning, teachers get training resources, and communities stay informed.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="African Healthcare" class="img-fluid rounded mb-3" style="width: 100%; height: 200px; object-fit: cover;">
                        <h4>Healthcare Centers</h4>
                        <p>Enabled telemedicine in 800+ rural clinics. Doctors now consult specialists remotely, patients access health information, and communities get better care.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1586348943529-beaae6c28db9?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="African Market" class="img-fluid rounded mb-3" style="width: 100%; height: 200px; object-fit: cover;">
                        <h4>Local Markets & SMEs</h4>
                        <p>Supporting 5,000+ small businesses. Farmers check market prices, traders process mobile payments, and entrepreneurs build online presence.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Our Story Section -->
    <section id="story" class="section" style="background: var(--gradient-primary); color: white;">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-2 mb-4" style="color: white;">Our Story: Bridging The Digital Divide</h2>
                    <p class="lead" style="color: rgba(255, 255, 255, 0.9);">Founded by two passionate African technologists with a simple mission: ensure every African has access to affordable, reliable internet.</p>
                </div>
            </div>
            
            <!-- Founders Section -->
            <div class="row align-items-center mb-5">
                <div class="col-lg-6">
                    <div class="row">
                        <div class="col-md-6 text-center mb-4 animate-slide-left">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" alt="Watson Wambugu" class="img-fluid rounded-circle mb-3 animate-pulse" style="width: 150px; height: 150px; object-fit: cover; border: 4px solid var(--accent);">
                            <h4 style="color: var(--accent-light);">Watson Wambugu</h4>
                            <p style="color: rgba(255, 255, 255, 0.8);">Co-Founder & CEO</p>
                            <p style="color: rgba(255, 255, 255, 0.7); font-size: 0.9rem;">Network engineer from rural Kenya who experienced firsthand the challenges of internet access in remote areas.</p>
                        </div>
                        <div class="col-md-6 text-center mb-4 animate-slide-right">
                            <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" alt="Dennis Mugo" class="img-fluid rounded-circle mb-3 animate-pulse" style="width: 150px; height: 150px; object-fit: cover; border: 4px solid var(--accent);">
                            <h4 style="color: var(--accent-light);">Dennis Mugo</h4>
                            <p style="color: rgba(255, 255, 255, 0.8);">Co-Founder & CTO</p>
                            <p style="color: rgba(255, 255, 255, 0.7); font-size: 0.9rem;">Software developer passionate about using technology to solve African problems with African solutions.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="ps-lg-4">
                        <h3 style="color: var(--accent-light); margin-bottom: 1.5rem;">From Personal Experience to Global Impact</h3>
                        <p style="color: rgba(255, 255, 255, 0.9); margin-bottom: 1.5rem;">
                            Growing up in Kenya's rural areas, Watson and Dennis witnessed how lack of internet access limited opportunities for education, healthcare, and economic growth. They saw talented students unable to access online resources, small businesses struggling without digital tools, and communities isolated from global opportunities.
                        </p>
                        <p style="color: rgba(255, 255, 255, 0.9); margin-bottom: 1.5rem;">
                            In 2020, they founded GlintaAfrica with a clear vision: make internet access affordable and sustainable for every African community, starting with the most remote areas.
                        </p>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="text-center">
                                    <div style="font-size: 2rem; color: var(--accent-light); font-weight: 800; margin-bottom: 0.5rem;">2020</div>
                                    <div style="color: rgba(255, 255, 255, 0.8); font-size: 0.9rem;">Company Founded</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="text-center">
                                    <div style="font-size: 2rem; color: var(--accent-light); font-weight: 800; margin-bottom: 0.5rem;">₦0</div>
                                    <div style="color: rgba(255, 255, 255, 0.8); font-size: 0.9rem;">Initial Investment</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Impact Stories -->
            <div class="row mt-5">
                <div class="col-lg-12 text-center mb-4">
                    <h3 style="color: var(--accent-light);">Real Stories, Real Impact</h3>
                    <p style="color: rgba(255, 255, 255, 0.8);">These are the communities we've helped transform</p>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card dynamic-card animate-on-scroll" style="background: rgba(255, 255, 255, 0.1); border-color: rgba(255, 255, 255, 0.2);">
                        <img src="https://images.unsplash.com/photo-1497486751825-1233686d5d80?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Kibera School" class="img-fluid rounded mb-3" style="width: 100%; height: 200px; object-fit: cover;">
                        <h4 style="color: var(--accent-light);">Kibera Secondary School, Kenya</h4>
                        <p style="color: rgba(255, 255, 255, 0.8);">
                            <strong>Challenge:</strong> 1,200 students with no internet access.<br>
                            <strong>Solution:</strong> Affordable hotspot system with educational packages.<br>
                            <strong>Impact:</strong> 95% improvement in digital literacy scores.
                        </p>
                        <div class="row text-center mt-3">
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">1,200</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Students</div>
                            </div>
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">₦50</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Monthly Cost</div>
                            </div>
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">95%</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Improvement</div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card dynamic-card animate-on-scroll" style="background: rgba(255, 255, 255, 0.1); border-color: rgba(255, 255, 255, 0.2);">
                        <img src="https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Rural Clinic" class="img-fluid rounded mb-3" style="width: 100%; height: 200px; object-fit: cover;">
                        <h4 style="color: var(--accent-light);">Maseno Rural Clinic, Uganda</h4>
                        <p style="color: rgba(255, 255, 255, 0.8);">
                            <strong>Challenge:</strong> No telemedicine capability for 50,000 residents.<br>
                            <strong>Solution:</strong> Reliable internet for doctor consultations.<br>
                            <strong>Impact:</strong> 300% increase in successful treatments.
                        </p>
                        <div class="row text-center mt-3">
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">50K</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Residents</div>
                            </div>
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">24/7</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Availability</div>
                            </div>
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">300%</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Better Care</div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card dynamic-card animate-on-scroll" style="background: rgba(255, 255, 255, 0.1); border-color: rgba(255, 255, 255, 0.2);">
                        <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Farmer Market" class="img-fluid rounded mb-3" style="width: 100%; height: 200px; object-fit: cover;">
                        <h4 style="color: var(--accent-light);">Mbeere Farmers Market, Kenya</h4>
                        <p style="color: rgba(255, 255, 255, 0.8);">
                            <strong>Challenge:</strong> Farmers selling below market prices.<br>
                            <strong>Solution:</strong> Internet access for price checking and mobile payments.<br>
                            <strong>Impact:</strong> 150% increase in farmer income.
                        </p>
                        <div class="row text-center mt-3">
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">500</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Farmers</div>
                            </div>
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">₦200</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Monthly Plan</div>
                            </div>
                            <div class="col-4">
                                <div style="font-size: 1.5rem; color: var(--accent-light); font-weight: 700;">150%</div>
                                <div style="color: rgba(255, 255, 255, 0.7); font-size: 0.8rem;">Income Rise</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Call to Action -->
            <div class="row mt-5">
                <div class="col-lg-8 mx-auto text-center">
                    <h3 style="color: var(--accent-light); margin-bottom: 1.5rem;">Join Our Mission</h3>
                    <p style="color: rgba(255, 255, 255, 0.9); margin-bottom: 2rem;">
                        Every community deserves access to the digital world. Let's build the next success story together.
                    </p>
                    <a href="https://wa.me/254711503023?text=Hi%20Watson%20and%20Dennis,%20I%20want%20to%20join%20your%20mission%20to%20connect%20Africa" class="btn btn-primary btn-lg" target="_blank">
                        <i class="fas fa-hands-helping me-2"></i>Partner With Us
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Blog Section -->
    <section id="blog" class="section" style="background: var(--bg-secondary);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-2 mb-4">African Tech Insights</h2>
                    <p class="lead">Discover how technology is transforming African communities and creating unprecedented opportunities for growth.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4">
                    <article class="blog-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Digital Transformation Africa" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-meta">
                                <time datetime="2024-01-15">January 15, 2024</time> • Digital Transformation
                            </div>
                            <h3 class="blog-title">How Remote African Villages Are Leapfrogging to Digital Economy</h3>
                            <p class="blog-excerpt">
                                Explore how Watson and Dennis are helping remote communities skip traditional infrastructure and jump directly to modern digital solutions.
                            </p>
                            <a href="https://wa.me/254711503023?text=Hi%20Watson%20and%20Dennis,%20I%20want%20to%20learn%20about%20digital%20transformation%20in%20Africa" class="blog-link" target="_blank">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>
                <div class="col-lg-4">
                    <article class="blog-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1573164713712-03790a178651?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="African Innovation" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-meta">
                                <time datetime="2024-01-10">January 10, 2024</time> • Innovation
                            </div>
                            <h3 class="blog-title">Mobile Money + Internet: The Perfect African Tech Combination</h3>
                            <p class="blog-excerpt">
                                Discover how the combination of mobile money and internet access is creating new economic opportunities across Africa.
                            </p>
                            <a href="https://wa.me/254711503023?text=Hi%20Watson%20and%20Dennis,%20I%20want%20to%20learn%20about%20mobile%20money%20integration" class="blog-link" target="_blank">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>
                <div class="col-lg-4">
                    <article class="blog-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1590736969955-71cc94901144?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="African Entrepreneurship" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-meta">
                                <time datetime="2024-01-05">January 5, 2024</time> • Entrepreneurship
                            </div>
                            <h3 class="blog-title">From Zero to Hero: Building Tech Startups in Rural Africa</h3>
                            <p class="blog-excerpt">
                                Learn how Watson and Dennis built GlintaAfrica from nothing and how you can create similar impact in your community.
                            </p>
                            <a href="https://wa.me/254711503023?text=Hi%20Watson%20and%20Dennis,%20I%20want%20to%20learn%20about%20building%20tech%20startups%20in%20Africa" class="blog-link" target="_blank">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-2 mb-4">What Our Customers Say</h2>
                    <p class="lead">Don't just take our word for it. Here's what real business owners have to say about turning their WiFi into a revenue stream.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="testimonial-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1494790108755-2616c79e696b?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80" alt="Sarah Mwangi" class="testimonial-avatar">
                        <p class="testimonial-text">
                            "I never thought WiFi could make me money until I found Glinta Africa. Now my coffee shop's WiFi pays for itself and then some. Best investment I've made in years!"
                        </p>
                        <div class="testimonial-author">Sarah Mwangi</div>
                        <div class="testimonial-company">Java House, Nairobi</div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="testimonial-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80" alt="James Ochieng" class="testimonial-avatar">
                        <p class="testimonial-text">
                            "Our hotel guests actually compliment us on our WiFi speed now. And the extra revenue? It's covering our internet costs and more. Genius system!"
                        </p>
                        <div class="testimonial-author">James Ochieng</div>
                        <div class="testimonial-company">Lake View Hotel, Kisumu</div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="testimonial-card animate-on-scroll">
                        <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80" alt="Amina Hassan" class="testimonial-avatar">
                        <p class="testimonial-text">
                            "The setup was ridiculously easy and the support team is amazing. My restaurant's WiFi went from expense to profit center in one day. Literally."
                        </p>
                        <div class="testimonial-author">Amina Hassan</div>
                        <div class="testimonial-company">Swahili Delights, Mombasa</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="section" style="background: var(--bg-secondary);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-2 mb-4">Pricing That Actually Makes Sense</h2>
                    <p class="lead">No hidden fees, no surprises, no "enterprise" pricing for basic features. Just honest pricing that scales with your success.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card animate-on-scroll">
                        <h3>Starter</h3>
                        <div class="pricing-price">KSh 1,000</div>
                        <p class="text-muted">per month</p>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Up to 50 users</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>1 location</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Basic analytics</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>M-Pesa integration</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Email support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20start%20with%20the%20Starter%20plan" class="btn btn-primary w-100 mt-3" target="_blank">
                            Get Started
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card animate-on-scroll">
                        <h3>Business</h3>
                        <div class="pricing-price">KSh 2,500</div>
                        <p class="text-muted">per month</p>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Up to 150 users</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>3 locations</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Advanced analytics</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>All payment methods</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Priority support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20start%20with%20the%20Business%20plan" class="btn btn-primary w-100 mt-3" target="_blank">
                            Get Started
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card featured animate-on-scroll">
                        <h3>Professional</h3>
                        <div class="pricing-price">KSh 5,000</div>
                        <p class="text-muted">per month</p>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Up to 500 users</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>10 locations</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Full analytics suite</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Custom branding</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Phone support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20start%20with%20the%20Professional%20plan" class="btn btn-primary w-100 mt-3" target="_blank">
                            Get Started
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="pricing-card animate-on-scroll">
                        <h3>Enterprise</h3>
                        <div class="pricing-price">KSh 10,000</div>
                        <p class="text-muted">per month</p>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Unlimited users</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Unlimited locations</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Custom features</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>API access</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Dedicated support</li>
                        </ul>
                        <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20discuss%20the%20Enterprise%20plan" class="btn btn-primary w-100 mt-3" target="_blank">
                            Contact Sales
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Demo Section -->
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="display-2 mb-4">Ready to See It in Action?</h2>
                    <p class="lead mb-4">
                        Take our platform for a test drive. No credit card required, no pushy sales calls, just pure WiFi monetization magic.
                    </p>
                    <div class="d-flex justify-content-center gap-3 flex-wrap">
                        <a href="{$app_url}/index.php?_route=admin" class="btn btn-primary btn-lg" target="_blank">
                            <i class="fas fa-cog me-2"></i>Try Admin Demo
                        </a>
                        <a href="{$app_url}/index.php?_route=login" class="btn btn-outline-primary btn-lg" target="_blank">
                            <i class="fas fa-user me-2"></i>Try Customer Demo
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="section" style="background: var(--gradient-primary); color: white;">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-5">
                    <h2 class="display-2 mb-4" style="color: white;">Let's Turn Your WiFi Into Money</h2>
                    <p class="lead">Ready to stop giving away your most valuable asset for free? Let's chat about how we can make your WiFi profitable.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="text-center">
                        <div class="mb-3">
                            <i class="fas fa-envelope" style="font-size: 2rem; color: var(--accent-light);"></i>
                        </div>
                        <h5 style="color: var(--accent-light);">Email Us</h5>
                        <p>
                            <a href="mailto:info@glintaafrica.com" style="color: rgba(255, 255, 255, 0.9);">info@glintaafrica.com</a><br>
                            <a href="mailto:watsonwambugu@yahoo.com" style="color: rgba(255, 255, 255, 0.9);">watsonwambugu@yahoo.com</a>
                        </p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="text-center">
                        <div class="mb-3">
                            <i class="fas fa-phone" style="font-size: 2rem; color: var(--accent-light);"></i>
                        </div>
                        <h5 style="color: var(--accent-light);">Call Us</h5>
                        <p>
                            +254 700 123 456<br>
                            <small style="color: rgba(255, 255, 255, 0.7);">Monday - Friday: 8AM - 6PM</small>
                        </p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="text-center">
                        <div class="mb-3">
                            <i class="fab fa-whatsapp" style="font-size: 2rem; color: var(--accent-light);"></i>
                        </div>
                        <h5 style="color: var(--accent-light);">WhatsApp</h5>
                        <p>
                            <a href="https://wa.me/254711503023" target="_blank" style="color: rgba(255, 255, 255, 0.9);">+254 711 503 023</a><br>
                            <small style="color: rgba(255, 255, 255, 0.7);">Instant response 24/7</small>
                        </p>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-lg-6 mx-auto text-center">
                    <a href="https://wa.me/254711503023?text=Hi%20Glinta%20Africa,%20I%20want%20to%20turn%20my%20WiFi%20into%20a%20revenue%20stream" class="btn btn-primary btn-lg" target="_blank">
                        <i class="fas fa-comments me-2"></i>Start the Conversation
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="logo-text mb-3" style="font-size: 1.5rem; color: var(--accent-light);">
                        <span style="color: var(--accent);">G</span>linta<span style="color: var(--accent);">A</span>frica
                    </div>
                    <p class="text-light">
                        Transforming WiFi networks across Africa into profitable business assets. Join thousands of smart business owners who've stopped giving away their most valuable resource for free.
                    </p>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Product</h5>
                    <ul class="list-unstyled">
                        <li><a href="#features">Features</a></li>
                        <li><a href="#pricing">Pricing</a></li>
                        <li><a href="#solutions">Solutions</a></li>
                        <li><a href="/integrations">Integrations</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Resources</h5>
                    <ul class="list-unstyled">
                        <li><a href="/blog">Blog</a></li>
                        <li><a href="/case-studies">Case Studies</a></li>
                        <li><a href="/help">Help Center</a></li>
                        <li><a href="/api-docs">API Docs</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Company</h5>
                    <ul class="list-unstyled">
                        <li><a href="/about">About</a></li>
                        <li><a href="/careers">Careers</a></li>
                        <li><a href="/press">Press</a></li>
                        <li><a href="/partners">Partners</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5>Legal</h5>
                    <ul class="list-unstyled">
                        <li><a href="/privacy">Privacy Policy</a></li>
                        <li><a href="/terms">Terms of Service</a></li>
                        <li><a href="/security">Security</a></li>
                        <li><a href="/compliance">Compliance</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Glinta Africa. All rights reserved. | Made with ❤️ by <a href="https://watsonsdevelopers.com" style="color: var(--accent);">watsonsdevelopers.com</a></p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    const offsetTop = target.offsetTop - 80;
                    window.scrollTo({
                        top: offsetTop,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Active navigation
        window.addEventListener('scroll', function() {
            const sections = document.querySelectorAll('section[id]');
            const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
            
            let current = '';
            sections.forEach(section => {
                const sectionTop = section.offsetTop - 100;
                if (window.scrollY >= sectionTop) {
                    current = section.getAttribute('id');
                }
            });

            navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === '#' + current) {
                    link.classList.add('active');
                }
            });
        });

        // Counter animation
        function animateCounters() {
            const counters = document.querySelectorAll('[data-count]');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const counter = entry.target;
                        const target = parseInt(counter.getAttribute('data-count'));
                        const duration = 2000;
                        const increment = target / (duration / 16);
                        let current = 0;

                        const timer = setInterval(() => {
                            current += increment;
                            if (current >= target) {
                                current = target;
                                clearInterval(timer);
                            }
                            counter.textContent = Math.floor(current).toLocaleString();
                        }, 16);

                        observer.unobserve(counter);
                    }
                });
            }, { threshold: 0.5 });

            counters.forEach(counter => observer.observe(counter));
        }

        // Scroll animations
        function initScrollAnimations() {
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animated');
                    }
                });
            }, {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            });

            document.querySelectorAll('.animate-on-scroll').forEach(el => {
                observer.observe(el);
            });
        }

        // Initialize everything
        document.addEventListener('DOMContentLoaded', function() {
            animateCounters();
            initScrollAnimations();
        });

        // Mobile menu close on link click
        document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
            link.addEventListener('click', () => {
                const navbarCollapse = document.querySelector('.navbar-collapse');
                if (navbarCollapse.classList.contains('show')) {
                    const bsCollapse = new bootstrap.Collapse(navbarCollapse);
                    bsCollapse.hide();
                }
            });
        });
    </script>
</body>
</html>