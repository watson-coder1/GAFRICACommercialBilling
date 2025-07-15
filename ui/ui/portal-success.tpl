<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Welcome to Glinta Africa - You're Connected!</title>
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --kenya-black: #000000;
            --kenya-red: #CE1126;
            --kenya-green: #006B3F;
            --kenya-white: #FFFFFF;
            --glinta-gold: #FFD700;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, var(--kenya-green) 0%, #10b981 50%, #34d399 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow-x: hidden;
        }
        
        .success-container {
            background: var(--kenya-white);
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
            padding: 50px 40px;
            max-width: 600px;
            width: 100%;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .success-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--kenya-black), var(--kenya-red), var(--kenya-green), var(--glinta-gold));
            animation: gradientShift 3s ease-in-out infinite;
        }
        
        @keyframes gradientShift {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        .success-icon-container {
            position: relative;
            margin-bottom: 30px;
        }
        
        .success-icon {
            font-size: 100px;
            color: var(--kenya-green);
            animation: bounceIn 1s ease-out;
            filter: drop-shadow(0 5px 15px rgba(0, 107, 63, 0.3));
        }
        
        @keyframes bounceIn {
            0% {
                transform: scale(0);
                opacity: 0;
            }
            50% {
                transform: scale(1.2);
                opacity: 0.8;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
        
        .success-rings {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 120px;
            height: 120px;
        }
        
        .ring {
            position: absolute;
            border: 3px solid var(--kenya-green);
            border-radius: 50%;
            opacity: 0.3;
            animation: ripple 2s infinite;
        }
        
        .ring:nth-child(1) {
            width: 40px;
            height: 40px;
            top: 40px;
            left: 40px;
        }
        
        .ring:nth-child(2) {
            width: 80px;
            height: 80px;
            top: 20px;
            left: 20px;
            animation-delay: 0.5s;
        }
        
        .ring:nth-child(3) {
            width: 120px;
            height: 120px;
            top: 0;
            left: 0;
            animation-delay: 1s;
        }
        
        @keyframes ripple {
            0% {
                transform: scale(0.8);
                opacity: 0.6;
            }
            100% {
                transform: scale(1.2);
                opacity: 0;
            }
        }
        
        .brand-header {
            margin-bottom: 25px;
        }
        
        .brand-title {
            font-family: 'Lobster', cursive;
            font-size: 36px;
            color: var(--glinta-gold);
            margin-bottom: 5px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 1s ease-out 0.3s both;
        }
        
        .brand-subtitle {
            font-size: 16px;
            color: var(--kenya-green);
            font-weight: 500;
            animation: fadeInUp 1s ease-out 0.5s both;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success-message {
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-out 0.7s both;
        }
        
        .success-title {
            font-size: 32px;
            font-weight: 700;
            color: var(--kenya-green);
            margin-bottom: 15px;
            line-height: 1.2;
        }
        
        .success-subtitle {
            font-size: 20px;
            color: var(--kenya-black);
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .success-description {
            font-size: 16px;
            color: #64748b;
            line-height: 1.6;
            max-width: 450px;
            margin: 0 auto;
        }
        
        .package-info {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-radius: 15px;
            padding: 25px;
            margin: 30px 0;
            border-left: 5px solid var(--kenya-green);
            animation: fadeInUp 1s ease-out 0.9s both;
        }
        
        .package-header {
            font-size: 18px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .package-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 15px;
            text-align: center;
        }
        
        .package-detail {
            padding: 10px;
            background: var(--kenya-white);
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .detail-value {
            font-size: 20px;
            font-weight: 700;
            color: var(--kenya-green);
        }
        
        .detail-label {
            font-size: 12px;
            color: #64748b;
            margin-top: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .action-section {
            margin-top: 30px;
            animation: fadeInUp 1s ease-out 1.1s both;
        }
        
        .continue-message {
            font-size: 24px;
            font-weight: 600;
            color: var(--kenya-green);
            margin-bottom: 20px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }
        
        .quick-links-section {
            margin-top: 30px;
        }
        
        .quick-links-title {
            font-size: 22px;
            font-weight: 600;
            color: var(--kenya-green);
            margin-bottom: 25px;
            text-align: center;
        }
        
        .quick-links-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .quick-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            background: var(--kenya-white);
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            text-decoration: none;
            color: var(--kenya-black);
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .quick-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            border-color: var(--kenya-green);
        }
        
        .link-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            flex-shrink: 0;
        }
        
        .link-icon svg {
            width: 24px;
            height: 24px;
        }
        
        .link-text {
            flex: 1;
        }
        
        .link-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 2px;
        }
        
        .link-desc {
            font-size: 12px;
            color: #64748b;
        }
        
        .quick-link.google:hover {
            border-color: #4285f4;
            background: #f8faff;
        }
        
        .quick-link.youtube:hover {
            border-color: #ff0000;
            background: #fff8f8;
        }
        
        .quick-link.facebook:hover {
            border-color: #1877f2;
            background: #f0f8ff;
        }
        
        .quick-link.instagram:hover {
            border-color: #e4405f;
            background: #fdf2f8;
        }
        
        .quick-link.tiktok:hover {
            border-color: #000000;
            background: #f9fafb;
        }
        
        .quick-link.twitter:hover {
            border-color: #1da1f2;
            background: #f0f9ff;
        }
        
        .quick-link.whatsapp:hover {
            border-color: #25d366;
            background: #f0fdf4;
        }
        
        .quick-link.netflix:hover {
            border-color: #e50914;
            background: #fef2f2;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 25px;
        }
        
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--kenya-green), #10b981);
            color: var(--kenya-white);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #065f46, var(--kenya-green));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 107, 63, 0.3);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, var(--glinta-gold), #fbbf24);
            color: var(--kenya-black);
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #f59e0b, var(--glinta-gold));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 215, 0, 0.3);
        }
        
        .footer-info {
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #e2e8f0;
            animation: fadeInUp 1s ease-out 1.3s both;
        }
        
        .footer-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
        }
        
        .footer-content {
            font-size: 14px;
            color: #64748b;
            line-height: 1.6;
        }
        
        .contact-info {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 15px;
        }
        
        .contact-item {
            font-size: 13px;
            color: var(--kenya-green);
            font-weight: 500;
        }
        
        .contact-item a {
            transition: all 0.3s ease;
        }
        
        .contact-item a:hover {
            color: #25d366;
            text-decoration: underline !important;
        }
        
        /* Floating particles effect */
        .particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
        }
        
        .particle {
            position: absolute;
            background: var(--glinta-gold);
            border-radius: 50%;
            opacity: 0.6;
            animation: float 6s infinite ease-in-out;
        }
        
        .particle:nth-child(1) {
            width: 6px;
            height: 6px;
            left: 10%;
            animation-delay: 0s;
        }
        
        .particle:nth-child(2) {
            width: 4px;
            height: 4px;
            left: 70%;
            animation-delay: 2s;
        }
        
        .particle:nth-child(3) {
            width: 8px;
            height: 8px;
            left: 90%;
            animation-delay: 4s;
        }
        
        @keyframes float {
            0%, 100% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 0;
            }
            10%, 90% {
                opacity: 0.6;
            }
            50% {
                transform: translateY(-10px) rotate(180deg);
            }
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .success-container {
                padding: 40px 25px;
                margin: 10px;
            }
            
            .success-icon {
                font-size: 80px;
            }
            
            .brand-title {
                font-size: 28px;
            }
            
            .success-title {
                font-size: 26px;
            }
            
            .success-subtitle {
                font-size: 18px;
            }
            
            .package-details {
                grid-template-columns: 1fr 1fr;
            }
            
            .quick-links-grid {
                grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
                gap: 12px;
            }
            
            .quick-link {
                padding: 12px;
                gap: 10px;
            }
            
            .link-icon {
                width: 28px;
                height: 28px;
            }
            
            .link-icon svg {
                width: 20px;
                height: 20px;
            }
            
            .link-title {
                font-size: 14px;
            }
            
            .link-desc {
                font-size: 11px;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 280px;
            }
        }
        
        @media (max-width: 480px) {
            .package-details {
                grid-template-columns: 1fr;
            }
            
            .quick-links-grid {
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }
            
            .quick-link {
                padding: 10px;
                gap: 8px;
            }
            
            .link-icon {
                width: 24px;
                height: 24px;
            }
            
            .link-icon svg {
                width: 18px;
                height: 18px;
            }
            
            .link-title {
                font-size: 13px;
            }
            
            .link-desc {
                font-size: 10px;
            }
            
            .contact-info {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="particles">
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
        </div>
        
        <div class="brand-header">
            <h1 class="brand-title">Glinta Africa</h1>
            <p class="brand-subtitle">Premium WiFi Solutions</p>
        </div>
        
        <div class="success-icon-container">
            <div class="success-rings">
                <div class="ring"></div>
                <div class="ring"></div>
                <div class="ring"></div>
            </div>
            <div class="success-icon">✅</div>
        </div>
        
        <div class="success-message">
            <h2 class="success-title">🎉 Payment Successful!</h2>
            <h3 class="success-subtitle">You're now connected to high-speed internet</h3>
            <p class="success-description">
                Your payment has been processed successfully and internet access has been activated. 
                Enjoy browsing, streaming, and staying connected with Glinta Africa's premium WiFi service.
            </p>
        </div>
        
        {if $package}
        <div class="package-info">
            <div class="package-header">
                <span>📦</span>
                <span>Your Active Package: {$package->name}</span>
            </div>
            <div class="package-details">
                <div class="package-detail">
                    <div class="detail-value">KSh {$package->price}</div>
                    <div class="detail-label">Amount Paid</div>
                </div>
                <div class="package-detail">
                    <div class="detail-value">{$package->duration_hours}hrs</div>
                    <div class="detail-label">Duration</div>
                </div>
                {if $session && $session->expires_at}
                <div class="package-detail">
                    <div class="detail-value">{date('H:i', strtotime($session->expires_at))}</div>
                    <div class="detail-label">Expires At</div>
                </div>
                {/if}
                <div class="package-detail">
                    <div class="detail-value">⚡</div>
                    <div class="detail-label">High Speed</div>
                </div>
            </div>
        </div>
        {/if}
        
        <div class="action-section">
            <p class="continue-message">
                Continue Surfing with Glinta Africa!
            </p>
            
            <div id="connectivityStatus" style="margin: 20px 0; padding: 15px; border-radius: 10px; background: #f0f9ff; border: 1px solid #3b82f6;">
                <div style="display: flex; align-items: center; justify-content: center; gap: 10px; color: #1e40af;">
                    <div class="spinner" style="width: 20px; height: 20px; border: 2px solid #e2e8f0; border-top: 2px solid #3b82f6; border-radius: 50%; animation: spin 1s linear infinite;"></div>
                    <span>Testing internet connectivity...</span>
                </div>
            </div>
            
            <div class="quick-links-section">
                <h3 class="quick-links-title">Quick Access - Where would you like to go?</h3>
                
                <div class="quick-links-grid">
                    <a href="https://google.com" class="quick-link google" target="_blank">
                        <div class="link-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                                <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                                <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                                <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                            </svg>
                        </div>
                        <div class="link-text">
                            <div class="link-title">Google</div>
                            <div class="link-desc">Search anything</div>
                        </div>
                    </a>
                    
                    <a href="https://youtube.com" class="quick-link youtube" target="_blank">
                        <div class="link-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z" fill="#FF0000"/>
                            </svg>
                        </div>
                        <div class="link-text">
                            <div class="link-title">YouTube</div>
                            <div class="link-desc">Watch videos</div>
                        </div>
                    </a>
                    
                    <a href="https://facebook.com" class="quick-link facebook" target="_blank">
                        <div class="link-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" fill="#1877F2"/>
                            </svg>
                        </div>
                        <div class="link-text">
                            <div class="link-title">Facebook</div>
                            <div class="link-desc">Social media</div>
                        </div>
                    </a>
                    
                    <a href="https://instagram.com" class="quick-link instagram" target="_blank">
                        <div class="link-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" fill="url(#instagram-gradient)"/>
                                <defs>
                                    <linearGradient id="instagram-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                                        <stop offset="0%" style="stop-color:#405DE6"/>
                                        <stop offset="25%" style="stop-color:#5851DB"/>
                                        <stop offset="50%" style="stop-color:#833AB4"/>
                                        <stop offset="75%" style="stop-color:#C13584"/>
                                        <stop offset="100%" style="stop-color:#E1306C"/>
                                    </linearGradient>
                                </defs>
                            </svg>
                        </div>
                        <div class="link-text">
                            <div class="link-title">Instagram</div>
                            <div class="link-desc">Photos & stories</div>
                        </div>
                    </a>
                    
                    <a href="https://tiktok.com" class="quick-link tiktok" target="_blank">
                        <div class="link-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M19.321 5.562a5.123 5.123 0 0 1-.443-.258 6.228 6.228 0 0 1-1.137-.966c-.849-.966-1.303-2.178-1.303-3.338H12.54v13.32c0 .794-.282 1.562-.793 2.162-.51.599-1.217.937-1.983.937-.766 0-1.472-.338-1.983-.937-.51-.6-.793-1.368-.793-2.162 0-.794.282-1.562.793-2.162.51-.599 1.217-.937 1.983-.937.204 0 .405.024.598.07V7.708a5.855 5.855 0 0 0-.598-.029c-1.603 0-3.139.636-4.274 1.769C3.355 10.581 2.72 12.113 2.72 13.712c0 1.599.636 3.131 1.769 4.264 1.135 1.133 2.671 1.769 4.274 1.769 1.603 0 3.139-.636 4.274-1.769 1.133-1.133 1.769-2.665 1.769-4.264V8.283a9.313 9.313 0 0 0 2.444 1.613 9.455 9.455 0 0 0 2.889.434V6.842c-.701-.041-1.386-.229-2.018-.563-.632-.333-1.198-.805-1.67-1.393-.472-.588-.84-1.267-1.088-2.006-.248-.738-.374-1.52-.374-2.31h-3.899v.04c0 1.16.454 2.372 1.303 3.338.321.366.696.679 1.112.931.415.253.87.442 1.344.559v-3.487z" fill="#000000"/>
                                <path d="M19.321 5.562a5.123 5.123 0 0 1-.443-.258 6.228 6.228 0 0 1-1.137-.966c-.849-.966-1.303-2.178-1.303-3.338H12.54v13.32c0 .794-.282 1.562-.793 2.162-.51.599-1.217.937-1.983.937-.766 0-1.472-.338-1.983-.937-.51-.6-.793-1.368-.793-2.162 0-.794.282-1.562.793-2.162.51-.599 1.217-.937 1.983-.937.204 0 .405.024.598.07V7.708a5.855 5.855 0 0 0-.598-.029c-1.603 0-3.139.636-4.274 1.769C3.355 10.581 2.72 12.113 2.72 13.712c0 1.599.636 3.131 1.769 4.264 1.135 1.133 2.671 1.769 4.274 1.769 1.603 0 3.139-.636 4.274-1.769 1.133-1.133 1.769-2.665 1.769-4.264V8.283a9.313 9.313 0 0 0 2.444 1.613 9.455 9.455 0 0 0 2.889.434V6.842c-.701-.041-1.386-.229-2.018-.563-.632-.333-1.198-.805-1.67-1.393-.472-.588-.84-1.267-1.088-2.006-.248-.738-.374-1.52-.374-2.31h-3.899v.04c0 1.16.454 2.372 1.303 3.338.321.366.696.679 1.112.931.415.253.87.442 1.344.559v-3.487z" fill="#FF0050"/>
                            </svg>
                        </div>
                        <div class="link-text">
                            <div class="link-title">TikTok</div>
                            <div class="link-desc">Short videos</div>
                        </div>
                    </a>
                    
                    <a href="https://twitter.com" class="quick-link twitter" target="_blank">
                        <div class="link-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z" fill="#1DA1F2"/>
                            </svg>
                        </div>
                        <div class="link-text">
                            <div class="link-title">Twitter</div>
                            <div class="link-desc">Latest news</div>
                        </div>
                    </a>
                    
                    <a href="https://whatsapp.com" class="quick-link whatsapp" target="_blank">
                        <div class="link-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.485 3.488" fill="#25D366"/>
                            </svg>
                        </div>
                        <div class="link-text">
                            <div class="link-title">WhatsApp</div>
                            <div class="link-desc">Chat & calls</div>
                        </div>
                    </a>
                    
                    <a href="https://netflix.com" class="quick-link netflix" target="_blank">
                        <div class="link-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M5.398 0v.006c3.028 8.556 5.37 15.175 8.348 23.596 2.344.058 4.85.398 4.854.398-2.8-7.924-5.923-16.747-8.487-24zm8.489 0v9.63L18.6 22.951c-.043-7.86-.004-15.71.002-22.95zM5.398 1.05V24c1.873-.225 2.81-.312 4.715-.398v-9.22z" fill="#E50914"/>
                            </svg>
                        </div>
                        <div class="link-text">
                            <div class="link-title">Netflix</div>
                            <div class="link-desc">Stream movies</div>
                        </div>
                    </a>
                </div>
                
                <div class="action-buttons">
                    <button id="autoRedirectBtn" class="btn btn-primary">
                        <span>🔄</span>
                        <span>Auto-redirect to Google (10s)</span>
                    </button>
                    <button id="stayHereBtn" class="btn btn-secondary">
                        <span>⏸️</span>
                        <span>Stay Here</span>
                    </button>
                </div>
            </div>
        </div>
        
        <div class="footer-info">
            <h4 class="footer-title">Thank you for choosing Glinta Africa!</h4>
            <div class="footer-content">
                <p>You're now connected to Kenya's fastest and most reliable WiFi network. 
                   Enjoy unlimited access to websites, social media, streaming, and more.</p>
                
                <div class="contact-info">
                    <div class="contact-item">📧 support@glintaafrica.com</div>
                    <div class="contact-item">📞 0711311897</div>
                    <div class="contact-item">
                        <a href="https://wa.me/254711311897" target="_blank" style="color: var(--kenya-green); text-decoration: none;">
                            💬 WhatsApp Support
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Auto-redirect functionality
        let countdown = 10;
        let autoRedirectEnabled = true;
        const autoRedirectBtn = document.getElementById('autoRedirectBtn');
        const stayHereBtn = document.getElementById('stayHereBtn');
        
        function updateCountdown() {
            if (countdown > 0 && autoRedirectEnabled) {
                autoRedirectBtn.innerHTML = '<span>🔄</span><span>Auto-redirect to Google (' + countdown + 's)</span>';
                countdown--;
                setTimeout(updateCountdown, 1000);
            } else if (autoRedirectEnabled) {
                autoRedirectBtn.innerHTML = '<span>🔍</span><span>Redirecting to Google...</span>';
                window.open('https://google.com', '_blank');
            }
        }
        
        // Handle stay here button
        stayHereBtn.addEventListener('click', function() {
            autoRedirectEnabled = false;
            autoRedirectBtn.innerHTML = `
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                    <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                    <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                    <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                </svg>
                <span>Browse Google</span>
            `;
            autoRedirectBtn.onclick = function() {
                window.open('https://google.com', '_blank');
            };
            stayHereBtn.style.display = 'none';
        });
        
        // Start countdown after page loads
        setTimeout(updateCountdown, 3000);
        
        // Test internet connectivity and auto-redirect
        function testConnectivity() {
            const statusDiv = document.getElementById('connectivityStatus');
            
            fetch('/connectivity_test.php')
                .then(response => response.json())
                .then(data => {
                    if (data.connected) {
                        // Internet is working!
                        statusDiv.innerHTML = `
                            <div style="display: flex; align-items: center; justify-content: center; gap: 10px; color: #059669;">
                                <span style="font-size: 24px;">✅</span>
                                <span><strong>Internet Connected!</strong> Redirecting to browser...</span>
                            </div>
                        `;
                        statusDiv.style.background = '#f0fdf4';
                        statusDiv.style.borderColor = '#059669';
                        
                        console.log('✅ Internet access confirmed, redirecting...');
                        
                        // Redirect to Google after 3 seconds
                        setTimeout(() => {
                            window.location.href = 'http://google.com';
                        }, 3000);
                    } else {
                        // Still no internet, wait and try again
                        setTimeout(testConnectivity, 2000);
                    }
                })
                .catch(error => {
                    // Error means no internet yet, try again
                    console.log('❌ No internet yet, retrying...');
                    
                    // Update status to show we're still trying
                    statusDiv.innerHTML = `
                        <div style="display: flex; align-items: center; justify-content: center; gap: 10px; color: #dc2626;">
                            <div class="spinner" style="width: 20px; height: 20px; border: 2px solid #e2e8f0; border-top: 2px solid #dc2626; border-radius: 50%; animation: spin 1s linear infinite;"></div>
                            <span>Activating internet access...</span>
                        </div>
                    `;
                    statusDiv.style.background = '#fef2f2';
                    statusDiv.style.borderColor = '#dc2626';
                    
                    setTimeout(testConnectivity, 2000);
                });
        }
        
        // Start testing connectivity after 5 seconds
        setTimeout(testConnectivity, 5000);
        
        // Celebrate with confetti effect (optional)
        function createConfetti() {
            const colors = ['#FFD700', '#006B3F', '#CE1126', '#FFFFFF'];
            
            for (let i = 0; i < 50; i++) {
                setTimeout(() => {
                    const confetti = document.createElement('div');
                    confetti.style.position = 'fixed';
                    confetti.style.left = Math.random() * 100 + 'vw';
                    confetti.style.top = '-10px';
                    confetti.style.width = '10px';
                    confetti.style.height = '10px';
                    confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
                    confetti.style.borderRadius = '50%';
                    confetti.style.pointerEvents = 'none';
                    confetti.style.zIndex = '9999';
                    confetti.style.animation = 'confettiFall 3s linear forwards';
                    
                    document.body.appendChild(confetti);
                    
                    setTimeout(() => {
                        confetti.remove();
                    }, 3000);
                }, i * 100);
            }
        }
        
        // Add confetti animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes confettiFall {
                to {
                    transform: translateY(100vh) rotate(360deg);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
        
        // Trigger confetti on page load
        setTimeout(createConfetti, 1000);
    </script>
</body>
</html>