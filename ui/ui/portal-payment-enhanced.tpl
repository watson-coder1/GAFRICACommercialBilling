<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Processing Payment - Glinta Africa</title>
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
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
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .payment-container {
            background: var(--kenya-white);
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
            padding: 50px 40px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            position: relative;
        }
        
        .brand-header {
            margin-bottom: 30px;
        }
        
        .brand-title {
            font-family: 'Lobster', cursive;
            font-size: 32px;
            color: var(--glinta-gold);
            margin-bottom: 5px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .brand-subtitle {
            font-size: 14px;
            color: var(--kenya-green);
            font-weight: 500;
        }
        
        .payment-status {
            margin-bottom: 30px;
        }
        
        .payment-icon {
            font-size: 80px;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        .payment-icon.processing {
            color: #ffc107;
        }
        
        .payment-icon.success {
            color: var(--kenya-green);
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.8;
            }
        }
        
        .payment-title {
            font-size: 28px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
        }
        
        .payment-message {
            font-size: 16px;
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .package-summary {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border-left: 5px solid var(--kenya-green);
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
            grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
            gap: 15px;
            text-align: center;
        }
        
        .package-detail {
            padding: 12px;
            background: var(--kenya-white);
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .detail-value {
            font-size: 18px;
            font-weight: 700;
            color: var(--kenya-green);
        }
        
        .detail-label {
            font-size: 11px;
            color: #64748b;
            margin-top: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .payment-steps {
            background: #f8fafc;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .steps-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
        }
        
        .step {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 10px 0;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .step:last-child {
            border-bottom: none;
        }
        
        .step-number {
            width: 30px;
            height: 30px;
            background: var(--kenya-green);
            color: var(--kenya-white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: bold;
            flex-shrink: 0;
        }
        
        .step-text {
            font-size: 14px;
            color: #64748b;
            text-align: left;
        }
        
        .loading-indicator {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin: 30px 0;
        }
        
        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #e2e8f0;
            border-top: 4px solid var(--kenya-green);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .loading-text {
            font-size: 16px;
            color: var(--kenya-green);
            font-weight: 500;
        }
        
        .status-message {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            border-left: 4px solid #3b82f6;
        }
        
        .status-message.success {
            background: linear-gradient(135deg, #dcfce7, #bbf7d0);
            border-left-color: var(--kenya-green);
        }
        
        .status-message.error {
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            border-left-color: var(--kenya-red);
        }
        
        .countdown {
            font-size: 18px;
            font-weight: 600;
            color: var(--kenya-green);
            margin: 20px 0;
        }
        
        .help-section {
            background: #f8fafc;
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
            text-align: left;
        }
        
        .help-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--kenya-black);
            margin-bottom: 15px;
            text-align: center;
        }
        
        .help-content {
            font-size: 14px;
            color: #64748b;
            line-height: 1.6;
        }
        
        .contact-info {
            background: var(--kenya-white);
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
            text-align: center;
        }
        
        .contact-item {
            font-size: 13px;
            color: var(--kenya-green);
            font-weight: 500;
            margin: 5px 0;
        }
        
        @media (max-width: 768px) {
            .payment-container {
                padding: 40px 25px;
                margin: 10px;
            }
            
            .payment-icon {
                font-size: 60px;
            }
            
            .brand-title {
                font-size: 26px;
            }
            
            .payment-title {
                font-size: 24px;
            }
            
            .package-details {
                grid-template-columns: 1fr 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <div class="brand-header">
            <h1 class="brand-title">Glinta Africa</h1>
            <p class="brand-subtitle">Premium WiFi Solutions</p>
        </div>
        
        <div class="payment-status" id="paymentStatus">
            <div class="payment-icon processing" id="paymentIcon">📱</div>
            <h2 class="payment-title" id="paymentTitle">Processing Payment</h2>
            <p class="payment-message" id="paymentMessage">
                Please check your phone for the M-Pesa payment request and enter your PIN to complete the transaction.
            </p>
        </div>
        
        {if $package}
        <div class="package-summary">
            <div class="package-header">
                <span>📦</span>
                <span>Package: {$package->name}</span>
            </div>
            <div class="package-details">
                <div class="package-detail">
                    <div class="detail-value">KSh {$package->price}</div>
                    <div class="detail-label">Amount</div>
                </div>
                <div class="package-detail">
                    <div class="detail-value">{$package->duration_hours}hrs</div>
                    <div class="detail-label">Duration</div>
                </div>
                <div class="package-detail">
                    <div class="detail-value">🚀</div>
                    <div class="detail-label">High Speed</div>
                </div>
            </div>
        </div>
        {/if}
        
        <div class="payment-steps">
            <div class="steps-title">📋 Payment Process</div>
            <div class="step">
                <div class="step-number">1</div>
                <div class="step-text">Check your phone for M-Pesa STK push notification</div>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <div class="step-text">Enter your M-Pesa PIN to authorize payment</div>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <div class="step-text">Wait for confirmation and automatic internet activation</div>
            </div>
        </div>
        
        <div class="loading-indicator" id="loadingIndicator">
            <div class="spinner"></div>
            <div class="loading-text">Waiting for payment confirmation...</div>
        </div>
        
        <div class="status-message" id="statusMessage" style="display: none;">
            <div id="statusText"></div>
        </div>
        
        <div class="countdown" id="countdown" style="display: none;">
            Redirecting in <span id="countdownNumber">5</span> seconds...
        </div>
        
        <div class="help-section">
            <div class="help-title">❓ Need Help?</div>
            <div class="help-content">
                <p><strong>Payment not working?</strong></p>
                <ul style="margin: 10px 0; padding-left: 20px;">
                    <li>Ensure you have sufficient M-Pesa balance</li>
                    <li>Check if your phone number is registered for M-Pesa</li>
                    <li>Try again after a few minutes if STK push fails</li>
                    <li>Contact support if problem persists</li>
                </ul>
                
                <div class="contact-info">
                    <div class="contact-item">📧 support@glintaafrica.com</div>
                    <div class="contact-item">📞 0711311897</div>
                    <div class="contact-item">💬 WhatsApp Support Available</div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Session and transaction IDs from PHP
        const sessionId = '{$session->session_id}';
        const transactionId = '{$transaction->transaction_id}';
        
        // Payment status checking
        let checkCount = 0;
        const maxChecks = 60; // Check for 2 minutes (60 * 2 seconds)
        
        function checkPaymentStatus() {
            checkCount++;
            
            // Make AJAX request to check payment status
            fetch(window.location.origin + '/portal/status/' + sessionId)
                .then(response => response.text())
                .then(html => {
                    // Check if payment is completed by looking for success indicators
                    if (html.includes('payment_status=completed') || 
                        html.includes('✅') || 
                        html.includes('successful')) {
                        
                        // Payment successful
                        showSuccess();
                        setTimeout(() => {
                            window.location.href = window.location.origin + '/portal/success/' + sessionId;
                        }, 3000);
                        return;
                    }
                    
                    // Continue checking if not maxed out
                    if (checkCount < maxChecks) {
                        setTimeout(checkPaymentStatus, 2000); // Check every 2 seconds
                    } else {
                        showTimeout();
                    }
                })
                .catch(error => {
                    console.log('Check failed:', error);
                    if (checkCount < maxChecks) {
                        setTimeout(checkPaymentStatus, 3000); // Wait longer on error
                    } else {
                        showTimeout();
                    }
                });
        }
        
        function showSuccess() {
            const icon = document.getElementById('paymentIcon');
            const title = document.getElementById('paymentTitle');
            const message = document.getElementById('paymentMessage');
            const loading = document.getElementById('loadingIndicator');
            const statusMsg = document.getElementById('statusMessage');
            const statusText = document.getElementById('statusText');
            const countdown = document.getElementById('countdown');
            
            // Update UI to show success
            icon.textContent = '✅';
            icon.className = 'payment-icon success';
            title.textContent = 'Payment Successful!';
            message.textContent = 'Your payment has been processed and internet access is now active.';
            
            loading.style.display = 'none';
            statusMsg.style.display = 'block';
            statusMsg.className = 'status-message success';
            statusText.innerHTML = '🎉 <strong>Success!</strong> You now have internet access. Redirecting to welcome page...';
            
            // Show countdown
            countdown.style.display = 'block';
            let count = 5;
            const countdownInterval = setInterval(() => {
                count--;
                document.getElementById('countdownNumber').textContent = count;
                if (count <= 0) {
                    clearInterval(countdownInterval);
                }
            }, 1000);
        }
        
        function showTimeout() {
            const loading = document.getElementById('loadingIndicator');
            const statusMsg = document.getElementById('statusMessage');
            const statusText = document.getElementById('statusText');
            
            loading.style.display = 'none';
            statusMsg.style.display = 'block';
            statusMsg.className = 'status-message error';
            statusText.innerHTML = '⏰ <strong>Payment check timeout.</strong> If you completed the payment, you can use your M-Pesa receipt code on the main portal page to get access.';
        }
        
        // Start checking payment status after page loads
        setTimeout(checkPaymentStatus, 3000); // Start checking after 3 seconds
        
        // Also check on page focus (when user returns to page)
        window.addEventListener('focus', function() {
            if (checkCount < maxChecks) {
                checkPaymentStatus();
            }
        });
        
        // Update loading text dynamically
        let loadingTexts = [
            'Waiting for payment confirmation...',
            'Processing your M-Pesa payment...',
            'Activating your internet access...',
            'Almost ready, please wait...'
        ];
        
        let textIndex = 0;
        setInterval(() => {
            const loadingText = document.querySelector('.loading-text');
            if (loadingText && checkCount < maxChecks) {
                textIndex = (textIndex + 1) % loadingTexts.length;
                loadingText.textContent = loadingTexts[textIndex];
            }
        }, 3000);
    </script>
</body>
</html>