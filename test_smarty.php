<?php
/**
 * Test Smarty Template System
 */

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<h1>Smarty Template Test</h1><pre>";

// Step 1: Check if Smarty exists
echo "=== SMARTY CHECK ===\n";
$smarty_path = 'system/vendor/smarty/smarty/libs/Smarty.class.php';
echo "Smarty path: $smarty_path\n";
echo "Exists: " . (file_exists($smarty_path) ? 'YES' : 'NO') . "\n";

if (!file_exists($smarty_path)) {
    die("\nERROR: Smarty not found!");
}

// Step 2: Load Smarty
echo "\n=== LOADING SMARTY ===\n";
require_once $smarty_path;

try {
    $ui = new Smarty();
    echo "Smarty loaded successfully\n";
    echo "Smarty version: " . Smarty::SMARTY_VERSION . "\n";
} catch (Exception $e) {
    die("ERROR loading Smarty: " . $e->getMessage());
}

// Step 3: Configure directories
echo "\n=== CONFIGURING DIRECTORIES ===\n";
$dirs = [
    'reseller' => 'ui/reseller/',
    'admin' => 'ui/ui/admin/',
    'default' => 'ui/ui/'
];

foreach ($dirs as $name => $dir) {
    echo "$name: $dir - " . (is_dir($dir) ? 'EXISTS' : 'MISSING') . "\n";
}

try {
    $ui->setTemplateDir($dirs);
    $ui->setCompileDir('ui/compiled/');
    $ui->setCacheDir('ui/cache/');
    $ui->setConfigDir('ui/conf/');
    echo "\nDirectories configured successfully\n";
} catch (Exception $e) {
    echo "\nERROR configuring directories: " . $e->getMessage() . "\n";
}

// Step 4: Check compile/cache directories
echo "\n=== CHECKING WRITE DIRECTORIES ===\n";
$write_dirs = ['ui/compiled/', 'ui/cache/'];
foreach ($write_dirs as $dir) {
    echo "$dir: ";
    if (!is_dir($dir)) {
        mkdir($dir, 0755, true);
        echo "CREATED";
    } else {
        echo "EXISTS";
    }
    echo " - " . (is_writable($dir) ? 'WRITABLE' : 'NOT WRITABLE') . "\n";
}

// Step 5: Check template files
echo "\n=== CHECKING TEMPLATE FILES ===\n";
$templates = [
    'reseller/login.tpl',
    'reseller/dashboard.tpl',
    'reseller/registration.tpl'
];

foreach ($templates as $tpl) {
    $full_path = 'ui/' . $tpl;
    echo "$tpl: " . (file_exists($full_path) ? 'EXISTS' : 'MISSING') . "\n";
}

// Step 6: Test simple template rendering
echo "\n=== TESTING TEMPLATE RENDERING ===\n";
try {
    // Create a simple test template
    $test_tpl = 'ui/reseller/test.tpl';
    file_put_contents($test_tpl, '<h1>Test Template</h1><p>Variable test: {$test_var}</p>');
    
    $ui->assign('test_var', 'SUCCESS!');
    $output = $ui->fetch('test.tpl');
    echo "Template rendering: SUCCESS\n";
    echo "Output length: " . strlen($output) . " bytes\n";
    
    // Clean up
    unlink($test_tpl);
} catch (Exception $e) {
    echo "Template rendering FAILED: " . $e->getMessage() . "\n";
}

echo "\n=== DONE ===\n";
echo "</pre>";
?>