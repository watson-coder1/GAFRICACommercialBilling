<?php
/**
 * Install Dashboard Widgets Script
 * Adds new PPPoE and Hotspot widgets to the dashboard
 */

// Bootstrap the application
require_once 'system/vendor/autoload.php';
require_once 'system/boot.php';

echo "=== INSTALLING DASHBOARD WIDGETS ===\n\n";

// Widget configurations
$widgets = [
    [
        'widget' => 'pppoe_clients_status',
        'title' => 'PPPoE Clients Status',
        'orders' => 2,
        'position' => 1,
        'user' => 'Admin',
        'enabled' => 1
    ],
    [
        'widget' => 'hotspot_clients_status',
        'title' => 'Hotspot Clients Status',
        'orders' => 3,
        'position' => 1,
        'user' => 'Admin',
        'enabled' => 1
    ],
    [
        'widget' => 'service_type_statistics',
        'title' => 'Service Type Statistics',
        'orders' => 4,
        'position' => 1,
        'user' => 'Admin',
        'enabled' => 1
    ]
];

$installed = 0;
$skipped = 0;

foreach ($widgets as $widget) {
    // Check if widget already exists
    $existing = ORM::for_table('tbl_widgets')
        ->where('widget', $widget['widget'])
        ->where('user', $widget['user'])
        ->find_one();
    
    if ($existing) {
        echo "- Widget '{$widget['title']}' already exists, skipping...\n";
        $skipped++;
        continue;
    }
    
    // Install the widget
    $newWidget = ORM::for_table('tbl_widgets')->create();
    $newWidget->widget = $widget['widget'];
    $newWidget->title = $widget['title'];
    $newWidget->orders = $widget['orders'];
    $newWidget->position = $widget['position'];
    $newWidget->user = $widget['user'];
    $newWidget->enabled = $widget['enabled'];
    $newWidget->save();
    
    echo "✓ Installed widget '{$widget['title']}' (ID: {$newWidget->id})\n";
    $installed++;
}

echo "\n=== INSTALLATION COMPLETE ===\n";
echo "- Installed: $installed widgets\n";
echo "- Skipped: $skipped widgets\n";

if ($installed > 0) {
    echo "\nNew widgets have been added to your dashboard!\n";
    echo "Go to your admin dashboard to see the new PPPoE and Hotspot client status widgets.\n";
    echo "\nWidgets installed:\n";
    echo "1. PPPoE Clients Status - Shows online/offline/expired PPPoE clients\n";
    echo "2. Hotspot Clients Status - Shows online/offline/expired/logged out hotspot clients\n";
    echo "3. Service Type Statistics - Comparison between PPPoE and Hotspot services\n";
    echo "\nYou can manage widget positions and order in the admin panel.\n";
} else {
    echo "\nNo new widgets were installed. All widgets already exist.\n";
}

echo "\nScript completed.\n";
?>