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
        // Handle different landing page routes
        // Only handle direct landing page requests, not order/application routes
        $page = isset($routes[0]) ? $routes[0] : 'home';
        
        // If this is a multi-segment route (like order/gateway/hotspot), let the normal routing handle it
        if (count($routes) > 1 && in_array($routes[0], ['order', 'gateway', 'admin', 'api'])) {
            $handler = 'login';
        } else {
            switch($page) {
            case 'home':
            case '':
                $template = 'landing-home.tpl';
                $title = 'Glinta Africa - Internet Billing Solutions';
                break;
            case 'services':
                $template = 'landing-services.tpl';
                $title = 'Our Services - Glinta Africa';
                break;
            case 'features':
                $template = 'landing-features.tpl';
                $title = 'Features - Glinta Africa';
                break;
            case 'pricing':
                $template = 'landing-pricing.tpl';
                $title = 'Pricing - Glinta Africa';
                break;
            case 'about':
                $template = 'landing-about.tpl';
                $title = 'About Us - Glinta Africa';
                break;
            case 'contact':
                $template = 'landing-contact.tpl';
                $title = 'Contact Us - Glinta Africa';
                break;
            case 'blog':
                $template = 'landing-blog.tpl';
                $title = 'Blog - Glinta Africa';
                break;
            case 'privacy':
                $template = 'landing-privacy.tpl';
                $title = 'Privacy Policy - Glinta Africa';
                break;
            case 'terms':
                $template = 'landing-terms.tpl';
                $title = 'Terms of Service - Glinta Africa';
                break;
            case 'security':
                $template = 'landing-security.tpl';
                $title = 'Security - Glinta Africa';
                break;
            case 'compliance':
                $template = 'landing-compliance.tpl';
                $title = 'Compliance - Glinta Africa';
                break;
            case 'help':
                $template = 'landing-help.tpl';
                $title = 'Help Center - Glinta Africa';
                break;
            case 'documentation':
                $template = 'landing-documentation.tpl';
                $title = 'Documentation - Glinta Africa';
                break;
            case 'community':
                $template = 'landing-community.tpl';
                $title = 'Community Forum - Glinta Africa';
                break;
            case 'hotspot':
                $template = 'landing-hotspot.tpl';
                $title = 'Hotspot Solutions - Glinta Africa';
                break;
            case 'pppoe':
                $template = 'landing-pppoe.tpl';
                $title = 'PPPoE Management - Glinta Africa';
                break;
            case 'billing':
                $template = 'landing-billing.tpl';
                $title = 'Billing Platform - Glinta Africa';
                break;
            case 'analytics':
                $template = 'landing-analytics.tpl';
                $title = 'Analytics Suite - Glinta Africa';
                break;
            case 'careers':
                $template = 'landing-careers.tpl';
                $title = 'Careers - Glinta Africa';
                break;
            case 'news':
                $template = 'landing-news.tpl';
                $title = 'News & Press - Glinta Africa';
                break;
            case 'investors':
                $template = 'landing-investors.tpl';
                $title = 'Investor Relations - Glinta Africa';
                break;
            case 'demo-reseller':
                // Redirect directly to admin page
                r2(APP_URL . '/admin');
                break;
            case 'demo-customer':
                // Redirect to customer login page
                r2(APP_URL . '/login');
                break;
            default:
                $template = 'landing-home.tpl';
                $title = 'Glinta Africa - Internet Billing Solutions';
                break;
        }
        }
        
        // Blog article routing
        if($page == 'blog' && isset($routes[1])) {
            $article = $routes[1];
            $template = 'landing-blog-article.tpl';
            $title = 'Blog Article - Glinta Africa';
            $ui->assign('article', $article);
        }
        
        // Show the appropriate template
        try {
            // Check if template file exists
            if (!file_exists($root_path . '/ui/ui/' . $template)) {
                // Template doesn't exist, use landing-final.tpl as fallback
                $template = 'landing-final.tpl';
                $title = 'Glinta Africa - Internet Billing Solutions';
            }
            
            $ui->assign('_title', $title);
            $ui->assign('_c', $config);
            $ui->assign('app_url', APP_URL);
            $ui->assign('logged_in_admin', false);
            $ui->assign('logged_in_customer', false);
            $ui->assign('current_page', $page);
            $ui->display($template);
            return;
        } catch (Exception $e) {
            // Log the error for debugging
            error_log("Landing page template error: " . $e->getMessage());
            
            // Fallback to main landing page
            $ui->assign('_title', 'Glinta Africa - Internet Billing Solutions');
            $ui->assign('_c', $config);
            $ui->assign('app_url', APP_URL);
            $ui->assign('logged_in_admin', false);
            $ui->assign('logged_in_customer', false);
            $ui->assign('current_page', 'home');
            $ui->display('landing-final.tpl');
            return;
        }
    }
}
include($root_path . File::pathFixer('system/controllers/' . $handler . '.php'));