<?php
// Completely isolated test - no includes at all
header('Content-Type: text/plain');
echo "=== REDIRECT TEST - NO DEPENDENCIES ===\n\n";
echo "This page loaded successfully without redirects!\n\n";
echo "Server Info:\n";
echo "PHP Version: " . phpversion() . "\n";
echo "REQUEST_URI: " . $_SERVER['REQUEST_URI'] . "\n";
echo "SCRIPT_NAME: " . $_SERVER['SCRIPT_NAME'] . "\n";
echo "HTTP_HOST: " . $_SERVER['HTTP_HOST'] . "\n";
echo "\nIf you can see this, the server is working correctly.\n";
?>