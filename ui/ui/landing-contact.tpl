<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$_title}</title>
    <meta name="description" content="Contact Glinta Africa for ISP billing solutions. Get in touch for demos, support, or partnership opportunities.">
    <meta name="keywords" content="contact ISP billing, Glinta Africa support, ISP software demo, mobile money integration contact">
    <meta name="author" content="Glinta Africa">
    
    <link rel="canonical" href="https://glintaafrica.com/contact">
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

        /* Contact Form */
        .contact-form {
            background: var(--white);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(212, 175, 55, 0.1);
        }

        .form-control {
            border: 2px solid rgba(212, 175, 55, 0.2);
            border-radius: 10px;
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 0.2rem rgba(212, 175, 55, 0.25);
        }

        .form-label {
            font-weight: 600;
            color: var(--black);
            margin-bottom: 0.5rem;
        }

        .btn-contact {
            background: var(--gradient-gold);
            color: var(--black);
            border: none;
            padding: 1rem 3rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-contact:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-gold);
            color: var(--black);
        }

        /* Contact Info Cards */
        .contact-card {
            background: var(--white);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow);
            transition: all 0.4s ease;
            text-align: center;
            border: 1px solid rgba(212, 175, 55, 0.1);
        }

        .contact-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-gold);
        }

        .contact-icon {
            width: 60px;
            height: 60px;
            background: var(--gradient-gold);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 1.5rem;
            color: var(--black);
        }

        .contact-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--black);
            margin-bottom: 1rem;
        }

        .contact-info {
            color: var(--gray);
            font-size: 1.1rem;
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
            
            .contact-form {
                padding: 2rem;
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
                    <h1>Contact Us</h1>
                    <p class="lead" style="color: rgba(255, 255, 255, 0.9);">
                        Ready to transform your ISP business? Get in touch for demos, support, or partnership opportunities.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Info Section -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4 mb-5">
                <div class="col-lg-4" data-aos="fade-up">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <h3 class="contact-title">Phone Support</h3>
                        <div class="contact-info">
                            <p>+254 700 123 456</p>
                            <p>Available 24/7 for enterprise customers</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h3 class="contact-title">Email Support</h3>
                        <div class="contact-info">
                            <p>support@glintaafrica.com</p>
                            <p>Response within 2 hours during business hours</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <h3 class="contact-title">Office Location</h3>
                        <div class="contact-info">
                            <p>Nairobi, Kenya</p>
                            <p>Serving ISPs across 25 African countries</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Form Section -->
    <section class="py-5" style="background: var(--white-soft);">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="contact-form" data-aos="fade-up">
                        <div class="text-center mb-4">
                            <h2 style="color: var(--black); font-family: 'Space Grotesk', sans-serif;">Get Started Today</h2>
                            <p style="color: var(--gray);">Fill out the form below and our team will get back to you within 24 hours.</p>
                        </div>
                        
                        <form>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="firstName" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="firstName" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="lastName" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="phone" required>
                                </div>
                                <div class="col-12">
                                    <label for="company" class="form-label">Company Name</label>
                                    <input type="text" class="form-control" id="company" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="country" class="form-label">Country</label>
                                    <select class="form-control" id="country" required>
                                        <option value="">Select Country</option>
                                        <option value="Kenya">Kenya</option>
                                        <option value="Uganda">Uganda</option>
                                        <option value="Tanzania">Tanzania</option>
                                        <option value="Nigeria">Nigeria</option>
                                        <option value="Ghana">Ghana</option>
                                        <option value="South Africa">South Africa</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="customers" class="form-label">Number of Customers</label>
                                    <select class="form-control" id="customers" required>
                                        <option value="">Select Range</option>
                                        <option value="1-100">1-100</option>
                                        <option value="101-500">101-500</option>
                                        <option value="501-1000">501-1000</option>
                                        <option value="1000+">1000+</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label for="inquiry" class="form-label">Inquiry Type</label>
                                    <select class="form-control" id="inquiry" required>
                                        <option value="">Select Inquiry Type</option>
                                        <option value="Demo Request">Demo Request</option>
                                        <option value="Pricing Information">Pricing Information</option>
                                        <option value="Technical Support">Technical Support</option>
                                        <option value="Partnership">Partnership Opportunity</option>
                                        <option value="General Question">General Question</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label for="message" class="form-label">Message</label>
                                    <textarea class="form-control" id="message" rows="5" placeholder="Tell us more about your ISP business and how we can help..." required></textarea>
                                </div>
                                <div class="col-12 text-center">
                                    <button type="submit" class="btn-contact">
                                        <i class="fas fa-paper-plane me-2"></i>Send Message
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Demo Links Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center mb-4">
                    <h2 style="color: var(--black); font-family: 'Space Grotesk', sans-serif;">Try Our Platform</h2>
                    <p style="color: var(--gray);">Experience our billing system with live demos before getting in touch.</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-up">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <h3 class="contact-title">Reseller Demo</h3>
                        <p style="color: var(--gray); margin-bottom: 1.5rem;">
                            Access the full admin dashboard to manage customers, plans, and analytics.
                        </p>
                        <div style="background: var(--gradient-gold); color: var(--black); padding: 1rem; border-radius: 10px; margin-bottom: 1.5rem; font-weight: 600;">
                            <strong>Username:</strong> Trial<br>
                            <strong>Password:</strong> Trialpass
                        </div>
                        <a href="{$app_url}/demo-reseller" class="btn-contact">Launch Demo</a>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3 class="contact-title">Customer Demo</h3>
                        <p style="color: var(--gray); margin-bottom: 1.5rem;">
                            Experience the customer portal for purchasing packages and managing accounts.
                        </p>
                        <div style="background: var(--gradient-gold); color: var(--black); padding: 1rem; border-radius: 10px; margin-bottom: 1.5rem; font-weight: 600;">
                            <strong>Username:</strong> Trial<br>
                            <strong>Password:</strong> Trialpass
                        </div>
                        <a href="{$app_url}/demo-customer" class="btn-contact">Launch Demo</a>
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