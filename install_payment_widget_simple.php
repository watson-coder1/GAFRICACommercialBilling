<?php

/**
 * Simple Payment Widget Installer
 * Works with existing tbl_widgets table structure
 */

require_once 'init.php';

echo "=== SIMPLE PAYMENT WIDGET INSTALLER ===\n";

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
    
    // Set only the columns that exist in the table
    $widget->title = 'Payment Tracking';
    $widget->widget = 'payment_tracking';
    $widget->user = 'Admin';
    $widget->orders = $maxOrder + 1;
    $widget->enabled = 1;
    $widget->position = 1;
    $widget->content = 'Track all payments: hotspot users, PPOE, and resellers';
    
    $widget->save();
    
    echo "✓ Payment tracking widget installed successfully!\n";
    echo "✓ Widget ID: " . $widget->id . "\n";
    echo "✓ Title: " . $widget->title . "\n";
    echo "✓ Order: " . $widget->orders . "\n";
    echo "✓ User: " . $widget->user . "\n";
    echo "✓ Enabled: " . ($widget->enabled ? 'Yes' : 'No') . "\n";
    
    // Verify the widget file exists
    $widget_file = 'system/widgets/payment_tracking.php';
    if (file_exists($widget_file)) {
        echo "✓ Widget file exists: $widget_file\n";
        
        // Test the widget
        try {
            require_once $widget_file;
            $widget_instance = new payment_tracking();
            $widget_data = ['id' => $widget->id, 'title' => $widget->title];
            $content = $widget_instance->getWidget($widget_data);
            
            if (!empty($content)) {
                echo "✓ Widget generates content successfully (" . strlen($content) . " chars)\n";
            } else {
                echo "⚠ Widget generates empty content\n";
            }
            
        } catch (Exception $e) {
            echo "⚠ Widget test failed: " . $e->getMessage() . "\n";
        }
    } else {
        echo "✗ Widget file missing: $widget_file\n";
    }
    
    echo "\n🎉 PAYMENT TRACKING WIDGET INSTALLED!\n";
    echo "\nYou can now see payment tracking in the admin dashboard:\n";
    echo "https://glintaafrica.com/admin.php (admin/glinta2025!)\n";
    
} catch (Exception $e) {
    echo "✗ Error installing widget: " . $e->getMessage() . "\n";
}

echo "\n=== END SIMPLE PAYMENT WIDGET INSTALLER ===\n";

?>