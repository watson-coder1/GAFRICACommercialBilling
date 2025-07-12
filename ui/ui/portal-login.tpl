<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">
    <title>Glinta Africa - WiFi Packages</title>
    <meta name="google-adsense-account" content="ca-pub-7906696382628802">
    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7906696382628802" crossorigin="anonymous"></script>
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/sweetalert2.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --kenya-black: #000000;
            --kenya-red: #CE1126;
            --kenya-green: #006B3F;
            --kenya-white: #FFFFFF;
            --glinta-gold: #FFD700;
        }
        
        /* Loading Screen */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--kenya-black) 0%, #1a1a1a 50%, var(--kenya-green) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease-out;
        }
        
        .loading-overlay.fade-out {
            opacity: 0;
            pointer-events: none;
        }
        
        .loading-logo {
            width: 120px;
            height: 120px;
            background: var(--glinta-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 30px;
            animation: logoSpin 2s linear infinite;
            box-shadow: 0 0 30px rgba(255, 215, 0, 0.5);
        }
        
        .loading-logo::before {
            content: 'G';
            font-size: 48px;
            font-weight: bold;
            color: var(--kenya-black);
            font-family: 'Lobster', cursive;
        }
        
        @keyframes logoSpin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .loading-text {
            color: var(--kenya-white);
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 10px;
            animation: loadingPulse 1.5s ease-in-out infinite;
        }
        
        .loading-subtitle {
            color: var(--glinta-gold);
            font-size: 16px;
            margin-bottom: 30px;
            font-style: italic;
        }
        
        .loading-progress {
            width: 200px;
            height: 4px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 2px;
            overflow: hidden;
        }
        
        .loading-progress-bar {
            height: 100%;
            background: linear-gradient(90deg, var(--glinta-gold), var(--kenya-green));
            border-radius: 2px;
            animation: progressMove 2s ease-in-out infinite;
        }
        
        @keyframes loadingPulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        @keyframes progressMove {
            0% { width: 0%; }
            50% { width: 70%; }
            100% { width: 100%; }
        }
        
        body {
            background: linear-gradient(135deg, var(--kenya-black) 0%, #1a1a1a 30%, var(--kenya-green) 100%);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 10px;
            overflow-x: hidden;
            position: relative;
        }
        
        /* Mobile keyboard handling */
        @media screen and (max-width: 768px) {
            body {
                padding: 5px;
            }
            
            /* Fix for mobile keyboard covering input */
            .portal-container {
                position: relative;
                margin-top: 10px;
                margin-bottom: 10px;
            }
            
            /* Ensure input is visible when focused */
            .phone-input input:focus {
                position: relative;
                z-index: 1000;
            }
            
            /* Adjust container when keyboard is open */
            .portal-container.keyboard-open {
                transform: translateY(-50px);
                transition: transform 0.3s ease;
            }
        }
        
        /* Ad containers positioned at corners */
        .ad-container {
            position: fixed;
            z-index: 100;
            border-radius: 8px;
            background: rgba(255,255,255,0.95);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Fallback content when ads don't load */
        .ad-fallback {
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, #f8f9fa, #e9ecef);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 10px;
            color: #666;
            font-size: 12px;
        }
        
        .ad-fallback .logo {
            font-size: 18px;
            font-weight: bold;
            color: #FFD700;
            margin-bottom: 5px;
        }
        
        .ad-fallback .tagline {
            font-size: 10px;
            opacity: 0.8;
        }
        
        .ad-top-left {
            top: 10px;
            left: 10px;
            width: 200px;
            height: 200px;
        }
        
        .ad-top-right {
            top: 10px;
            right: 10px;
            width: 200px;
            height: 200px;
        }
        
        .ad-bottom-left {
            bottom: 10px;
            left: 10px;
            width: 200px;
            height: 200px;
        }
        
        .ad-bottom-right {
            bottom: 10px;
            right: 10px;
            width: 200px;
            height: 200px;
        }
        
        /* Hide ads on mobile to avoid interference */
        @media (max-width: 768px) {
            .ad-container {
                display: none;
            }
        }
        
        /* Medium screens - reduce ad size */
        @media (min-width: 769px) and (max-width: 1024px) {
            .ad-container {
                width: 150px;
                height: 150px;
            }
        }
        
        /* Large screens - show all ads */
        @media (min-width: 1025px) {
            .ad-container {
                width: 200px;
                height: 200px;
            }
        }
        
        .portal-container {
            background: linear-gradient(135deg, var(--kenya-white) 0%, #f8f9fa 100%);
            border: 3px solid var(--glinta-gold);
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.15), 0 0 20px rgba(255, 215, 0, 0.1);
            padding: 25px;
            max-width: 480px;
            width: 100%;
            margin: 20px auto;
            max-height: 95vh;
            overflow-y: auto;
            position: relative;
            z-index: 50;
        }
        
        .portal-container::before {
            content: '';
            position: absolute;
            top: -3px;
            left: -3px;
            right: -3px;
            bottom: -3px;
            background: linear-gradient(45deg, var(--glinta-gold), var(--kenya-green), var(--kenya-black));
            border-radius: 28px;
            z-index: -1;
            animation: borderGlow 3s ease-in-out infinite;
        }
        
        @keyframes borderGlow {
            0%, 100% { opacity: 0.7; }
            50% { opacity: 1; }
        }
        
        /* Enhanced responsive breakpoints */
        @media (max-width: 480px) {
            body {
                padding: 3px;
                min-height: 100vh;
                display: flex;
                align-items: flex-start;
                justify-content: center;
                padding-top: 20px;
            }
            .portal-container {
                padding: 15px;
                border-radius: 15px;
                margin: 0 auto;
                max-height: none;
                max-width: 95%;
                width: 95%;
                position: relative;
                min-height: auto;
            }
            
            /* Mobile input improvements */
            .phone-input {
                margin-top: 15px;
                margin-bottom: 20px;
            }
            
            .phone-input input {
                font-size: 16px; /* Prevents zoom on iOS */
                padding: 15px;
                border-radius: 8px;
            }
            
            .continue-btn {
                padding: 16px 20px;
                font-size: 16px;
                margin-top: 10px;
            }
        }
        
        @media (min-width: 481px) and (max-width: 768px) {
            .portal-container {
                padding: 15px;
                border-radius: 15px;
                margin: 10px auto;
                max-height: 98vh;
                max-width: 90%;
            }
        }
        
        @media (min-width: 769px) and (max-width: 1024px) {
            .portal-container {
                padding: 25px;
                max-width: 500px;
            }
        }
        
        @media (min-width: 1025px) {
            .portal-container {
                padding: 30px;
                max-width: 550px;
            }
        }
        .brand-title {
            font-family: 'Lobster', cursive;
            background: linear-gradient(45deg, var(--glinta-gold), #DAA520);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 36px;
            text-align: center;
            margin-bottom: 5px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            position: relative;
        }
        
        .patriotic-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-bottom: 15px;
            font-size: 14px;
            color: var(--kenya-green);
            font-weight: 500;
        }
        
        .flag-colors {
            display: flex;
            gap: 2px;
        }
        
        .flag-stripe {
            width: 20px;
            height: 4px;
            border-radius: 2px;
        }
        
        .flag-black { background: var(--kenya-black); }
        .flag-red { background: var(--kenya-red); }
        .flag-green { background: var(--kenya-green); }
        
        /* Responsive typography */
        @media (max-width: 480px) {
            .brand-title {
                font-size: 24px;
                margin-bottom: 8px;
            }
            .subtitle {
                font-size: 14px !important;
                margin-bottom: 20px !important;
            }
        }
        
        @media (min-width: 481px) and (max-width: 768px) {
            .brand-title {
                font-size: 28px;
            }
        }
        
        @media (min-width: 1025px) {
            .brand-title {
                font-size: 36px;
            }
        }
        
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }
        .package-card {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 15px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            transform: translateY(0);
            animation: cardFloat 4s ease-in-out infinite;
        }
        
        @keyframes cardFloat {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-2px); }
        }
        
        .package-card:nth-child(even) {
            animation-delay: 2s;
        }
        
        /* Enhanced package card responsiveness */
        @media (max-width: 480px) {
            .package-card {
                padding: 10px;
                margin-bottom: 8px;
                border-radius: 10px;
            }
            .package-name {
                font-size: 16px !important;
            }
            .package-price {
                font-size: 20px !important;
            }
        }
        
        @media (min-width: 481px) and (max-width: 768px) {
            .package-card {
                padding: 12px;
                margin-bottom: 10px;
                border-radius: 12px;
            }
        }
        
        @media (min-width: 769px) {
            .package-card {
                padding: 18px;
                margin-bottom: 15px;
            }
        }
        .package-card:hover {
            border-color: #00C851;
            box-shadow: 0 8px 25px rgba(0, 200, 81, 0.2);
            transform: translateY(-5px) scale(1.02);
            animation: none;
        }
        .package-card.selected {
            border-color: #00C851;
            background: linear-gradient(135deg, #f8fff9, #e8f7ea);
            box-shadow: 0 10px 30px rgba(0, 200, 81, 0.15);
            animation: selectedPulse 1.5s ease-in-out infinite;
        }
        
        @keyframes selectedPulse {
            0%, 100% { box-shadow: 0 10px 30px rgba(0, 200, 81, 0.15); }
            50% { box-shadow: 0 10px 30px rgba(0, 200, 81, 0.25); }
        }
        .package-name {
            font-size: 18px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        .package-price {
            font-size: 26px;
            font-weight: bold;
            background: linear-gradient(45deg, var(--kenya-green), #28a745);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
            animation: priceGlow 2s ease-in-out infinite alternate;
            position: relative;
        }
        
        .package-price::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 50%;
            transform: translateX(-50%);
            width: 60%;
            height: 2px;
            background: var(--glinta-gold);
            border-radius: 1px;
            animation: underlineGlow 1.5s ease-in-out infinite;
        }
        
        @keyframes priceGlow {
            from { filter: brightness(1); }
            to { filter: brightness(1.2) drop-shadow(0 0 5px rgba(0, 107, 63, 0.3)); }
        }
        
        @keyframes underlineGlow {
            0%, 100% { opacity: 0.6; width: 40%; }
            50% { opacity: 1; width: 80%; }
        }
        .package-details {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .package-description {
            color: #888;
            font-size: 12px;
        }
        .phone-input {
            margin-top: 20px;
        }
        .phone-input input {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            font-size: 16px;
            width: 100%;
            margin-bottom: 10px;
        }
        .phone-input input:focus {
            border-color: #FFD700;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(255,215,0,0.25);
        }
        .continue-btn {
            background: linear-gradient(45deg, var(--kenya-green), #28a745);
            border: 2px solid var(--glinta-gold);
            color: var(--kenya-white);
            padding: 18px 30px;
            font-size: 18px;
            font-weight: 600;
            border-radius: 12px;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .continue-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .continue-btn:hover::before {
            left: 100%;
        }
        
        .continue-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 200, 81, 0.3);
            background: linear-gradient(45deg, #28a745, #00C851);
        }
        .continue-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        .wifi-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
        }
        .wifi-info small {
            color: #666;
        }
    </style>
</head>
<body>
    <!-- Loading Screen -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-logo"></div>
        <div class="loading-text">Karibu Glinta Africa</div>
        <div class="loading-subtitle">🇰🇪 "Harambee - Unity is Strength" 🇰🇪</div>
        <div class="loading-progress">
            <div class="loading-progress-bar"></div>
        </div>
    </div>

    <!-- Google AdSense containers positioned at corners -->
    <!-- Only visible on desktop/tablet - hidden on mobile -->
    <div class="ad-container ad-top-left">
        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7906696382628802"
                crossorigin="anonymous"></script>
        <!-- Top Left Ad -->
        <ins class="adsbygoogle"
             style="display:block;width:200px;height:200px"
             data-ad-client="ca-pub-7906696382628802"
             data-ad-slot="1234567890"
             data-ad-format="auto"></ins>
        <script>
             (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
        <!-- Fallback content -->
        <div class="ad-fallback" style="display:none;">
            <div class="logo">Glinta</div>
            <div class="tagline">Fast WiFi</div>
        </div>
    </div>
    
    <div class="ad-container ad-top-right">
        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7906696382628802"
                crossorigin="anonymous"></script>
        <!-- Top Right Ad -->
        <ins class="adsbygoogle"
             style="display:block;width:200px;height:200px"
             data-ad-client="ca-pub-7906696382628802"
             data-ad-slot="1234567891"
             data-ad-format="auto"></ins>
        <script>
             (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
        <!-- Fallback content -->
        <div class="ad-fallback" style="display:none;">
            <div class="logo">Glinta</div>
            <div class="tagline">Reliable Internet</div>
        </div>
    </div>
    
    <div class="ad-container ad-bottom-left">
        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7906696382628802"
                crossorigin="anonymous"></script>
        <!-- Bottom Left Ad -->
        <ins class="adsbygoogle"
             style="display:block;width:200px;height:200px"
             data-ad-client="ca-pub-7906696382628802"
             data-ad-slot="1234567892"
             data-ad-format="auto"></ins>
        <script>
             (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
        <!-- Fallback content -->
        <div class="ad-fallback" style="display:none;">
            <div class="logo">Glinta</div>
            <div class="tagline">24/7 Support</div>
        </div>
    </div>
    
    <div class="ad-container ad-bottom-right">
        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7906696382628802"
                crossorigin="anonymous"></script>
        <!-- Bottom Right Ad -->
        <ins class="adsbygoogle"
             style="display:block;width:200px;height:200px"
             data-ad-client="ca-pub-7906696382628802"
             data-ad-slot="1234567893"
             data-ad-format="auto"></ins>
        <script>
             (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
        <!-- Fallback content -->
        <div class="ad-fallback" style="display:none;">
            <div class="logo">Glinta</div>
            <div class="tagline">Africa WiFi</div>
        </div>
    </div>

    <div class="portal-container">
        <div class="brand-title">Glinta Africa</div>
        <div class="patriotic-badge">
            <span>🇰🇪</span>
            <div class="flag-colors">
                <div class="flag-stripe flag-black"></div>
                <div class="flag-stripe flag-red"></div>
                <div class="flag-stripe flag-green"></div>
            </div>
            <span>Proudly Kenyan</span>
        </div>
        <div class="subtitle">Choose Your WiFi Package - Chagua Mpango Wako</div>
        
        <div class="wifi-info">
            <small>
                <strong>Device:</strong> <span id="device-info">{$mac|default:"Detecting..."}</span><br>
                <strong>IP:</strong> <span id="ip-info">{$ip|default:"Detecting..."}</span>
            </small>
        </div>
        
        <form method="post" action="{$app_url}/?_route=portal/select" id="packageForm">
            <input type="hidden" name="session_id" value="{$session_id}">
            <input type="hidden" name="package_id" id="selected_package_id">
            
            {foreach $packages as $package}
                <div class="package-card" data-package-id="{$package->id}">
                    <div class="package-name">{$package->name}</div>
                    <div class="package-price">KSh {$package->price}</div>
                    <div class="package-details">
                        {$package->duration_hours} hours
                        {if $package->data_limit_mb}
                            • {($package->data_limit_mb/1024)|number_format:1}GB data
                        {/if}
                    </div>
                    <div class="package-description">{$package->description}</div>
                </div>
            {/foreach}
            
            <div class="phone-input">
                <input type="tel" name="phone_number" placeholder="07XX XXX XXX" 
                       pattern="^(254|0)[17]\d{8}$" required maxlength="10">
                <small class="form-text text-muted">🇰🇪 Kenyan mobile number (e.g., 0712345678)</small>
            </div>
            
            <button type="submit" class="continue-btn" disabled>
                🚀 Lipa na M-Pesa - Pay Now
            </button>
        </form>
    </div>
    
    <script src="{$app_url}/ui/ui/scripts/sweetalert2.all.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const packageCards = document.querySelectorAll('.package-card');
            const packageIdInput = document.getElementById('selected_package_id');
            const continueBtn = document.querySelector('.continue-btn');
            const phoneInput = document.querySelector('input[name="phone_number"]');
            const deviceInfo = document.getElementById('device-info');
            const ipInfo = document.getElementById('ip-info');
            
            // Enhanced device detection
            function detectDeviceInfo() {
                const userAgent = navigator.userAgent;
                let deviceType = 'Unknown Device';
                
                if (/iPhone/i.test(userAgent)) {
                    deviceType = 'iPhone';
                } else if (/iPad/i.test(userAgent)) {
                    deviceType = 'iPad';
                } else if (/Android/i.test(userAgent)) {
                    if (/Mobile/i.test(userAgent)) {
                        deviceType = 'Android Phone';
                    } else {
                        deviceType = 'Android Tablet';
                    }
                } else if (/Windows/i.test(userAgent)) {
                    deviceType = 'Windows PC';
                } else if (/Mac/i.test(userAgent)) {
                    deviceType = 'Mac';
                } else if (/Linux/i.test(userAgent)) {
                    deviceType = 'Linux PC';
                }
                
                // Update device info if it shows default text
                if (deviceInfo.textContent.includes('Detecting') || deviceInfo.textContent.includes('device-')) {
                    deviceInfo.textContent = deviceType;
                }
                
                // Try to get more accurate IP info
                if (ipInfo.textContent.includes('Detecting')) {
                    // This will be updated by the server-side detection
                    ipInfo.textContent = 'Getting IP...';
                }
            }
            
            // Add entrance animations
            function animateEntrance() {
                packageCards.forEach((card, index) => {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                    setTimeout(() => {
                        card.style.transition = 'all 0.5s ease';
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, index * 100);
                });
            }
            
            packageCards.forEach(card => {
                card.addEventListener('click', function() {
                    // Remove selected class from all cards
                    packageCards.forEach(c => c.classList.remove('selected'));
                    
                    // Add selected class to clicked card with animation
                    this.classList.add('selected');
                    
                    // Add selection effect
                    const ripple = document.createElement('div');
                    ripple.style.cssText = `
                        position: absolute;
                        border-radius: 50%;
                        background: rgba(0, 200, 81, 0.3);
                        transform: scale(0);
                        animation: ripple 0.6s linear;
                        pointer-events: none;
                        width: 50px;
                        height: 50px;
                        left: 50%;
                        top: 50%;
                        margin-left: -25px;
                        margin-top: -25px;
                    `;
                    this.appendChild(ripple);
                    
                    setTimeout(() => ripple.remove(), 600);
                    
                    // Set package ID
                    packageIdInput.value = this.dataset.packageId;
                    
                    // Enable continue button if phone number is entered
                    checkFormValid();
                });
            });
            
            phoneInput.addEventListener('input', checkFormValid);
            
            // Mobile keyboard handling
            function handleMobileKeyboard() {
                const portalContainer = document.querySelector('.portal-container');
                const isMobile = window.innerWidth <= 768;
                
                if (isMobile) {
                    phoneInput.addEventListener('focus', function() {
                        // Scroll input into view
                        setTimeout(() => {
                            this.scrollIntoView({ 
                                behavior: 'smooth', 
                                block: 'center',
                                inline: 'nearest'
                            });
                        }, 300);
                        
                        // Add keyboard open class
                        portalContainer.classList.add('keyboard-open');
                    });
                    
                    phoneInput.addEventListener('blur', function() {
                        // Remove keyboard open class
                        portalContainer.classList.remove('keyboard-open');
                    });
                    
                    // Handle viewport changes (keyboard open/close)
                    let viewportHeight = window.visualViewport ? window.visualViewport.height : window.innerHeight;
                    
                    if (window.visualViewport) {
                        window.visualViewport.addEventListener('resize', () => {
                            const currentHeight = window.visualViewport.height;
                            const heightDifference = viewportHeight - currentHeight;
                            
                            if (heightDifference > 100) {
                                // Keyboard is likely open
                                document.body.style.paddingBottom = '200px';
                            } else {
                                // Keyboard is likely closed
                                document.body.style.paddingBottom = '10px';
                            }
                        });
                    }
                }
            }
            
            function checkFormValid() {
                const hasPackage = packageIdInput.value !== '';
                const hasPhone = phoneInput.value.trim() !== '';
                continueBtn.disabled = !(hasPackage && hasPhone);
            }
            
            // Loading screen control
            function hideLoadingScreen() {
                setTimeout(() => {
                    const loadingOverlay = document.getElementById('loadingOverlay');
                    loadingOverlay.classList.add('fade-out');
                    setTimeout(() => {
                        loadingOverlay.style.display = 'none';
                    }, 500);
                }, 2500); // Show loading for 2.5 seconds
            }
            
            // Initialize
            detectDeviceInfo();
            handleMobileKeyboard();
            hideLoadingScreen();
            setTimeout(() => {
                animateEntrance();
            }, 3000); // Start entrance animation after loading screen
        });
        
        // Add ripple animation CSS
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>