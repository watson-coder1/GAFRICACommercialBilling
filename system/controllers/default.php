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
        $ui->assign('_title', 'Glinta Africa - Hotspot Billing Solutions');
        $ui->assign('_c', $config);
        $ui->assign('app_url', APP_URL);
        $ui->assign('logged_in_admin', false);
        $ui->assign('logged_in_customer', false);
        $ui->display('landing.tpl');
        return;
    }
}
include($root_path . File::pathFixer('system/controllers/' . $handler . '.php'));