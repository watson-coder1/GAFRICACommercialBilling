<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Glinta Africa - WiFi Packages</title>
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/sweetalert2.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 10px;
            overflow-x: hidden;
        }
        .portal-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            padding: 20px;
            max-width: 450px;
            width: 100%;
            margin: 20px auto;
            max-height: 95vh;
            overflow-y: auto;
        }
        
        @media (max-width: 768px) {
            .portal-container {
                padding: 15px;
                border-radius: 15px;
                margin: 10px auto;
                max-height: 98vh;
            }
        }
        .brand-title {
            font-family: 'Lobster', cursive;
            color: #FFD700;
            font-size: 32px;
            text-align: center;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
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
        }
        
        @media (max-width: 768px) {
            .package-card {
                padding: 12px;
                margin-bottom: 10px;
                border-radius: 12px;
            }
        }
        .package-card:hover {
            border-color: #FFD700;
            box-shadow: 0 5px 15px rgba(255,215,0,0.3);
        }
        .package-card.selected {
            border-color: #FFD700;
            background: #fffbf0;
        }
        .package-name {
            font-size: 18px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        .package-price {
            font-size: 24px;
            font-weight: bold;
            color: #FFD700;
            margin-bottom: 8px;
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
            background: linear-gradient(45deg, #FFD700, #FFA500);
            border: none;
            color: white;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 10px;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .continue-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255,215,0,0.4);
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
    <div class="portal-container">
        <div class="brand-title">Glinta Africa</div>
        <div class="subtitle">Choose Your WiFi Package</div>
        
        <div class="wifi-info">
            <small>
                <strong>Device:</strong> {$mac|default:"Unknown"}<br>
                <strong>IP:</strong> {$ip|default:"Unknown"}
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
                <input type="tel" name="phone_number" placeholder="Enter your phone number (e.g., 0712345678)" 
                       pattern="^(254|0)[17]\d{8}$" required>
                <small class="form-text text-muted">Format: 0712345678 or 254712345678</small>
            </div>
            
            <button type="submit" class="continue-btn" disabled>
                Continue to Payment
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
            
            packageCards.forEach(card => {
                card.addEventListener('click', function() {
                    // Remove selected class from all cards
                    packageCards.forEach(c => c.classList.remove('selected'));
                    
                    // Add selected class to clicked card
                    this.classList.add('selected');
                    
                    // Set package ID
                    packageIdInput.value = this.dataset.packageId;
                    
                    // Enable continue button if phone number is entered
                    checkFormValid();
                });
            });
            
            phoneInput.addEventListener('input', checkFormValid);
            
            function checkFormValid() {
                const hasPackage = packageIdInput.value !== '';
                const hasPhone = phoneInput.value.trim() !== '';
                continueBtn.disabled = !(hasPackage && hasPhone);
            }
        });
    </script>
</body>
</html>