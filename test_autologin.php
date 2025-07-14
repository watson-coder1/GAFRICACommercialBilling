<?php
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/autoload/HotspotAutoLogin.php';

$session = ORM::for_table('tbl_portal_sessions')
    ->where('payment_status', 'completed')
    ->where_null('mikrotik_user')
    ->order_by_desc('id')
    ->find_one();

if (!$session) {
    echo "❌ No pending sessions found\n";
    exit;
}

echo "Testing auto-login for MAC: {$session->mac_address}, Phone: {$session->phone_number}\n";

$package = ORM::for_table('tbl_hotspot_packages')
    ->where('id', $session->package_id)
    ->find_one();

if (!$package) {
    echo "❌ Package not found\n";
    exit;
}

$result = HotspotAutoLogin::createAndLogin($session, $package);

if ($result) {
    echo "✅ Auto-login successful\n";
} else {
    echo "❌ Auto-login failed\n";
}
