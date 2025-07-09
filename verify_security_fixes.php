<?php
/**
 * Security Fixes Verification Script
 * Run this script to verify all security fixes are properly applied
 */

echo "=== Glinta Hotspot Billing System - Security Verification ===\n\n";

$checks = [];

// Check 1: Verify SQL injection fixes
echo "1. Checking SQL injection fixes...\n";
$loginFile = __DIR__ . '/system/controllers/login.php';
$reportsFile = __DIR__ . '/system/controllers/reports.php';

if (file_exists($loginFile)) {
    $content = file_get_contents($loginFile);
    if (strpos($content, 'whereRaw("BINARY code = \'$voucher\'")') === false) {
        echo "   ✅ Login controller SQL injection fixed\n";
        $checks['sql_injection_login'] = true;
    } else {
        echo "   ❌ Login controller still vulnerable to SQL injection\n";
        $checks['sql_injection_login'] = false;
    }
} else {
    echo "   ❌ Login controller file not found\n";
    $checks['sql_injection_login'] = false;
}

if (file_exists($reportsFile)) {
    $content = file_get_contents($reportsFile);
    if (strpos($content, 'strtotime("$sd $ts"))') === false) {
        echo "   ✅ Reports controller SQL injection fixed\n";
        $checks['sql_injection_reports'] = true;
    } else {
        echo "   ❌ Reports controller still vulnerable to SQL injection\n";
        $checks['sql_injection_reports'] = false;
    }
} else {
    echo "   ❌ Reports controller file not found\n";
    $checks['sql_injection_reports'] = false;
}

// Check 2: Verify password hashing fixes
echo "\n2. Checking password hashing fixes...\n";
$passwordFile = __DIR__ . '/system/autoload/Password.php';

if (file_exists($passwordFile)) {
    $content = file_get_contents($passwordFile);
    if (strpos($content, 'password_hash($password, PASSWORD_DEFAULT)') !== false) {
        echo "   ✅ Password hashing upgraded to bcrypt\n";
        $checks['password_hashing'] = true;
    } else {
        echo "   ❌ Password hashing still using SHA1\n";
        $checks['password_hashing'] = false;
    }
    
    if (strpos($content, 'password_verify($user_input, $hashed_password)') !== false) {
        echo "   ✅ Password verification updated\n";
        $checks['password_verification'] = true;
    } else {
        echo "   ❌ Password verification not updated\n";
        $checks['password_verification'] = false;
    }
} else {
    echo "   ❌ Password class file not found\n";
    $checks['password_hashing'] = false;
    $checks['password_verification'] = false;
}

// Check 3: Verify eval() removal
echo "\n3. Checking eval() removal...\n";
$widgetFiles = [
    __DIR__ . '/system/widgets/html_php.php',
    __DIR__ . '/system/widgets/html_php_card.php',
    __DIR__ . '/system/widgets/customer/html_php.php'
];

$evalFixed = true;
foreach ($widgetFiles as $file) {
    if (file_exists($file)) {
        $content = file_get_contents($file);
        if (strpos($content, 'eval(') === false) {
            echo "   ✅ " . basename($file) . " - eval() removed\n";
        } else {
            echo "   ❌ " . basename($file) . " - still contains eval()\n";
            $evalFixed = false;
        }
    } else {
        echo "   ❌ " . basename($file) . " - file not found\n";
        $evalFixed = false;
    }
}
$checks['eval_removal'] = $evalFixed;

// Check 4: Verify configuration changes
echo "\n4. Checking configuration changes...\n";
$configFile = __DIR__ . '/config.php';

if (file_exists($configFile)) {
    $content = file_get_contents($configFile);
    
    if (strpos($content, '$_app_stage = \'Live\'') !== false) {
        echo "   ✅ Application set to production mode\n";
        $checks['production_mode'] = true;
    } else {
        echo "   ❌ Application still in development mode\n";
        $checks['production_mode'] = false;
    }
    
    if (strpos($content, '12345678') === false) {
        echo "   ✅ Default database password changed\n";
        $checks['default_password'] = true;
    } else {
        echo "   ❌ Default database password still in use\n";
        $checks['default_password'] = false;
    }
} else {
    echo "   ❌ Config file not found\n";
    $checks['production_mode'] = false;
    $checks['default_password'] = false;
}

// Check 5: Verify SSL verification
echo "\n5. Checking SSL verification...\n";
$mpesaFile = __DIR__ . '/system/autoload/MpesaIntegration.php';

if (file_exists($mpesaFile)) {
    $content = file_get_contents($mpesaFile);
    if (strpos($content, 'CURLOPT_SSL_VERIFYPEER, true') !== false) {
        echo "   ✅ SSL verification enabled\n";
        $checks['ssl_verification'] = true;
    } else {
        echo "   ❌ SSL verification still disabled\n";
        $checks['ssl_verification'] = false;
    }
} else {
    echo "   ❌ M-Pesa integration file not found\n";
    $checks['ssl_verification'] = false;
}

// Check 6: Verify database indexes script exists
echo "\n6. Checking database indexes script...\n";
$indexFile = __DIR__ . '/security_performance_indexes.sql';

if (file_exists($indexFile)) {
    echo "   ✅ Database indexes script created\n";
    $checks['database_indexes'] = true;
} else {
    echo "   ❌ Database indexes script not found\n";
    $checks['database_indexes'] = false;
}

// Summary
echo "\n=== SECURITY VERIFICATION SUMMARY ===\n";
$passed = 0;
$total = count($checks);

foreach ($checks as $check => $result) {
    if ($result) {
        $passed++;
        echo "✅ " . ucfirst(str_replace('_', ' ', $check)) . "\n";
    } else {
        echo "❌ " . ucfirst(str_replace('_', ' ', $check)) . "\n";
    }
}

echo "\nResults: {$passed}/{$total} checks passed\n";

if ($passed === $total) {
    echo "\n🎉 ALL SECURITY FIXES VERIFIED SUCCESSFULLY!\n";
    echo "Your system is now significantly more secure.\n";
    echo "\nNext steps:\n";
    echo "1. Run the database indexes script: mysql -u nuxbill -p nuxbill < security_performance_indexes.sql\n";
    echo "2. Update production passwords\n";
    echo "3. Test all functionality\n";
    echo "4. Monitor system logs for any issues\n";
} else {
    echo "\n⚠️  SOME SECURITY FIXES ARE MISSING!\n";
    echo "Please review the failed checks above and apply the missing fixes.\n";
}

echo "\n=== End of Security Verification ===\n";
?>