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
            font-size: 24px;
            flex-shrink: 0;
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
                font-size: 20px;
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
                font-size: 18px;
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
                    <div class="detail-value">🚀</div>
                    <div class="detail-label">High Speed</div>
                </div>
            </div>
        </div>
        {/if}
        
        <div class="action-section">
            <p class="continue-message">
                🌐 Continue Surfing with Glinta Africa!
            </p>
            
            <div id="connectivityStatus" style="margin: 20px 0; padding: 15px; border-radius: 10px; background: #f0f9ff; border: 1px solid #3b82f6;">
                <div style="display: flex; align-items: center; justify-content: center; gap: 10px; color: #1e40af;">
                    <div class="spinner" style="width: 20px; height: 20px; border: 2px solid #e2e8f0; border-top: 2px solid #3b82f6; border-radius: 50%; animation: spin 1s linear infinite;"></div>
                    <span>Testing internet connectivity...</span>
                </div>
            </div>
            
            <div class="quick-links-section">
                <h3 class="quick-links-title">🚀 Quick Access - Where would you like to go?</h3>
                
                <div class="quick-links-grid">
                    <a href="https://google.com" class="quick-link google" target="_blank">
                        <div class="link-icon">🔍</div>
                        <div class="link-text">
                            <div class="link-title">Google</div>
                            <div class="link-desc">Search anything</div>
                        </div>
                    </a>
                    
                    <a href="https://youtube.com" class="quick-link youtube" target="_blank">
                        <div class="link-icon">📺</div>
                        <div class="link-text">
                            <div class="link-title">YouTube</div>
                            <div class="link-desc">Watch videos</div>
                        </div>
                    </a>
                    
                    <a href="https://facebook.com" class="quick-link facebook" target="_blank">
                        <div class="link-icon">📘</div>
                        <div class="link-text">
                            <div class="link-title">Facebook</div>
                            <div class="link-desc">Social media</div>
                        </div>
                    </a>
                    
                    <a href="https://instagram.com" class="quick-link instagram" target="_blank">
                        <div class="link-icon">📸</div>
                        <div class="link-text">
                            <div class="link-title">Instagram</div>
                            <div class="link-desc">Photos & stories</div>
                        </div>
                    </a>
                    
                    <a href="https://tiktok.com" class="quick-link tiktok" target="_blank">
                        <div class="link-icon">🎵</div>
                        <div class="link-text">
                            <div class="link-title">TikTok</div>
                            <div class="link-desc">Short videos</div>
                        </div>
                    </a>
                    
                    <a href="https://twitter.com" class="quick-link twitter" target="_blank">
                        <div class="link-icon">🐦</div>
                        <div class="link-text">
                            <div class="link-title">Twitter</div>
                            <div class="link-desc">Latest news</div>
                        </div>
                    </a>
                    
                    <a href="https://whatsapp.com" class="quick-link whatsapp" target="_blank">
                        <div class="link-icon">💬</div>
                        <div class="link-text">
                            <div class="link-title">WhatsApp</div>
                            <div class="link-desc">Chat & calls</div>
                        </div>
                    </a>
                    
                    <a href="https://netflix.com" class="quick-link netflix" target="_blank">
                        <div class="link-icon">🎬</div>
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
                    <div class="contact-item">💬 WhatsApp Support</div>
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
            autoRedirectBtn.innerHTML = '<span>🔍</span><span>Click to Browse Google</span>';
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