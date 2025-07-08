<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Connection Status - Glinta Africa</title>
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
        .status-container {
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
        .status-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        .status-icon.success {
            color: #28a745;
        }
        .status-icon.pending {
            color: #ffc107;
        }
        .status-icon.failed {
            color: #dc3545;
        }
        .status-title {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 10px;
        }
        .status-title.success {
            color: #28a745;
        }
        .status-title.pending {
            color: #ffc107;
        }
        .status-title.failed {
            color: #dc3545;
        }
        .package-info {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
        .package-name {
            font-size: 18px;
            font-weight: 500;
            color: #333;
            margin-bottom: 10px;
        }
        .package-price {
            font-size: 24px;
            font-weight: bold;
            color: #FFD700;
            margin-bottom: 10px;
        }
        .connection-info {
            background: #e3f2fd;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .connection-info h5 {
            color: #1976d2;
            margin-bottom: 15px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 5px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .info-label {
            font-weight: 500;
            color: #666;
        }
        .info-value {
            font-weight: 500;
            color: #333;
        }
        .time-remaining {
            font-size: 20px;
            font-weight: bold;
            color: #FFD700;
            margin: 20px 0;
        }
        .progress-bar {
            background: #e9ecef;
            border-radius: 10px;
            height: 10px;
            overflow: hidden;
            margin-bottom: 20px;
        }
        .progress-fill {
            background: linear-gradient(45deg, #FFD700, #FFA500);
            height: 100%;
            transition: width 0.3s ease;
        }
        .action-btn {
            background: linear-gradient(45deg, #FFD700, #FFA500);
            border: none;
            color: white;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 10px;
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255,215,0,0.4);
        }
        .action-btn.secondary {
            background: #6c757d;
        }
        .action-btn.secondary:hover {
            background: #5a6268;
            box-shadow: 0 5px 15px rgba(108,117,125,0.4);
        }
        .instructions {
            background: #d4edda;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .instructions h5 {
            color: #155724;
            margin-bottom: 15px;
        }
        .instructions ul {
            text-align: left;
            color: #155724;
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <div class="status-container">
        <div class="brand-title">Glinta Africa</div>
        
        {if $session->payment_status == 'completed'}
            <div class="status-icon success">✅</div>
            <div class="status-title success">Payment Successful!</div>
            <div class="status-title">Internet Connected</div>
            
            <div class="package-info">
                <div class="package-name">{$package->name}</div>
                <div class="package-price">KSh {$package->price}</div>
            </div>
            
            <div class="connection-info">
                <h5>🌐 Connection Details</h5>
                <div class="info-row">
                    <span class="info-label">Status:</span>
                    <span class="info-value" style="color: #28a745;">Active</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Duration:</span>
                    <span class="info-value">{$package->duration_hours} hours</span>
                </div>
                {if $package->data_limit_mb}
                <div class="info-row">
                    <span class="info-label">Data Limit:</span>
                    <span class="info-value">{($package->data_limit_mb/1024)|number_format:1}GB</span>
                </div>
                {/if}
                <div class="info-row">
                    <span class="info-label">Expires:</span>
                    <span class="info-value">{$session->expires_at|date_format:"%Y-%m-%d %H:%M"}</span>
                </div>
                {if $session->mikrotik_user}
                <div class="info-row">
                    <span class="info-label">Username:</span>
                    <span class="info-value">{$session->mikrotik_user}</span>
                </div>
                {/if}
            </div>
            
            <div class="instructions">
                <h5>🎉 You're Connected!</h5>
                <ul>
                    <li>Your internet access is now active</li>
                    <li>You can close this page and browse freely</li>
                    <li>Connection will expire automatically</li>
                    <li>Save this page for connection details</li>
                </ul>
            </div>
            
            <button class="action-btn" onclick="window.close()">
                🌐 Start Browsing
            </button>
            
        {elseif $session->payment_status == 'failed'}
            <div class="status-icon failed">❌</div>
            <div class="status-title failed">Payment Failed</div>
            
            <div class="package-info">
                <div class="package-name">{$package->name}</div>
                <div class="package-price">KSh {$package->price}</div>
            </div>
            
            <div style="background: #f8d7da; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
                <h5 style="color: #721c24;">Payment could not be processed</h5>
                <p style="color: #721c24; margin-bottom: 0;">
                    Please try again or contact support if the problem persists.
                </p>
            </div>
            
            <button class="action-btn" onclick="window.location.href='{$app_url}/?_route=portal/login'">
                🔄 Try Again
            </button>
            
        {else}
            <div class="status-icon pending">⏳</div>
            <div class="status-title pending">Processing Payment...</div>
            
            <div class="package-info">
                <div class="package-name">{$package->name}</div>
                <div class="package-price">KSh {$package->price}</div>
            </div>
            
            <div style="background: #fff3cd; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
                <h5 style="color: #856404;">⏳ Waiting for Payment</h5>
                <p style="color: #856404; margin-bottom: 0;">
                    Please complete the M-Pesa payment on your phone.
                </p>
            </div>
            
            <button class="action-btn" onclick="window.location.reload()">
                🔄 Check Status
            </button>
            <button class="action-btn secondary" onclick="window.history.back()">
                ← Back
            </button>
        {/if}
        
        <div style="margin-top: 30px;">
            <small style="color: #666;">
                Session ID: {$session->session_id|substr:0:12}...<br>
                Need help? Contact Glinta Africa Support
            </small>
        </div>
    </div>
    
    {if $session->payment_status == 'pending'}
    <script>
        // Auto-refresh every 5 seconds for pending payments
        setTimeout(function() {
            window.location.reload();
        }, 5000);
    </script>
    {/if}
</body>
</html>