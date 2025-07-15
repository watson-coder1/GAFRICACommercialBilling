<?php
/**
 * Find Redirect Loop - Traces execution to find where redirect happens
 */

// Prevent ANY includes or requires
// This file must work in isolation

// Set up error logging to a file
ini_set('error_log', __DIR__ . '/redirect_debug.log');
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Start output immediately to prevent any redirects
echo "<!DOCTYPE html><html><head><title>Finding Redirect Loop</title></head><body>";
echo "<h1>Redirect Loop Finder</h1><pre>";

// Log this access
$log_entry = date('Y-m-d H:i:s') . " - Access from " . ($_SERVER['REMOTE_ADDR'] ?? 'unknown') . "\n";
$log_entry .= "  REQUEST_URI: " . ($_SERVER['REQUEST_URI'] ?? 'none') . "\n";
$log_entry .= "  HTTP_REFERER: " . ($_SERVER['HTTP_REFERER'] ?? 'none') . "\n";
file_put_contents(__DIR__ . '/redirect_debug.log', $log_entry, FILE_APPEND);

echo "=== CHECKING FOR COMMON REDIRECT CAUSES ===\n\n";

// 1. Check for .htaccess
echo "1. .htaccess Check:\n";
if (file_exists('.htaccess')) {
    echo "   .htaccess EXISTS - Contents:\n";
    echo "   " . str_replace("\n", "\n   ", file_get_contents('.htaccess')) . "\n";
} else {
    echo "   No .htaccess file found\n";
}

// 2. Check if index.php exists and might be redirecting
echo "\n2. index.php Check:\n";
if (file_exists('index.php')) {
    echo "   index.php EXISTS\n";
    // Check first 500 chars for redirect commands
    $content = file_get_contents('index.php', false, null, 0, 500);
    if (stripos($content, 'header') !== false || stripos($content, 'location') !== false) {
        echo "   WARNING: index.php may contain redirects\n";
    }
} else {
    echo "   No index.php file found\n";
}

// 3. Check if reseller.php starts with redirect
echo "\n3. reseller.php Check:\n";
if (file_exists('reseller.php')) {
    echo "   reseller.php EXISTS\n";
    $content = file_get_contents('reseller.php', false, null, 0, 1000);
    
    // Look for common redirect patterns
    if (stripos($content, 'header') !== false && stripos($content, 'location') !== false) {
        echo "   WARNING: reseller.php contains header location redirect\n";
    }
    
    // Check what it includes
    if (stripos($content, 'init.php') !== false) {
        echo "   reseller.php includes init.php\n";
    }
} else {
    echo "   reseller.php NOT FOUND!\n";
}

// 4. Check init.php for redirects
echo "\n4. init.php Check:\n";
if (file_exists('init.php')) {
    echo "   init.php EXISTS (" . filesize('init.php') . " bytes)\n";
    // Read in chunks to find redirects
    $handle = fopen('init.php', 'r');
    $line_no = 0;
    $found_redirect = false;
    
    while (($line = fgets($handle)) !== false && $line_no < 100) {
        $line_no++;
        if (stripos($line, 'header') !== false && stripos($line, 'location') !== false) {
            echo "   WARNING: Possible redirect at line $line_no: " . trim($line) . "\n";
            $found_redirect = true;
        }
    }
    fclose($handle);
    
    if (!$found_redirect) {
        echo "   No obvious redirects in first 100 lines\n";
    }
}

// 5. Check for infinite loop by tracking cookie
echo "\n5. Redirect Loop Detection:\n";
$cookie_name = 'redirect_test_' . md5($_SERVER['HTTP_HOST']);
$visit_count = $_COOKIE[$cookie_name] ?? 0;
$visit_count++;

if ($visit_count > 5) {
    echo "   REDIRECT LOOP DETECTED! This page has been accessed $visit_count times\n";
    // Clear the cookie
    setcookie($cookie_name, '', time() - 3600);
} else {
    // Set cookie for 1 minute
    setcookie($cookie_name, $visit_count, time() + 60);
    echo "   Visit count: $visit_count\n";
}

// 6. List all PHP files that might be involved
echo "\n6. PHP Files in Root:\n";
$files = glob('*.php');
foreach ($files as $file) {
    echo "   - $file (" . filesize($file) . " bytes)\n";
}

echo "\n=== SAFE LINKS TO TEST ===\n";
echo "These should work without redirects:\n";
echo "- <a href='test_redirect_simple.php'>test_redirect_simple.php</a> (this file)\n";
echo "- <a href='debug_redirect.php'>debug_redirect.php</a>\n";
echo "- <a href='test_reseller_minimal.php'>test_reseller_minimal.php</a>\n";
echo "- <a href='reseller_simple.php'>reseller_simple.php</a>\n";

echo "\n=== POTENTIALLY PROBLEMATIC LINKS ===\n";
echo "These might cause redirects:\n";
echo "- <a href='reseller.php'>reseller.php</a>\n";
echo "- <a href='index.php'>index.php</a>\n";
echo "- <a href='/'>Root (/)</a>\n";

echo "</pre></body></html>";

// Make sure nothing else can execute
exit();
?>