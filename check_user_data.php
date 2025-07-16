<?php
require_once 'config.php';
require_once 'system/orm.php';

echo "=== User Data Check ===\n\n";

// Check total user recharges
$total_recharges = ORM::for_table('tbl_user_recharges')->count();
echo "Total user recharges: $total_recharges\n";

if ($total_recharges > 0) {
    // Show sample recharges
    $sample_recharges = ORM::for_table('tbl_user_recharges')->limit(5)->find_many();
    echo "\nSample recharges:\n";
    foreach ($sample_recharges as $r) {
        $expiry_time = $r->expiration . ' ' . $r->time;
        $is_expired = strtotime($expiry_time) <= time();
        echo "- User: {$r->username}\n";
        echo "  Type: {$r->type}\n";
        echo "  Status: {$r->status}\n";
        echo "  Expires: {$expiry_time}\n";
        echo "  Expired: " . ($is_expired ? 'YES' : 'NO') . "\n";
        echo "  Router: {$r->routers}\n\n";
    }
}

// Check total customers
$total_customers = ORM::for_table('tbl_customers')->count();
echo "Total customers: $total_customers\n";

// Check transactions
$total_transactions = ORM::for_table('tbl_transactions')->count();
echo "Total transactions: $total_transactions\n";

// Check routers
$routers = ORM::for_table('tbl_routers')->find_many();
echo "\nRouters in database:\n";
foreach ($routers as $router) {
    echo "- {$router->name}: {$router->ip_address} (enabled: {$router->enabled})\n";
}

// Test the actual queries from the widget
echo "\n=== Testing Widget Queries ===\n";

$hotspot_active = ORM::for_table('tbl_user_recharges')
    ->where('type', 'Hotspot')
    ->where('status', 'on')
    ->where_raw("CONCAT(expiration, ' ', time) > NOW()")
    ->count();
echo "Active Hotspot plans: $hotspot_active\n";

$hotspot_expired = ORM::for_table('tbl_user_recharges')
    ->where('type', 'Hotspot')
    ->where('status', 'on')
    ->where_raw("CONCAT(expiration, ' ', time) <= NOW()")
    ->count();
echo "Expired Hotspot plans: $hotspot_expired\n";

echo "\nDone.\n";
?>