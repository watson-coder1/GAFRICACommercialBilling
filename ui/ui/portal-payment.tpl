<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Payment - Glinta Africa</title>
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        .payment-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 500px;
            width: 90%;
            text-align: center;
        }
        .brand-title {
            font-family: 'Lobster', cursive;
            color: #FFD700;
            font-size: 32px;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        .payment-icon {
            font-size: 64px;
            color: #28a745;
            margin-bottom: 20px;
        }
        .package-summary {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
        .package-name {
            font-size: 20px;
            font-weight: 500;
            color: #333;
            margin-bottom: 10px;
        }
        .package-price {
            font-size: 32px;
            font-weight: bold;
            color: #FFD700;
            margin-bottom: 10px;
        }
        .package-details {
            color: #666;
            margin-bottom: 15px;
        }
        .phone-number {
            font-size: 18px;
            font-weight: 500;
            color: #333;
            margin-bottom: 20px;
        }
        .payment-status {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .status-pending {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
        }
        .status-success {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        .status-failed {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        .instructions {
            background: #e3f2fd;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .instructions h5 {
            color: #1976d2;
            margin-bottom: 15px;
        }
        .instructions ol {
            text-align: left;
            color: #666;
            margin-bottom: 0;
        }
        .refresh-btn {
            background: linear-gradient(45deg, #FFD700, #FFA500);
            border: none;
            color: white;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-right: 10px;
        }
        .refresh-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255,215,0,0.4);
        }
        .back-btn {
            background: #6c757d;
            border: none;
            color: white;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .back-btn:hover {
            background: #5a6268;
        }
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #FFD700;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .mpesa-logo {
            width: 100px;
            height: auto;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <div class="brand-title">Glinta Africa</div>
        
        <div class="payment-icon">📱</div>
        
        <div class="package-summary">
            <div class="package-name">{$package->name}</div>
            <div class="package-price">KSh {$package->price}</div>
            <div class="package-details">
                {$package->duration_hours} hours
                {if $package->data_limit_mb}
                    • {($package->data_limit_mb/1024)|number_format:1}GB data
                {/if}
            </div>
            <div class="phone-number">📞 {$session->phone_number}</div>
        </div>
        
        <div class="payment-status status-pending">
            <div class="loading-spinner"></div>
            Waiting for M-Pesa payment...
        </div>
        
        <div class="instructions">
            <h5>📱 Complete Payment via M-Pesa</h5>
            <ol>
                <li>Check your phone for M-Pesa payment request</li>
                <li>Enter your M-Pesa PIN to confirm payment</li>
                <li>Wait for confirmation message</li>
                <li>You'll be connected automatically</li>
            </ol>
        </div>
        
        <div style="margin-top: 30px;">
            <button class="refresh-btn" onclick="window.location.reload()">
                🔄 Check Status
            </button>
            <button class="back-btn" onclick="window.history.back()">
                ← Back
            </button>
        </div>
        
        <div style="margin-top: 20px;">
            <small style="color: #666;">
                Transaction ID: {$transaction->transaction_id|substr:0:12}...<br>
                Need help? Contact support
            </small>
        </div>
    </div>
    
    <script>
        // Auto-refresh every 10 seconds to check payment status
        let refreshInterval = setInterval(function() {
            fetch('{$app_url}/?_route=portal/status/{$session->session_id}')
                .then(response => response.text())
                .then(data => {
                    if (data.includes('Payment Successful') || data.includes('status-success')) {
                        window.location.href = '{$app_url}/?_route=portal/status/{$session->session_id}';
                    }
                })
                .catch(error => console.log('Status check error:', error));
        }, 10000);
        
        // Clear interval after 5 minutes
        setTimeout(function() {
            clearInterval(refreshInterval);
        }, 300000);
    </script>
</body>
</html>