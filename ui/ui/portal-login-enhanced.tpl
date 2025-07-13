<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">
    <title>Glinta Africa - WiFi Access Portal</title>
    <meta name="description" content="Purchase WiFi packages or authenticate with voucher code">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/sweetalert2.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --kenya-black: #000000;
            --kenya-red: #CE1126;
            --kenya-green: #006B3F;
            --kenya-white: #FFFFFF;
            --glinta-gold: #FFD700;
            --glinta-blue: #1e3a8a;
            --glinta-gray: #f8fafc;
            --glinta-border: #e2e8f0;
        }
        
        body {
            margin: 0;
            padding: 0;
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, var(--glinta-gray) 0%, #e0f2fe 50%, #f0f9ff 100%);
            min-height: 100vh;
            overflow-x: hidden;
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
            width: 100px;
            height: 100px;
            background: var(--glinta-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            animation: logoSpin 2s linear infinite;
            box-shadow: 0 0 30px rgba(255, 215, 0, 0.5);
        }
        
        .loading-logo::before {
            content: 'G';
            font-size: 40px;
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
            font-size: 20px;
            font-weight: 500;
            margin-bottom: 10px;
        }
        
        /* Header */
        .header {
            background: linear-gradient(135deg, var(--kenya-black) 0%, var(--kenya-green) 100%);
            color: var(--kenya-white);
            padding: 20px 0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        
        .header .container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logo-circle {
            width: 50px;
            height: 50px;
            background: var(--glinta-gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Lobster', cursive;
            font-size: 24px;
            font-weight: bold;
            color: var(--kenya-black);
        }
        
        .brand-text h1 {
            margin: 0;
            font-family: 'Lobster', cursive;
            font-size: 24px;
            color: var(--glinta-gold);
        }
        
        .brand-text p {
            margin: 0;
            font-size: 14px;
            opacity: 0.9;
        }
        
        .wifi-status {
            text-align: right;
            font-size: 12px;
            opacity: 0.8;
        }
        
        /* Guidance Section */
        .guidance-section {
            background: linear-gradient(135deg, var(--glinta-blue) 0%, #3b82f6 100%);
            color: var(--kenya-white);
            padding: 20px 0;
            margin-bottom: 30px;
        }
        
        .guidance-content {
            text-align: center;
        }
        
        .guidance-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--glinta-gold);
        }
        
        .guidance-steps {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            max-width: 150px;
        }
        
        .step-number {
            width: 40px;
            height: 40px;
            background: var(--glinta-gold);
            color: var(--kenya-black);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 18px;
        }
        
        .step-text {
            font-size: 14px;
            text-align: center;
        }
        
        /* Main Content */
        .main-content {
            padding: 0 20px 40px;
        }
        
        .portal-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .portal-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .portal-card {
            background: var(--kenya-white);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--glinta-border);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .portal-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .card-header {
            text-align: center;
            margin-bottom: 25px;
        }
        
        .card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--kenya-green), #10b981);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 24px;
            color: var(--kenya-white);
        }
        
        .card-title {
            font-size: 22px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 10px;
        }
        
        .card-subtitle {
            color: #64748b;
            font-size: 14px;
            line-height: 1.5;
        }
        
        /* Package Selection */
        .package-grid {
            display: grid;
            gap: 15px;
            margin-bottom: 25px;
        }
        
        .package-card {
            border: 2px solid var(--glinta-border);
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #f8fafc;
        }
        
        .package-card:hover {
            border-color: var(--kenya-green);
            background: #f0fdf4;
            transform: translateY(-2px);
        }
        
        .package-card.selected {
            border-color: var(--kenya-green);
            background: linear-gradient(135deg, #f0fdf4, #dcfce7);
            box-shadow: 0 4px 15px rgba(0, 107, 63, 0.2);
        }
        
        .package-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .package-name {
            font-weight: 600;
            color: var(--kenya-black);
            font-size: 16px;
        }
        
        .package-price {
            font-weight: bold;
            color: var(--kenya-green);
            font-size: 18px;
        }
        
        .package-details {
            font-size: 13px;
            color: #64748b;
        }
        
        /* Form Styling */
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--kenya-black);
        }
        
        .form-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--glinta-border);
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--kenya-green);
            box-shadow: 0 0 0 3px rgba(0, 107, 63, 0.1);
        }
        
        .btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--kenya-green), #10b981);
            color: var(--kenya-white);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #065f46, var(--kenya-green));
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 107, 63, 0.3);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, var(--glinta-blue), #3b82f6);
            color: var(--kenya-white);
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #1e40af, var(--glinta-blue));
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(30, 58, 138, 0.3);
        }
        
        /* Voucher Card */
        .voucher-input-group {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .voucher-input {
            flex: 1;
        }
        
        .voucher-btn {
            padding: 12px 20px;
            background: var(--glinta-gold);
            color: var(--kenya-black);
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .voucher-btn:hover {
            background: #fbbf24;
            transform: translateY(-2px);
        }
        
        .divider {
            text-align: center;
            margin: 20px 0;
            position: relative;
        }
        
        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: var(--glinta-border);
        }
        
        .divider-text {
            background: var(--kenya-white);
            padding: 0 15px;
            color: #64748b;
            font-size: 14px;
        }
        
        /* Help Section */
        .help-section {
            background: var(--kenya-white);
            border-radius: 15px;
            padding: 25px;
            margin-top: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-left: 5px solid var(--glinta-gold);
        }
        
        .help-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .help-content {
            color: #64748b;
            line-height: 1.6;
        }
        
        .help-contact {
            background: #f8fafc;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
            text-align: center;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .portal-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .guidance-steps {
                gap: 20px;
            }
            
            .step {
                max-width: 120px;
            }
            
            .portal-card {
                padding: 20px;
            }
            
            .voucher-input-group {
                flex-direction: column;
            }
            
            .header .container {
                text-align: center;
            }
            
            .wifi-status {
                text-align: center;
                margin-top: 10px;
            }
        }
        
        @media (max-width: 480px) {
            .main-content {
                padding: 0 15px 30px;
            }
            
            .guidance-steps {
                flex-direction: column;
                align-items: center;
                gap: 15px;
            }
        }
        
        /* Loading states */
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }
        
        .spinner {
            width: 20px;
            height: 20px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            display: inline-block;
            margin-right: 8px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <!-- Loading Screen -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-logo"></div>
        <div class="loading-text">Glinta Africa</div>
        <div style="color: var(--glinta-gold); font-size: 14px;">Connecting Kenya to the World</div>
    </div>

    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="logo">
                <div class="logo-circle">G</div>
                <div class="brand-text">
                    <h1>Glinta Africa</h1>
                    <p>Premium WiFi Solutions</p>
                </div>
            </div>
            <div class="wifi-status">
                <div>📡 Connected to Glinta WiFi</div>
            </div>
        </div>
    </header>

    <!-- Guidance Section -->
    <section class="guidance-section">
        <div class="container">
            <div class="guidance-content">
                <h2 class="guidance-title">🚀 Get Online in 3 Easy Steps</h2>
                <p>Choose your preferred method to access high-speed internet</p>
                
                <div class="guidance-steps">
                    <div class="step">
                        <div class="step-number">1</div>
                        <div class="step-text">Select a WiFi package or enter voucher code</div>
                    </div>
                    <div class="step">
                        <div class="step-number">2</div>
                        <div class="step-text">Complete payment via M-Pesa or authenticate</div>
                    </div>
                    <div class="step">
                        <div class="step-number">3</div>
                        <div class="step-text">Enjoy unlimited high-speed internet access</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <div class="portal-container">
            <div class="portal-grid">
                <!-- WiFi Packages Column -->
                <div class="portal-card">
                    <div class="card-header">
                        <div class="card-icon">📱</div>
                        <h3 class="card-title">Purchase WiFi Package</h3>
                        <p class="card-subtitle">Choose from our affordable data packages and pay securely with M-Pesa</p>
                    </div>

                    <form id="packageForm" action="{$app_url}/portal/select" method="POST">
                        <input type="hidden" name="session_id" value="{$session_id}">
                        
                        <div class="form-group">
                            <label class="form-label">📦 Select Package</label>
                            <div class="package-grid">
                                {foreach $packages as $package}
                                <div class="package-card" data-package="{$package.id}">
                                    <div class="package-header">
                                        <span class="package-name">{$package.name}</span>
                                        <span class="package-price">KSh {$package.price}</span>
                                    </div>
                                    <div class="package-details">
                                        ⏱️ {$package.duration_hours} hours • 🚀 High Speed
                                        {if $package.description}
                                        <br>💡 {$package.description}
                                        {/if}
                                    </div>
                                </div>
                                {/foreach}
                            </div>
                            <input type="hidden" name="package_id" id="selectedPackage" required>
                        </div>

                        <div class="form-group">
                            <label for="phoneNumber" class="form-label">📞 Phone Number (M-Pesa)</label>
                            <input type="tel" 
                                   name="phone_number" 
                                   id="phoneNumber" 
                                   class="form-input" 
                                   placeholder="0712345678" 
                                   required 
                                   minlength="10" 
                                   maxlength="13">
                            <small style="color: #64748b; font-size: 12px;">Enter your Safaricom number for M-Pesa payment</small>
                        </div>

                        <button type="submit" class="btn btn-primary" id="purchaseBtn">
                            <span id="purchaseBtnText">💳 Pay with M-Pesa</span>
                        </button>
                    </form>
                </div>

                <!-- Voucher Authentication Column -->
                <div class="portal-card">
                    <div class="card-header">
                        <div class="card-icon">🎫</div>
                        <h3 class="card-title">Voucher Authentication</h3>
                        <p class="card-subtitle">Already have a voucher code or payment confirmation? Enter it here</p>
                    </div>

                    <form id="voucherForm" action="{$app_url}/portal/voucher" method="POST">
                        <input type="hidden" name="session_id" value="{$session_id}">
                        
                        <div class="form-group">
                            <label for="voucherCode" class="form-label">🎫 Voucher Code</label>
                            <div class="voucher-input-group">
                                <input type="text" 
                                       name="voucher_code" 
                                       id="voucherCode" 
                                       class="form-input voucher-input" 
                                       placeholder="Enter voucher code"
                                       style="text-transform: uppercase;">
                                <button type="submit" class="voucher-btn">Apply</button>
                            </div>
                        </div>

                        <div class="divider">
                            <span class="divider-text">OR</span>
                        </div>

                        <div class="form-group">
                            <label for="mpesaCode" class="form-label">📲 M-Pesa Receipt Code</label>
                            <input type="text" 
                                   name="mpesa_code" 
                                   id="mpesaCode" 
                                   class="form-input" 
                                   placeholder="e.g., TGD8SFSLO2"
                                   style="text-transform: uppercase;">
                            <small style="color: #64748b; font-size: 12px;">If your M-Pesa payment succeeded but you're not online</small>
                        </div>

                        <button type="submit" class="btn btn-secondary" id="voucherBtn">
                            <span id="voucherBtnText">🔓 Authenticate</span>
                        </button>
                    </form>

                    <div class="divider">
                        <span class="divider-text">Need Help?</span>
                    </div>

                    <div style="text-align: center; color: #64748b; font-size: 14px;">
                        <p>✅ Payment successful but no internet?<br>
                        📧 Contact: <strong>support@glintaafrica.com</strong><br>
                        📞 Call: <strong>0711311897</strong></p>
                    </div>
                </div>
            </div>

            <!-- Help Section -->
            <div class="help-section">
                <h4 class="help-title">
                    <span>💡</span>
                    Frequently Asked Questions
                </h4>
                <div class="help-content">
                    <p><strong>Q: What happens after I pay with M-Pesa?</strong><br>
                    A: You'll receive an STK push notification. After successful payment, internet access is activated automatically within 30 seconds.</p>
                    
                    <p><strong>Q: My payment was successful but I can't browse?</strong><br>
                    A: Use your M-Pesa receipt code in the "Voucher Authentication" section above, or contact our support team.</p>
                    
                    <p><strong>Q: How long does my package last?</strong><br>
                    A: Each package has a specific duration (shown in hours). Your access expires automatically when the time is up.</p>
                </div>
                
                <div class="help-contact">
                    <strong>🚨 Need Immediate Help?</strong><br>
                    WhatsApp: <strong>0711311897</strong> | Email: <strong>support@glintaafrica.com</strong>
                </div>
            </div>
        </div>
    </main>

    <!-- Scripts -->
    <script src="{$app_url}/ui/ui/scripts/sweetalert2.all.min.js"></script>
    
    <script>
        // Hide loading screen
        window.addEventListener('load', function() {
            setTimeout(function() {
                document.getElementById('loadingOverlay').classList.add('fade-out');
            }, 1000);
        });

        // Package selection
        document.querySelectorAll('.package-card').forEach(card => {
            card.addEventListener('click', function() {
                // Remove previous selection
                document.querySelectorAll('.package-card').forEach(c => c.classList.remove('selected'));
                
                // Add selection to clicked card
                this.classList.add('selected');
                
                // Set hidden input value
                document.getElementById('selectedPackage').value = this.dataset.package;
            });
        });

        // Package form submission
        document.getElementById('packageForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const packageId = document.getElementById('selectedPackage').value;
            const phoneNumber = document.getElementById('phoneNumber').value;
            
            if (!packageId) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Select Package',
                    text: 'Please select a WiFi package first',
                    confirmButtonColor: '#006B3F'
                });
                return;
            }
            
            if (phoneNumber.length < 10) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Phone Number',
                    text: 'Please enter a valid phone number (minimum 10 digits)',
                    confirmButtonColor: '#006B3F'
                });
                return;
            }
            
            // Show loading state
            const btn = document.getElementById('purchaseBtn');
            const btnText = document.getElementById('purchaseBtnText');
            btn.classList.add('loading');
            btnText.innerHTML = '<span class="spinner"></span>Sending request...';
            
            // Show M-Pesa PIN message
            Swal.fire({
                icon: 'info',
                title: 'M-Pesa Payment Request Sent!',
                html: '<p><strong>📱 Check your phone now!</strong></p><p>You will receive an M-Pesa message.<br>Enter your M-Pesa PIN to approve the payment.</p>',
                confirmButtonText: 'OK, I understand',
                confirmButtonColor: '#006B3F',
                allowOutsideClick: false,
                didClose: () => {
                    // Submit form after user acknowledges
                    document.getElementById('packageForm').submit();
                }
            });
        });

        // Voucher form submission
        document.getElementById('voucherForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const voucherCode = document.getElementById('voucherCode').value.trim();
            const mpesaCode = document.getElementById('mpesaCode').value.trim();
            
            if (!voucherCode && !mpesaCode) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Enter Code',
                    text: 'Please enter either a voucher code or M-Pesa receipt code',
                    confirmButtonColor: '#1e3a8a'
                });
                return;
            }
            
            // Show loading state
            const btn = document.getElementById('voucherBtn');
            const btnText = document.getElementById('voucherBtnText');
            btn.classList.add('loading');
            btnText.innerHTML = '<span class="spinner"></span>Authenticating...';
            
            // Submit form
            this.submit();
        });

        // Auto-format phone number (less strict)
        document.getElementById('phoneNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            
            // Just keep numbers, don't auto-convert format
            e.target.value = value;
        });

        // Auto-format voucher and M-Pesa codes
        document.getElementById('voucherCode').addEventListener('input', function(e) {
            e.target.value = e.target.value.toUpperCase();
        });
        
        document.getElementById('mpesaCode').addEventListener('input', function(e) {
            e.target.value = e.target.value.toUpperCase();
        });

        // Handle alerts from URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const status = urlParams.get('status');
        const message = urlParams.get('message');
        
        if (status && message) {
            const icon = status === 's' ? 'success' : 'error';
            const title = status === 's' ? 'Success!' : 'Error';
            
            Swal.fire({
                icon: icon,
                title: title,
                text: decodeURIComponent(message),
                confirmButtonColor: status === 's' ? '#006B3F' : '#CE1126'
            });
            
            // Clean URL
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    </script>
</body>
</html>