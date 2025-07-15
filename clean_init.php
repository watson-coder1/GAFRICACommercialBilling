<?php

/**
 * Clean init.php file - Remove any unwanted template_fallback.php includes
 */

echo "=== CLEANING INIT.PHP FILE ===\n";

// Read the current init.php
$init_content = file_get_contents(__DIR__ . '/init.php');

// Remove any lines that include template_fallback.php
$lines = explode("\n", $init_content);
$clean_lines = [];

foreach ($lines as $line) {
    $line = trim($line);
    
    // Skip empty lines at the end
    if (empty($line) && count($clean_lines) > 0) {
        continue;
    }
    
    // Skip lines that include template_fallback.php
    if (strpos($line, 'template_fallback.php') !== false) {
        echo "Removing line: $line\n";
        continue;
    }
    
    // Skip invalid PHP lines
    if (strpos($line, '<?php') === 0 && count($clean_lines) > 0) {
        echo "Skipping duplicate PHP opening tag: $line\n";
        continue;
    }
    
    $clean_lines[] = $line;
}

// Write the cleaned content
$clean_content = implode("\n", $clean_lines);
file_put_contents(__DIR__ . '/init.php', $clean_content);

echo "✓ Cleaned init.php file\n";
echo "✓ Removed template_fallback.php includes\n";
echo "✓ File now has " . count($clean_lines) . " lines\n";

// Create a simple command to apply the fix
$fix_command = '#!/bin/bash
echo "🚀 Applying init.php fix to container..."
docker cp init.php glinta-web:/var/www/html/init.php
docker exec glinta-web service apache2 restart
echo "🔍 Testing reseller login..."
curl -s https://glintaafrica.com/reseller.php | head -n 10
echo "✅ Init.php fix applied!"
';

file_put_contents(__DIR__ . '/apply_init_fix.sh', $fix_command);
chmod(__DIR__ . '/apply_init_fix.sh', 0755);

echo "\n=== DOCKER COMMANDS TO RUN ===\n";
echo "# Apply the init.php fix:\n";
echo "docker cp init.php glinta-web:/var/www/html/init.php\n";
echo "docker exec glinta-web service apache2 restart\n";
echo "curl https://glintaafrica.com/reseller.php\n";

?>