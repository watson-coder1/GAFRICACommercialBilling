<?php
/**
 *  PHP Mikrotik Billing (https://github.com/hotspotbilling/phpnuxbill/)
 *  by https://t.me/ibnux
 **/

if(Admin::getID()){
    //r2(getUrl('dashboard'));
    $handler = 'dashboard';
}else if(User::getID()){
    //r2(getUrl('home'));
    $handler = 'home';
}else{
    // Show landing page for unauthenticated users
    // But still route to login if they have MikroTik parameters (captive portal)
    if(!empty($_SESSION['nux-mac']) || !empty($_SESSION['nux-ip']) || !empty($_GET['nux-mac']) || !empty($_GET['nux-ip'])) {
        $handler = 'login';
    } else {
        // Show marketing landing page
        try {
            $ui->assign('_title', 'Glinta Africa - Hotspot Billing Solutions');
            $ui->assign('_c', $config);
            $ui->assign('app_url', APP_URL);
            $ui->assign('logged_in_admin', false);
            $ui->assign('logged_in_customer', false);
            $ui->display('landing-enterprise.tpl');
            return;
        } catch (Exception $e) {
            // Log the error for debugging
            error_log("Landing page template error: " . $e->getMessage());
            
            // If landing page fails, show a simple HTML page
            echo '<!DOCTYPE html>
            <html>
            <head>
                <title>Glinta Africa - Hotspot Billing Solutions</title>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style>
                    body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f5f5f5; }
                    .container { max-width: 800px; margin: 0 auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
                    h1 { color: #FFD700; text-align: center; margin-bottom: 30px; }
                    .btn { background: #FFD700; color: black; padding: 15px 30px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 10px; }
                    .btn:hover { background: #DAA520; }
                    .features { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin: 40px 0; }
                    .feature { padding: 20px; background: #f9f9f9; border-radius: 5px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>GLINTA AFRICA</h1>
                    <h2>Enterprise Hotspot Billing Solutions</h2>
                    <p>Transform your WiFi business with Africa\'s most advanced hotspot billing system. Trusted by ISPs, hotels, cafes, and enterprise networks across the continent.</p>
                    
                    <div style="text-align: center; margin: 30px 0;">
                        <a href="' . APP_URL . '/index.php?_route=admin" class="btn">Admin Demo</a>
                        <a href="' . APP_URL . '/index.php?_route=login" class="btn">Customer Portal</a>
                    </div>
                    
                    <div class="features">
                        <div class="feature">
                            <h3>🌐 Captive Portal</h3>
                            <p>Customizable branded login portal with voucher system and multi-language support.</p>
                        </div>
                        <div class="feature">
                            <h3>👥 Customer Management</h3>
                            <p>Complete CRM system with user profiles, package management, and usage tracking.</p>
                        </div>
                        <div class="feature">
                            <h3>💳 Payment Integration</h3>
                            <p>M-Pesa, Airtel Money, PayPal, and Stripe integration with instant service activation.</p>
                        </div>
                        <div class="feature">
                            <h3>📊 Analytics & Reports</h3>
                            <p>Real-time dashboards, revenue reports, and performance metrics.</p>
                        </div>
                    </div>
                    
                    <div style="background: #f0f0f0; padding: 20px; border-radius: 5px; margin: 20px 0;">
                        <h3>Pricing Plans</h3>
                        <ul>
                            <li><strong>Basic:</strong> KES 1,000/month - 50 users</li>
                            <li><strong>Starter:</strong> KES 2,500/month - 150 users</li>
                            <li><strong>Professional:</strong> KES 5,000/month - 500 users</li>
                            <li><strong>Enterprise:</strong> KES 10,000/month - Unlimited users</li>
                        </ul>
                    </div>
                    
                    <div style="text-align: center; margin: 30px 0;">
                        <p>Contact us: <a href="mailto:info@glintaafrica.com">info@glintaafrica.com</a> | +254 700 123 456</p>
                        <p><small>Made with ❤️ by <a href="https://watsonsdevelopers.com">watsonsdevelopers.com</a></small></p>
                    </div>
                </div>
            </body>
            </html>';
            return;
        }
    }
}
include($root_path . File::pathFixer('system/controllers/' . $handler . '.php'));