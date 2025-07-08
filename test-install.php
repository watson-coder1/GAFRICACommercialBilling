<?php
/**
 * Glinta Hotspot Billing System - Installation Test Script
 * This script verifies basic system requirements and configuration
 */

echo "<h1>Glinta Hotspot Billing System - Installation Test</h1>";

// Check PHP version
echo "<h2>PHP Version Check</h2>";
$php_version = phpversion();
$min_php_version = '8.2.0';
echo "Current PHP Version: " . $php_version . "<br>";
echo "Minimum Required: " . $min_php_version . "<br>";
if (version_compare($php_version, $min_php_version, '>=')) {
    echo "<span style='color: green;'>✓ PHP version is compatible</span><br><br>";
} else {
    echo "<span style='color: red;'>✗ PHP version is too old</span><br><br>";
}

// Check required extensions
echo "<h2>Required PHP Extensions</h2>";
$required_extensions = ['pdo', 'pdo_mysql', 'gd', 'curl', 'zip', 'mbstring'];
foreach ($required_extensions as $ext) {
    if (extension_loaded($ext)) {
        echo "<span style='color: green;'>✓ $ext is loaded</span><br>";
    } else {
        echo "<span style='color: red;'>✗ $ext is missing</span><br>";
    }
}

// Check directory permissions
echo "<h2>Directory Permissions</h2>";
$directories = [
    'system/uploads',
    'system/cache',
    'ui/compiled',
    'ui/cache'
];

foreach ($directories as $dir) {
    if (is_dir($dir)) {
        if (is_writable($dir)) {
            echo "<span style='color: green;'>✓ $dir is writable</span><br>";
        } else {
            echo "<span style='color: red;'>✗ $dir is not writable</span><br>";
        }
    } else {
        echo "<span style='color: red;'>✗ $dir does not exist</span><br>";
    }
}

// Check config file
echo "<h2>Configuration Check</h2>";
if (file_exists('config.php')) {
    echo "<span style='color: green;'>✓ config.php exists</span><br>";
    include 'config.php';
    echo "Database Host: " . $db_host . "<br>";
    echo "Database Name: " . $db_name . "<br>";
    echo "App Stage: " . $_app_stage . "<br>";
} else {
    echo "<span style='color: red;'>✗ config.php not found</span><br>";
}

// Check vendor dependencies
echo "<h2>Composer Dependencies</h2>";
if (file_exists('system/vendor/autoload.php')) {
    echo "<span style='color: green;'>✓ Composer dependencies are installed</span><br>";
} else {
    echo "<span style='color: red;'>✗ Composer dependencies not found</span><br>";
}

// Check database connection (if available)
echo "<h2>Database Connection</h2>";
try {
    if (isset($db_host, $db_name, $db_user, $db_pass)) {
        $dsn = "mysql:host=$db_host;dbname=$db_name";
        $pdo = new PDO($dsn, $db_user, $db_pass);
        echo "<span style='color: green;'>✓ Database connection successful</span><br>";
    } else {
        echo "<span style='color: orange;'>⚠ Database variables not set</span><br>";
    }
} catch (Exception $e) {
    echo "<span style='color: red;'>✗ Database connection failed: " . $e->getMessage() . "</span><br>";
}

echo "<h2>Installation Summary</h2>";
echo "If all checks show green checkmarks, your system is ready to run Glinta Hotspot Billing System.<br>";
echo "If you see red X marks, please address those issues before proceeding.<br><br>";
echo "<strong>Next Steps:</strong><br>";
echo "1. Set up MySQL database and import the schema from install/phpnuxbill.sql<br>";
echo "2. Configure web server (Apache/Nginx) to serve this directory<br>";
echo "3. Access the installation wizard via /install/<br>";
?>