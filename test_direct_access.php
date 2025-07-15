<?php
// Test direct access without any includes
echo "DIRECT ACCESS TEST\n";
echo "=================\n";
echo "This file loaded successfully!\n";
echo "PHP Version: " . phpversion() . "\n";
echo "Current User: " . get_current_user() . "\n";
echo "Document Root: " . $_SERVER['DOCUMENT_ROOT'] . "\n";
echo "Script Path: " . __FILE__ . "\n";
echo "Time: " . date('Y-m-d H:i:s') . "\n";
echo "\nIf you can see this, PHP is working correctly.\n";
?>