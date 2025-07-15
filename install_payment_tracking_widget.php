<?php

/**
 * Install Payment Tracking Widget
 * Adds payment tracking widget to superadmin dashboard
 */

require_once 'init.php';

try {
    // Check if widget already exists
    $existing = ORM::for_table('tbl_widgets')
        ->where('widget', 'payment_tracking')
        ->find_one();
    
    if ($existing) {
        echo "Payment tracking widget already exists. Updating...\n";
        $widget = $existing;
    } else {
        echo "Creating new payment tracking widget...\n";
        $widget = ORM::for_table('tbl_widgets')->create();
    }
    
    // Get highest order number
    $maxOrder = ORM::for_table('tbl_widgets')
        ->where('user', 'Admin')
        ->max('orders') ?: 0;
    
    $widget->title = 'Payment Tracking';
    $widget->widget = 'payment_tracking';
    $widget->icon = 'fa-money';
    $widget->description = 'Track all payments: hotspot users, PPOE, and resellers';
    $widget->user = 'Admin';
    $widget->size = 'col-md-12';
    $widget->orders = $maxOrder + 1;
    $widget->enabled = 1;
    $widget->save();
    
    echo "✓ Payment tracking widget installed successfully!\n";
    echo "✓ Widget ID: " . $widget->id . "\n";
    echo "✓ Order: " . $widget->orders . "\n";
    echo "✓ Size: " . $widget->size . "\n";
    echo "✓ User: " . $widget->user . "\n";
    echo "✓ Enabled: " . ($widget->enabled ? 'Yes' : 'No') . "\n";
    
    echo "\nWidget is now available in the admin dashboard!\n";
    
} catch (Exception $e) {
    echo "Error installing payment tracking widget: " . $e->getMessage() . "\n";
}

?>