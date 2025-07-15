<?php
/**
 * Debug Reseller Portal Issues
 */

echo "<h1>Reseller Portal Debug</h1>\n";
echo "<h2>System Check</h2>\n";

// Basic PHP info
echo "<p><strong>PHP Version:</strong> " . PHP_VERSION . "</p>\n";
echo "<p><strong>Current Directory:</strong> " . getcwd() . "</p>\n";
echo "<p><strong>Server Software:</strong> " . $_SERVER['SERVER_SOFTWARE'] . "</p>\n";

// Check required files
echo "<h2>Required Files Check</h2>\n";
$files = [
    'init.php' => file_exists('init.php'),
    'system/orm.php' => file_exists('system/orm.php'),
    'system/autoload/ResellerAuth.php' => file_exists('system/autoload/ResellerAuth.php'),
    'system/controllers/reseller_login.php' => file_exists('system/controllers/reseller_login.php'),
    'system/controllers/reseller_dashboard.php' => file_exists('system/controllers/reseller_dashboard.php'),
    'ui/reseller/' => is_dir('ui/reseller/'),
    'ui/reseller/login.tpl' => file_exists('ui/reseller/login.tpl'),
    'ui/reseller/dashboard.tpl' => file_exists('ui/reseller/dashboard.tpl')
];

foreach ($files as $file => $exists) {
    $status = $exists ? '✅' : '❌';
    echo "<p>$status $file</p>\n";
}

// Test database connection
echo "<h2>Database Connection Test</h2>\n";
try {
    require_once 'init.php';
    require_once 'system/orm.php';
    
    // Test simple query
    $test = ORM::for_table('tbl_resellers')->count();
    echo "<p>✅ Database connected successfully. Found $test resellers.</p>\n";
    
    // Check test reseller
    $testReseller = ORM::for_table('tbl_resellers')->where('email', 'test@reseller.com')->find_one();
    if ($testReseller) {
        echo "<p>✅ Test reseller found: ID {$testReseller->id}, Status: {$testReseller->subscription_status}</p>\n";
        
        // Check admin user
        $testAdmin = ORM::for_table('tbl_reseller_admins')->where('reseller_id', $testReseller->id)->find_one();
        if ($testAdmin) {
            echo "<p>✅ Test admin found: Username {$testAdmin->username}</p>\n";
        } else {
            echo "<p>❌ Test admin not found</p>\n";
        }
    } else {
        echo "<p>❌ Test reseller not found</p>\n";
    }
    
} catch (Exception $e) {
    echo "<p>❌ Database error: " . $e->getMessage() . "</p>\n";
}

// Test Smarty
echo "<h2>Smarty Template Engine Test</h2>\n";
try {
    if (class_exists('Smarty')) {
        $ui = new Smarty();
        echo "<p>✅ Smarty class available</p>\n";
        
        if (is_dir('ui/reseller/')) {
            $ui->setTemplateDir('ui/reseller/');
            echo "<p>✅ Template directory set</p>\n";
        } else {
            echo "<p>❌ Template directory missing</p>\n";
        }
        
        if (is_dir('system/tmp/')) {
            $ui->setCompileDir('system/tmp/');
            echo "<p>✅ Compile directory set</p>\n";
        } else {
            echo "<p>❌ Compile directory missing</p>\n";
        }
        
    } else {
        echo "<p>❌ Smarty class not found</p>\n";
    }
} catch (Exception $e) {
    echo "<p>❌ Smarty error: " . $e->getMessage() . "</p>\n";
}

// Check permissions
echo "<h2>File Permissions</h2>\n";
$checkFiles = ['reseller.php', 'system/tmp/', 'ui/reseller/'];
foreach ($checkFiles as $file) {
    if (file_exists($file)) {
        $perms = substr(sprintf('%o', fileperms($file)), -4);
        echo "<p>$file: $perms</p>\n";
    }
}

echo "<h2>Session Test</h2>\n";
session_start();
echo "<p>Session ID: " . session_id() . "</p>\n";
echo "<p>Session status: " . session_status() . "</p>\n";

echo "<h2>Next Steps</h2>\n";
echo "<p>1. Fix any ❌ issues above</p>\n";
echo "<p>2. Replace reseller.php with the fixed version</p>\n";
echo "<p>3. Test access to reseller portal</p>\n";
?>