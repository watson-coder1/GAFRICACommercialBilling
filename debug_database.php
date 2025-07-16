<?php
require_once 'config.php';
require_once 'system/orm.php';

echo "=== Database Debug ===\n\n";

// Check routers
echo "1. ROUTERS:\n";
$routers = ORM::for_table('tbl_routers')->find_many();
foreach ($routers as $router) {
    echo "- {$router->name}: {$router->ip_address} (enabled: {$router->enabled})\n";
}

echo "\n2. USER RECHARGES (Active/Expired):\n";
$recharges = ORM::for_table('tbl_user_recharges')->limit(10)->find_many();
echo "Total recharges: " . count($recharges) . "\n";
foreach ($recharges as $r) {
    $expired = strtotime($r->expiration . ' ' . $r->time) <= time();
    echo "- {$r->username}: {$r->type}, expires {$r->expiration} {$r->time}, status: {$r->status}, expired: " . ($expired ? 'YES' : 'NO') . "\n";
}

echo "\n3. ACTIVE PLANS QUERY:\n";
$active = ORM::for_table('tbl_user_recharges')
    ->where('type', 'Hotspot')
    ->where('status', 'on')
    ->where_raw("CONCAT(expiration, ' ', time) > NOW()")
    ->count();
echo "Active Hotspot plans: $active\n";

$expired = ORM::for_table('tbl_user_recharges')
    ->where('type', 'Hotspot')
    ->where('status', 'on')
    ->where_raw("CONCAT(expiration, ' ', time) <= NOW()")
    ->count();
echo "Expired Hotspot plans: $expired\n";

echo "\n4. CUSTOMERS:\n";
$customers = ORM::for_table('tbl_customers')->limit(5)->find_many();
foreach ($customers as $c) {
    echo "- {$c->username}: {$c->service_type}\n";
}
?>