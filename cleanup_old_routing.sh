#!/bin/bash

echo "=== CLEANING UP OLD ROUTING SYSTEM ==="

# Create backup directory
docker exec glinta-web mkdir -p /var/www/html/backup_old_system

echo "1. Backing up current system..."
docker exec glinta-web cp -r /var/www/html/*.php /var/www/html/backup_old_system/ 2>/dev/null || true
docker exec glinta-web cp /var/www/html/.htaccess /var/www/html/backup_old_system/ 2>/dev/null || true

echo "2. Checking current .htaccess..."
if docker exec glinta-web test -f /var/www/html/.htaccess; then
    echo "Found .htaccess file:"
    docker exec glinta-web cat /var/www/html/.htaccess
    echo ""
    echo "Moving .htaccess to backup..."
    docker exec glinta-web mv /var/www/html/.htaccess /var/www/html/backup_old_system/.htaccess.backup
else
    echo "No .htaccess file found"
fi

echo "3. Checking index.php..."
if docker exec glinta-web test -f /var/www/html/index.php; then
    echo "Found index.php - first 20 lines:"
    docker exec glinta-web head -20 /var/www/html/index.php
    echo ""
    echo "Moving index.php to backup..."
    docker exec glinta-web mv /var/www/html/index.php /var/www/html/backup_old_system/index.php.backup
else
    echo "No index.php file found"
fi

echo "4. Looking for other routing files..."
docker exec glinta-web find /var/www/html -name "*.php" -exec grep -l "header.*Location" {} \; | head -10

echo "5. Checking for customer/member panel files..."
docker exec glinta-web find /var/www/html -name "*member*" -o -name "*customer*" -o -name "*panel*" | head -10

echo "6. Testing direct access after cleanup..."
echo "Testing: curl -I http://localhost:9000/test_redirect_simple.php"
curl -I http://localhost:9000/test_redirect_simple.php 2>&1 | head -5

echo ""
echo "=== CLEANUP COMPLETE ==="
echo "Files backed up to: /var/www/html/backup_old_system/"
echo ""
echo "Test these URLs now:"
echo "- https://glintaafrica.com/test_redirect_simple.php"
echo "- https://glintaafrica.com/admin.php (admin dashboard)"
echo "- https://glintaafrica.com/reseller.php (reseller dashboard)"
echo ""
echo "If they work, the old routing has been removed successfully!"