<?php
echo "=== MySQLi Debug Test ===\n";
echo "PHP Version: " . phpversion() . "\n";
echo "MySQLi Extension Loaded: " . (extension_loaded('mysqli') ? 'YES' : 'NO') . "\n";
echo "MySQLi Class Exists: " . (class_exists('mysqli') ? 'YES' : 'NO') . "\n";

if (class_exists('mysqli')) {
    echo "Attempting to create MySQLi connection...\n";
    try {
        $mysqli = new mysqli('mysql', 'nuxbill', 'SecureP@ssw0rd123!', 'nuxbill');
        if ($mysqli->connect_error) {
            echo "Connection failed: " . $mysqli->connect_error . "\n";
        } else {
            echo "MySQLi connection successful!\n";
            $mysqli->close();
        }
    } catch (Exception $e) {
        echo "Exception: " . $e->getMessage() . "\n";
    }
} else {
    echo "MySQLi class NOT available!\n";
}

echo "=== Loaded Extensions ===\n";
$extensions = get_loaded_extensions();
foreach ($extensions as $ext) {
    if (stripos($ext, 'mysql') !== false || stripos($ext, 'sql') !== false) {
        echo "- $ext\n";
    }
}
echo "=== End Debug ===\n";
?>