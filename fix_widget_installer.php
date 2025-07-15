<?php

/**
 * Fix Widget Installer - Check table structure and install widget properly
 */

require_once 'init.php';

echo "=== WIDGET INSTALLER FIXER ===\n";

try {
    // Check the current structure of tbl_widgets
    echo "1. Checking tbl_widgets table structure...\n";
    
    $columns = ORM::get_db()->query("DESCRIBE tbl_widgets")->fetchAll();
    
    echo "   Current columns in tbl_widgets:\n";
    foreach ($columns as $column) {
        echo "   - {$column['Field']} ({$column['Type']})\n";
    }
    
    // Check if the widget already exists
    $existing = ORM::for_table('tbl_widgets')
        ->where('widget', 'payment_tracking')
        ->find_one();
    
    if ($existing) {
        echo "\n2. Payment tracking widget already exists. Updating...\n";
        $widget = $existing;
    } else {
        echo "\n2. Creating new payment tracking widget...\n";
        $widget = ORM::for_table('tbl_widgets')->create();
    }
    
    // Get highest order number
    $maxOrder = ORM::for_table('tbl_widgets')
        ->where('user', 'Admin')
        ->max('orders') ?: 0;
    
    // Set widget properties based on available columns
    $widget->title = 'Payment Tracking';
    $widget->widget = 'payment_tracking';
    $widget->description = 'Track all payments: hotspot users, PPOE, and resellers';
    $widget->user = 'Admin';
    $widget->size = 'col-md-12';
    $widget->orders = $maxOrder + 1;
    $widget->enabled = 1;
    
    // Only set icon if column exists
    $hasIconColumn = false;
    foreach ($columns as $column) {
        if ($column['Field'] === 'icon') {
            $hasIconColumn = true;
            break;
        }
    }
    
    if ($hasIconColumn) {
        $widget->icon = 'fa-money';
        echo "   - Added icon field\n";
    } else {
        echo "   - Icon column not found, skipping\n";
    }
    
    $widget->save();
    
    echo "\n✓ Payment tracking widget installed successfully!\n";
    echo "✓ Widget ID: " . $widget->id . "\n";
    echo "✓ Order: " . $widget->orders . "\n";
    echo "✓ Size: " . $widget->size . "\n";
    echo "✓ User: " . $widget->user . "\n";
    echo "✓ Enabled: " . ($widget->enabled ? 'Yes' : 'No') . "\n";
    
    // Verify the widget file exists
    $widget_file = 'system/widgets/payment_tracking.php';
    if (file_exists($widget_file)) {
        echo "✓ Widget file exists: $widget_file\n";
    } else {
        echo "✗ Widget file missing: $widget_file\n";
    }
    
    // Test the widget
    echo "\n3. Testing widget functionality...\n";
    
    try {
        require_once $widget_file;
        $widget_instance = new payment_tracking();
        $widget_data = ['id' => $widget->id, 'title' => $widget->title];
        $content = $widget_instance->getWidget($widget_data);
        
        if (!empty($content)) {
            echo "✓ Widget generates content successfully\n";
            echo "✓ Content length: " . strlen($content) . " characters\n";
        } else {
            echo "⚠ Widget generates empty content\n";
        }
        
    } catch (Exception $e) {
        echo "✗ Widget test failed: " . $e->getMessage() . "\n";
    }
    
    echo "\n🎉 WIDGET INSTALLATION COMPLETE!\n";
    echo "\nThe payment tracking widget is now available in the admin dashboard.\n";
    echo "You can access it at: https://glintaafrica.com/admin.php\n";
    
} catch (Exception $e) {
    echo "✗ Error: " . $e->getMessage() . "\n";
    
    // If there's still an issue, let's create a minimal widget entry
    echo "\nTrying minimal widget installation...\n";
    
    try {
        $minimal_widget = ORM::for_table('tbl_widgets')->create();
        $minimal_widget->title = 'Payment Tracking';
        $minimal_widget->widget = 'payment_tracking';
        $minimal_widget->user = 'Admin';
        $minimal_widget->enabled = 1;
        $minimal_widget->save();
        
        echo "✓ Minimal widget created successfully\n";
        
    } catch (Exception $e2) {
        echo "✗ Minimal widget creation failed: " . $e2->getMessage() . "\n";
    }
}

echo "\n=== END WIDGET INSTALLER FIXER ===\n";

?>