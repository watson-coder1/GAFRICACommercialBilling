<?php
// Test MySQLi Extension
echo "<h2>PHP MySQLi Extension Test</h2>";

if (extension_loaded('mysqli')) {
    echo "<p style='color: green;'>✅ MySQLi extension is loaded!</p>";
} else {
    echo "<p style='color: red;'>❌ MySQLi extension is NOT loaded!</p>";
}

if (extension_loaded('pdo_mysql')) {
    echo "<p style='color: green;'>✅ PDO MySQL extension is loaded!</p>";
} else {
    echo "<p style='color: red;'>❌ PDO MySQL extension is NOT loaded!</p>";
}

echo "<h3>Available MySQL Extensions:</h3>";
$extensions = get_loaded_extensions();
foreach ($extensions as $ext) {
    if (stripos($ext, 'mysql') !== false || stripos($ext, 'mysqli') !== false) {
        echo "<p>📦 " . $ext . "</p>";
    }
}

echo "<h3>PHP Version:</h3>";
echo "<p>" . phpversion() . "</p>";

echo "<h3>All Loaded Extensions:</h3>";
echo "<details><summary>Click to expand</summary>";
echo "<pre>" . implode("\n", $extensions) . "</pre>";
echo "</details>";
?>