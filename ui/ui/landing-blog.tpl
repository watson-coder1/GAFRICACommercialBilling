<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Professional insights on ISP management, network operations, and telecommunications technology. Expert analysis of African internet infrastructure and business strategies.">
    <meta name="keywords" content="ISP blog, network management, telecommunications, African internet, professional ISP solutions, enterprise network operations">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/blog">
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
            --gold: #D4AF37;
            --gold-light: #F4E4C1;
            --gold-dark: #B8941F;
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
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 8rem 0 4rem;
            position: relative;
            overflow: hidden;
        }
        
        /* Animations */
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        @keyframes glow {
            from { text-shadow: 0 0 10px var(--gold), 0 0 20px var(--gold), 0 0 30px var(--gold); }
            to { text-shadow: 0 0 20px var(--gold), 0 0 30px var(--gold), 0 0 40px var(--gold); }
        }
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.8; }
            100% { opacity: 1; }
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

        /* Category Filter */
        .category-filter {
            background: var(--gray-50);
            padding: 2rem 0;
        }

        .category-btn {
            background: white;
            color: var(--gray-600);
            border: 1px solid var(--gray-200);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            margin: 0.25rem;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }

        .category-btn:hover,
        .category-btn.active {
            background: var(--gradient-primary);
            color: white;
            border-color: var(--primary);
        }

        /* Blog Cards */
        .blog-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            height: 100%;
        }

        .blog-card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-4px);
        }

        .blog-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .blog-card:hover .blog-image {
            transform: scale(1.05);
        }

        .blog-content {
            padding: 1.5rem;
        }

        .blog-category {
            background: var(--gradient-accent);
            color: var(--primary);
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1rem;
            display: inline-block;
        }

        .blog-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.75rem;
            line-height: 1.3;
        }

        .blog-excerpt {
            color: var(--gray-600);
            font-size: 0.875rem;
            margin-bottom: 1rem;
            line-height: 1.5;
        }

        .blog-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 0.75rem;
            color: var(--gray-500);
        }

        .blog-date {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .blog-read-time {
            color: var(--accent);
            font-weight: 500;
        }

        .blog-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }

        .blog-link:hover {
            color: var(--primary-light);
            transform: translateX(2px);
        }

        /* Featured Post */
        .featured-post {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            margin-bottom: 3rem;
        }

        .featured-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .featured-content {
            padding: 2rem;
        }

        .featured-badge {
            background: var(--gradient-primary);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1rem;
            display: inline-block;
        }

        .featured-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 1rem;
        }

        .featured-excerpt {
            font-size: 1rem;
            color: var(--gray-600);
            margin-bottom: 1.5rem;
        }

        /* Newsletter Section */
        .newsletter-section {
            background: var(--primary);
            color: white;
            padding: 4rem 0;
        }

        .newsletter-form {
            max-width: 400px;
            margin: 0 auto;
        }

        .newsletter-input {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.75rem 1rem;
            border-radius: 6px;
            font-size: 0.875rem;
        }

        .newsletter-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .newsletter-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 2px rgba(212, 175, 55, 0.2);
        }

        /* Pagination */
        .pagination {
            justify-content: center;
            margin-top: 3rem;
        }

        .page-link {
            color: var(--primary);
            border: 1px solid var(--gray-200);
            padding: 0.5rem 1rem;
            margin: 0 0.25rem;
            border-radius: 6px;
            font-size: 0.875rem;
            transition: all 0.2s ease;
        }

        .page-link:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .page-item.active .page-link {
            background: var(--primary);
            border-color: var(--primary);
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
            
            .blog-image {
                height: 180px;
            }
            
            .featured-image {
                height: 200px;
            }
            
            .featured-title {
                font-size: 1.5rem;
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
    <section class="hero" style="position: relative; overflow: hidden;">
        <!-- Animated Floating Elements -->
        <div class="position-absolute" style="top: 10%; left: 5%; width: 150px; height: 150px; background: radial-gradient(circle, rgba(212,175,55,0.15) 0%, transparent 70%); border-radius: 50%; animation: float 8s ease-in-out infinite;"></div>
        <div class="position-absolute" style="top: 70%; right: 10%; width: 200px; height: 200px; background: radial-gradient(circle, rgba(44,82,130,0.1) 0%, transparent 70%); border-radius: 50%; animation: float 10s ease-in-out infinite reverse;"></div>
        
        <div class="container hero-content">
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <h1 class="display-2">📝 The ISP <span style="color: var(--gold); animation: glow 2s ease-in-out infinite alternate;">Chronicles</span></h1>
                    <p class="lead">Where tech meets humor and ISPs learn to smile 😄<br>
Real stories, real solutions, and occasionally real funny mistakes we've all made! 🤦‍♂️</p>
                    
                    <!-- Blog Stats -->
                    <div class="row g-3 mb-4">
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.15); border: 2px solid rgba(212,175,55,0.3); transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='scale(1.1) rotate(5deg)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'">
                                <div class="h4 mb-1" style="color: var(--gold);">📚</div>
                                <small class="text-white">50+ Articles</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.15); border: 2px solid rgba(212,175,55,0.3); transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='scale(1.1) rotate(-5deg)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'">
                                <div class="h4 mb-1" style="color: var(--gold);">☕</div>
                                <small class="text-white">5 Min Reads</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="text-center p-3 rounded" style="background: rgba(212,175,55,0.15); border: 2px solid rgba(212,175,55,0.3); transition: all 0.3s ease; cursor: pointer;" onmouseover="this.style.transform='scale(1.1) rotate(5deg)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'">
                                <div class="h4 mb-1" style="color: var(--gold);">🎯</div>
                                <small class="text-white">100% Helpful</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="#latest-posts" class="btn btn-accent btn-lg px-4 py-3" style="animation: pulse 2s infinite;" onmouseover="this.style.transform='scale(1.05) rotate(1deg)'; this.style.boxShadow='0 10px 30px rgba(212,175,55,0.4)'" onmouseout="this.style.transform='scale(1) rotate(0deg)'; this.style.boxShadow='none'">
                            <i class="fas fa-book-reader me-2"></i>📖 Start Reading
                        </a>
                        <a href="#newsletter" class="btn btn-outline-primary btn-lg px-4 py-3" style="transition: all 0.3s ease;" onmouseover="this.style.background='rgba(255,255,255,0.1)'; this.innerHTML='<i class=\"fas fa-bell me-2\"></i>🔔 Get Updates!'" onmouseout="this.style.background='transparent'; this.innerHTML='<i class=\"fas fa-rss me-2\"></i>📧 Subscribe'">
                            <i class="fas fa-rss me-2"></i>📧 Subscribe
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <!-- Blog Visual -->
                    <div class="position-relative">
                        <img src="https://images.unsplash.com/photo-1432821596592-e2c18b78144f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&h=400&q=80" 
                             alt="Blog Reading" class="img-fluid rounded shadow-lg" style="transform: perspective(1000px) rotateY(-5deg); transition: all 0.3s ease;" onmouseover="this.style.transform='perspective(1000px) rotateY(0deg) scale(1.02)'" onmouseout="this.style.transform='perspective(1000px) rotateY(-5deg) scale(1)'">
                        
                        <!-- Animated Blog Topics -->
                        <div class="position-absolute top-0 start-0 m-3 bg-success text-white rounded p-2 shadow" style="animation: bounce 3s infinite;">
                            <small>🔥 Hot Topics</small>
                        </div>
                        <div class="position-absolute bottom-0 end-0 m-3 bg-warning text-dark rounded p-2 shadow" style="animation: bounce 4s infinite reverse;">
                            <small>💡 ISP Tips</small>
                        </div>
                        
                        <!-- Floating Icons -->
                        <div class="position-absolute" style="top: 20%; right: -30px; animation: float 3s ease-in-out infinite; font-size: 2rem;">📝</div>
                        <div class="position-absolute" style="bottom: 30%; left: -30px; animation: float 4s ease-in-out infinite reverse; font-size: 2rem;">💭</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Category Filter -->
    <section class="category-filter">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <div class="mb-3">
                        <h6 class="text-gray-600 mb-3">Filter by Category</h6>
                        <a href="#" class="category-btn active">All Posts</a>
                        <a href="#" class="category-btn">Network Operations</a>
                        <a href="#" class="category-btn">Enterprise Solutions</a>
                        <a href="#" class="category-btn">Security</a>
                        <a href="#" class="category-btn">Technology Trends</a>
                        <a href="#" class="category-btn">Industry Analysis</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Post -->
    <section class="py-5">
        <div class="container">
            <div class="featured-post" data-aos="fade-up">
                <div class="row g-0">
                    <div class="col-md-6">
                        <img src="https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="African ISP Infrastructure" class="featured-image">
                    </div>
                    <div class="col-md-6">
                        <div class="featured-content">
                            <div class="featured-badge">Featured Article</div>
                            <h2 class="featured-title">🚀 How We Built Africa's Most Fun ISP Platform (Yes, Really!)</h2>
                            <p class="featured-excerpt">
                                The hilarious journey from "Why is this so hard?" to "Why didn't we do this sooner?" Learn how we turned ISP nightmares into sweet dreams with M-Pesa magic, RADIUS that doesn't make you cry, and billing that actually works!
                            </p>
                            <div class="blog-meta mb-3">
                                <div class="blog-date">
                                    <i class="fas fa-calendar text-gray-400"></i>
                                    <span>January 15, 2025</span>
                                </div>
                                <div class="blog-read-time">12 min read</div>
                            </div>
                            <a href="#" class="blog-link">
                                Read Full Article <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Blog Posts -->
    <section class="pb-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Network Security" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Security</div>
                            <h3 class="blog-title">🔐 RADIUS Security: How to Keep the Bad Guys Out (And Your Sanity In)</h3>
                            <p class="blog-excerpt">
                                Ever wondered why hackers hate us? It's because our RADIUS setup is tighter than your budget after the holidays! Learn the secrets...
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Jan 10, 2025</span>
                                </div>
                                <div class="blog-read-time">8 min read</div>
                            </div>
                            <a href="#" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1563986768494-4dee2763ff3f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Network Management" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Network Operations</div>
                            <h3 class="blog-title">🔍 SNMP Monitoring: Watching Your Network Like a Hawk (But Friendlier)</h3>
                            <p class="blog-excerpt">
                                Stop playing network detective at 3 AM! Our SNMP tricks will have your network telling you its problems before they happen. Magic? Almost!
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Jan 5, 2025</span>
                                </div>
                                <div class="blog-read-time">10 min read</div>
                            </div>
                            <a href="#" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Payment Integration" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Technology Trends</div>
                            <h3 class="blog-title">💰 M-Pesa Integration: From "Nimesend" to "Service On" in 3 Seconds!</h3>
                            <p class="blog-excerpt">
                                The secret sauce to making mobile money work like magic. Spoiler: It involves less code and more understanding how Kenyans actually pay!
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 28, 2024</span>
                                </div>
                                <div class="blog-read-time">15 min read</div>
                            </div>
                            <a href="#" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Network Analytics" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Enterprise Solutions</div>
                            <h3 class="blog-title">Network Analytics: InfluxDB and Grafana for ISP Monitoring</h3>
                            <p class="blog-excerpt">
                                Building enterprise-grade network monitoring dashboards with InfluxDB time-series data and Grafana visualization.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 20, 2024</span>
                                </div>
                                <div class="blog-read-time">12 min read</div>
                            </div>
                            <a href="#" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1573164713712-03790a178651?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Network Automation" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Network Operations</div>
                            <h3 class="blog-title">Network Automation: Mikrotik RouterOS API Programming</h3>
                            <p class="blog-excerpt">
                                Advanced automation techniques for Mikrotik RouterOS using API programming for bulk user management and configuration.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 15, 2024</span>
                                </div>
                                <div class="blog-read-time">9 min read</div>
                            </div>
                            <a href="#" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <article class="blog-card">
                        <img src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Industry Analysis" class="blog-image">
                        <div class="blog-content">
                            <div class="blog-category">Industry Analysis</div>
                            <h3 class="blog-title">African Telecommunications Market: 2025 Industry Report</h3>
                            <p class="blog-excerpt">
                                Comprehensive analysis of African telecommunications markets, regulatory environments, and growth opportunities for professional ISPs.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-date">
                                    <i class="fas fa-calendar"></i>
                                    <span>Dec 10, 2024</span>
                                </div>
                                <div class="blog-read-time">20 min read</div>
                            </div>
                            <a href="#" class="blog-link">
                                Read More <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </article>
                </div>
            </div>

            <!-- Pagination -->
            <nav aria-label="Blog pagination">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>
                    <li class="page-item active">
                        <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="newsletter-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">Stay Updated on ISP Technology</h2>
                    <p class="text-lg mb-4" style="color: rgba(255,255,255,0.9);">Get the latest insights on network operations, security, and telecommunications technology delivered to your inbox.</p>
                    <div class="newsletter-form">
                        <div class="input-group">
                            <input type="email" class="form-control newsletter-input" placeholder="Enter your email address" required>
                            <button class="btn btn-accent" type="submit">
                                <i class="fas fa-paper-plane me-2"></i>Subscribe
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <p class="text-sm" style="color: rgba(255,255,255,0.7);">
                            For technical inquiries: 
                            <a href="mailto:watsonwambugu@yahoo.com" style="color: var(--accent);">watsonwambugu@yahoo.com</a> | 
                            <a href="https://wa.me/254711503023" target="_blank" style="color: var(--accent);">WhatsApp: +254 711 503 023</a>
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
                <div class="col-lg-4">
                    <h6>Glinta Africa</h6>
                    <p class="text-sm text-gray-400 mb-3">Professional ISP solutions and technical insights for African telecommunications. Expert analysis of network operations and enterprise technology.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-gray-400"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-gray-400"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h6>Categories</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="#">Network Operations</a>
                        <a href="#">Enterprise Solutions</a>
                        <a href="#">Security</a>
                        <a href="#">Technology Trends</a>
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
                        <a href="{$app_url}/about">About</a>
                        <a href="#">API Reference</a>
                    </div>
                </div>
                <div class="col-lg-2">
                    <h6>Contact</h6>
                    <div class="d-flex flex-column gap-2">
                        <a href="mailto:watsonwambugu@yahoo.com">Technical Team</a>
                        <a href="https://wa.me/254711503023" target="_blank">WhatsApp</a>
                        <a href="{$app_url}/contact">Contact Form</a>
                    </div>
                </div>
            </div>
            <hr class="my-4" style="border-color: var(--gray-700);">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="text-sm text-gray-500 mb-0">&copy; 2025 Glinta Africa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-sm text-gray-500 mb-0">Professional insights for African telecommunications</p>
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

        // Category filter functionality
        document.querySelectorAll('.category-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Remove active class from all buttons
                document.querySelectorAll('.category-btn').forEach(b => b.classList.remove('active'));
                
                // Add active class to clicked button
                this.classList.add('active');
                
                // Here you could add filtering logic for blog posts
                console.log('Filter by:', this.textContent);
            });
        });

        // Newsletter form submission
        document.querySelector('.newsletter-form').addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input[type="email"]').value;
            if (email) {
                // Here you would handle the newsletter subscription
                alert('Thank you for subscribing to our technical insights!');
                this.reset();
            }
        });
    </script>
</body>
</html>