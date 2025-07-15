#!/bin/bash

echo "=== FIXING APACHE FORBIDDEN ERROR ==="

echo "1. Checking current Apache configuration..."
docker exec glinta-web cat /etc/apache2/sites-available/000-default.conf

echo -e "\n2. Checking Apache directory permissions..."
docker exec glinta-web ls -la /var/www/

echo -e "\n3. Checking html directory permissions..."
docker exec glinta-web ls -la /var/www/html/ | head -10

echo -e "\n4. Fixing Apache virtual host configuration..."
docker exec glinta-web bash -c 'cat > /etc/apache2/sites-available/000-default.conf << EOF
<VirtualHost *:80>
    DocumentRoot /var/www/html
    ServerName localhost
    
    <Directory /var/www/html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    <FilesMatch "\.php$">
        Require all granted
    </FilesMatch>
    
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF'

echo -e "\n5. Fixing ownership and permissions..."
docker exec glinta-web chown -R www-data:www-data /var/www/html
docker exec glinta-web chmod -R 755 /var/www/html
docker exec glinta-web find /var/www/html -type f -name "*.php" -exec chmod 644 {} \;

echo -e "\n6. Creating simple .htaccess..."
docker exec glinta-web bash -c 'cat > /var/www/html/.htaccess << EOF
DirectoryIndex index.php
Options -Indexes +FollowSymLinks
RewriteEngine On

# Allow access to all files
<Files "*">
    Require all granted
</Files>

# Specifically allow PHP files
<FilesMatch "\.php$">
    Require all granted
</FilesMatch>
EOF'

echo -e "\n7. Enabling Apache modules..."
docker exec glinta-web a2enmod rewrite
docker exec glinta-web a2enmod headers

echo -e "\n8. Testing Apache configuration..."
docker exec glinta-web apache2ctl configtest

echo -e "\n9. Restarting Apache..."
docker exec glinta-web service apache2 restart

echo -e "\n10. Testing direct container access..."
echo "Testing homepage:"
curl -I http://localhost:9000/ 2>&1 | head -3

echo -e "\nTesting admin.php:"
curl -I http://localhost:9000/admin.php 2>&1 | head -3

echo -e "\nTesting reseller.php:"
curl -I http://localhost:9000/reseller.php 2>&1 | head -3

echo -e "\n11. Checking recent Apache errors..."
docker exec glinta-web tail -10 /var/log/apache2/error.log

echo -e "\n=== APACHE CONFIGURATION FIXED ==="
echo ""
echo "If you still get Forbidden errors, try:"
echo "1. Clear browser cache completely"
echo "2. Try in incognito/private window"
echo "3. Check if CloudFlare or reverse proxy is blocking"
echo ""
echo "Test URLs:"
echo "- https://glintaafrica.com/"
echo "- https://glintaafrica.com/admin.php"
echo "- https://glintaafrica.com/reseller.php"