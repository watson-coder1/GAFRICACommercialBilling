#!/bin/bash

echo "=== DIAGNOSING COMPLEX SYSTEM ISSUES ==="

echo "1. Checking file structure..."
docker exec glinta-web find /var/www/html -name "*.php" | grep -E "(reseller|admin)" | head -10

echo -e "\n2. Checking reseller.php first 20 lines..."
docker exec glinta-web head -20 /var/www/html/reseller.php

echo -e "\n3. Checking if init.php exists and loads..."
docker exec glinta-web test -f /var/www/html/init.php && echo "init.php EXISTS" || echo "init.php MISSING"

echo -e "\n4. Checking config.php..."
docker exec glinta-web test -f /var/www/html/config.php && echo "config.php EXISTS" || echo "config.php MISSING"

echo -e "\n5. Testing database connection..."
docker exec glinta-web php -r "
try {
    require_once '/var/www/html/config.php';
    \$pdo = new PDO(\"mysql:host=\$db_host;dbname=\$db_name\", \$db_user, \$db_pass);
    echo \"Database: SUCCESS\n\";
} catch (Exception \$e) {
    echo \"Database: FAILED - \" . \$e->getMessage() . \"\n\";
}
"

echo -e "\n6. Checking Smarty template system..."
docker exec glinta-web test -f /var/www/html/system/vendor/smarty/smarty/libs/Smarty.class.php && echo "Smarty: EXISTS" || echo "Smarty: MISSING"

echo -e "\n7. Testing PHP syntax of main files..."
echo "reseller.php syntax:"
docker exec glinta-web php -l /var/www/html/reseller.php

echo -e "\nsystem/controllers/reseller_login.php syntax:"
docker exec glinta-web php -l /var/www/html/system/controllers/reseller_login.php 2>/dev/null || echo "File missing or has syntax errors"

echo -e "\n8. Checking permissions..."
docker exec glinta-web ls -la /var/www/html/reseller.php
docker exec glinta-web ls -la /var/www/html/system/controllers/ | head -5

echo -e "\n9. Testing simple PHP execution..."
docker exec glinta-web php -r "echo 'PHP is working: ' . phpversion() . \"\n\";"

echo -e "\n10. Checking Apache error logs for specific issues..."
docker exec glinta-web tail -20 /var/log/apache2/error.log | grep -i "reseller\|forbidden\|not found" || echo "No specific errors found"

echo -e "\n=== DIAGNOSIS COMPLETE ==="
echo ""
echo "This will help identify exactly what's causing the issues."