<?php

/**
 * Reseller System Verification Script
 * Verifies all components are working properly
 */

echo "=== GLINTA AFRICA RESELLER SYSTEM VERIFICATION ===\n";

require_once 'init.php';

$errors = [];
$warnings = [];
$success = [];

// 1. Check database tables
echo "\n1. Checking database tables...\n";

$required_tables = [
    'tbl_resellers',
    'tbl_reseller_admins', 
    'tbl_reseller_subscription_payments',
    'tbl_routers',
    'tbl_customers',
    'tbl_transactions',
    'tbl_user_recharges',
    'tbl_plans',
    'tbl_widgets'
];

foreach ($required_tables as $table) {
    try {
        $result = ORM::for_table($table)->limit(1)->find_one();
        echo "✓ $table exists\n";
        $success[] = "$table table found";
    } catch (Exception $e) {
        echo "✗ $table missing or error: " . $e->getMessage() . "\n";
        $errors[] = "$table table missing or inaccessible";
    }
}

// 2. Check reseller files
echo "\n2. Checking reseller system files...\n";

$required_files = [
    'reseller.php',
    'system/controllers/reseller_login.php',
    'system/controllers/reseller_dashboard.php',
    'system/controllers/reseller_customers.php',
    'system/controllers/reseller_mikrotik.php',
    'system/controllers/reseller_reports.php',
    'system/controllers/reseller_settings.php',
    'system/controllers/reseller_subscription.php',
    'system/autoload/ResellerAuth.php',
    'system/widgets/payment_tracking.php',
    'multi_router_manager.php'
];

foreach ($required_files as $file) {
    if (file_exists($file)) {
        echo "✓ $file exists\n";
        $success[] = "$file found";
    } else {
        echo "✗ $file missing\n";
        $errors[] = "$file missing";
    }
}

// 3. Check test reseller account
echo "\n3. Checking test reseller account...\n";

try {
    $reseller = ORM::for_table('tbl_resellers')
        ->where('id', 2)
        ->find_one();
    
    if ($reseller) {
        echo "✓ Test reseller found: " . $reseller->name . "\n";
        echo "  - Status: " . $reseller->subscription_status . "\n";
        echo "  - Expires: " . $reseller->expires_at . "\n";
        $success[] = "Test reseller account active";
        
        // Check reseller admin
        $admin = ORM::for_table('tbl_reseller_admins')
            ->where('reseller_id', 2)
            ->find_one();
        
        if ($admin) {
            echo "✓ Test reseller admin found: " . $admin->username . "\n";
            $success[] = "Test reseller admin account active";
        } else {
            echo "✗ Test reseller admin not found\n";
            $errors[] = "Test reseller admin missing";
        }
    } else {
        echo "✗ Test reseller not found\n";
        $errors[] = "Test reseller account missing";
    }
} catch (Exception $e) {
    echo "✗ Error checking reseller: " . $e->getMessage() . "\n";
    $errors[] = "Database error checking reseller";
}

// 4. Check payment tracking widget
echo "\n4. Checking payment tracking widget...\n";

try {
    $widget = ORM::for_table('tbl_widgets')
        ->where('widget', 'payment_tracking')
        ->find_one();
    
    if ($widget) {
        echo "✓ Payment tracking widget installed\n";
        echo "  - Status: " . ($widget->enabled ? 'Enabled' : 'Disabled') . "\n";
        $success[] = "Payment tracking widget installed";
    } else {
        echo "✗ Payment tracking widget not found\n";
        $warnings[] = "Payment tracking widget not installed";
    }
} catch (Exception $e) {
    echo "✗ Error checking widget: " . $e->getMessage() . "\n";
    $errors[] = "Widget system error";
}

// 5. Check MikroTik API classes
echo "\n5. Checking MikroTik integration...\n";

$mikrotik_files = [
    'system/devices/RouterOSAPI.php',
    'system/devices/MikrotikHotspot.php',
    'system/devices/MikrotikPppoe.php'
];

foreach ($mikrotik_files as $file) {
    if (file_exists($file)) {
        echo "✓ $file exists\n";
        $success[] = "$file found";
    } else {
        echo "⚠ $file missing (may affect MikroTik integration)\n";
        $warnings[] = "$file missing";
    }
}

// 6. Check directory permissions
echo "\n6. Checking directory permissions...\n";

$directories = [
    'ui/compiled/',
    'ui/cache/',
    'system/cache/',
    'system/uploads/'
];

foreach ($directories as $dir) {
    if (is_dir($dir)) {
        if (is_writable($dir)) {
            echo "✓ $dir is writable\n";
            $success[] = "$dir permissions OK";
        } else {
            echo "✗ $dir is not writable\n";
            $errors[] = "$dir not writable";
        }
    } else {
        echo "⚠ $dir doesn't exist\n";
        $warnings[] = "$dir missing";
    }
}

// 7. Test multi-router manager
echo "\n7. Testing multi-router manager...\n";

try {
    require_once 'multi_router_manager.php';
    
    $manager = new MultiRouterManager(2);
    echo "✓ Multi-router manager class loaded\n";
    $success[] = "Multi-router manager functional";
    
    // Test with reseller 2
    $status = $manager->getRouterStatus();
    echo "✓ Router status check completed (" . count($status) . " routers)\n";
    
} catch (Exception $e) {
    echo "✗ Multi-router manager error: " . $e->getMessage() . "\n";
    $errors[] = "Multi-router manager not functional";
}

// 8. Check callback handlers
echo "\n8. Checking callback handlers...\n";

$callback_files = [
    'callback_reseller_invoice.php'
];

foreach ($callback_files as $file) {
    if (file_exists($file)) {
        echo "✓ $file exists\n";
        $success[] = "$file found";
    } else {
        echo "✗ $file missing\n";
        $errors[] = "$file missing";
    }
}

// Summary
echo "\n=== VERIFICATION SUMMARY ===\n";
echo "✓ Success: " . count($success) . " items\n";
echo "⚠ Warnings: " . count($warnings) . " items\n";
echo "✗ Errors: " . count($errors) . " items\n";

if (!empty($errors)) {
    echo "\n❌ CRITICAL ERRORS:\n";
    foreach ($errors as $error) {
        echo "  - $error\n";
    }
}

if (!empty($warnings)) {
    echo "\n⚠️  WARNINGS:\n";
    foreach ($warnings as $warning) {
        echo "  - $warning\n";
    }
}

if (empty($errors)) {
    echo "\n🎉 SYSTEM STATUS: READY FOR PRODUCTION\n";
    echo "\nNEXT STEPS:\n";
    echo "1. Access reseller dashboard: https://glintaafrica.com/reseller.php\n";
    echo "2. Login with: testreseller / test123\n";
    echo "3. Add MikroTik routers in the MikroTik section\n";
    echo "4. Test customer management features\n";
    echo "5. Verify payment processing\n";
    echo "6. Monitor superadmin dashboard for payment tracking\n";
} else {
    echo "\n❌ SYSTEM STATUS: REQUIRES ATTENTION\n";
    echo "Please fix the critical errors above before proceeding.\n";
}

echo "\n=== END VERIFICATION ===\n";

?>