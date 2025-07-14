<?php

echo "=== PEAR2 Autoloader Test ===\n";

// Test if we can include and initialize the autoloader
require_once 'system/autoload/PEAR2/Autoload.php';

echo "✅ PEAR2 Autoloader loaded\n";

// Test if RouterOS classes can be found
try {
    if (class_exists('PEAR2\Net\RouterOS\Client')) {
        echo "✅ PEAR2\Net\RouterOS\Client class found\n";
    } else {
        echo "❌ PEAR2\Net\RouterOS\Client class NOT found\n";
    }
    
    if (class_exists('PEAR2\Net\RouterOS\Request')) {
        echo "✅ PEAR2\Net\RouterOS\Request class found\n";
    } else {
        echo "❌ PEAR2\Net\RouterOS\Request class NOT found\n";
    }
    
    if (class_exists('PEAR2\Net\Transmitter\NetworkStream')) {
        echo "✅ PEAR2\Net\Transmitter\NetworkStream class found\n";
    } else {
        echo "❌ PEAR2\Net\Transmitter\NetworkStream class NOT found\n";
    }
    
} catch (Exception $e) {
    echo "❌ Error loading classes: " . $e->getMessage() . "\n";
}

echo "\n=== RouterOS Library Test Complete ===\n";