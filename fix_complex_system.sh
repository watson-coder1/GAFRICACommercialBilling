#!/bin/bash

echo "=== FIXING COMPLEX RESELLER SYSTEM ==="

echo "1. Checking current system state..."
docker exec glinta-web ls -la /var/www/html/ | head -15

echo -e "\n2. Backing up current files..."
docker exec glinta-web mkdir -p /tmp/backup
docker exec glinta-web cp -r /var/www/html/*.php /tmp/backup/ 2>/dev/null || true

echo -e "\n3. Restoring proper complex files from git..."
docker exec glinta-web bash -c 'cd /var/www/html && git checkout HEAD -- reseller.php'
docker exec glinta-web bash -c 'cd /var/www/html && git checkout HEAD -- system/'
docker exec glinta-web bash -c 'cd /var/www/html && git checkout HEAD -- ui/'

echo -e "\n4. Checking if complex files exist..."
echo "reseller.php:"
docker exec glinta-web test -f /var/www/html/reseller.php && echo "EXISTS" || echo "MISSING"
echo "system/controllers/reseller_login.php:"
docker exec glinta-web test -f /var/www/html/system/controllers/reseller_login.php && echo "EXISTS" || echo "MISSING"
echo "ui/reseller/login.tpl:"
docker exec glinta-web test -f /var/www/html/ui/reseller/login.tpl && echo "EXISTS" || echo "MISSING"

echo -e "\n5. Fixing Apache configuration for complex system..."
docker exec glinta-web bash -c 'cat > /etc/apache2/sites-available/000-default.conf << EOF
<VirtualHost *:80>
    DocumentRoot /var/www/html
    ServerName localhost
    
    <Directory /var/www/html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
        
        # Enable PHP processing
        <FilesMatch "\.php$">
            SetHandler application/x-httpd-php
            Require all granted
        </FilesMatch>
    </Directory>
    
    # Ensure PHP files are processed
    <FilesMatch "\.php$">
        SetHandler application/x-httpd-php
    </FilesMatch>
    
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF'

echo -e "\n6. Creating proper .htaccess for complex system..."
docker exec glinta-web bash -c 'cat > /var/www/html/.htaccess << EOF
# Glinta Africa Complex System .htaccess
DirectoryIndex index.php
Options +FollowSymLinks -Indexes
RewriteEngine On

# Security headers
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options nosniff
    Header always set X-Frame-Options SAMEORIGIN
    Header always set X-XSS-Protection "1; mode=block"
    
    # Prevent caching for PHP files
    <FilesMatch "\.(php)$">
        Header set Cache-Control "no-cache, no-store, must-revalidate"
        Header set Pragma "no-cache"
        Header set Expires "0"
    </FilesMatch>
</IfModule>

# Allow access to all files
Require all granted

# PHP file handling
<FilesMatch "\.php$">
    Require all granted
</FilesMatch>

# Protect sensitive files
<Files "config.php">
    Require all denied
</Files>

<Files "*.log">
    Require all denied
</Files>
EOF'

echo -e "\n7. Setting proper permissions for complex system..."
docker exec glinta-web chown -R www-data:www-data /var/www/html
docker exec glinta-web find /var/www/html -type d -exec chmod 755 {} \;
docker exec glinta-web find /var/www/html -type f -exec chmod 644 {} \;

echo -e "\n8. Ensuring template directories exist with proper permissions..."
docker exec glinta-web mkdir -p /var/www/html/ui/compiled/
docker exec glinta-web mkdir -p /var/www/html/ui/cache/
docker exec glinta-web chmod 755 /var/www/html/ui/compiled/
docker exec glinta-web chmod 755 /var/www/html/ui/cache/
docker exec glinta-web chown -R www-data:www-data /var/www/html/ui/

echo -e "\n9. Enabling required Apache modules..."
docker exec glinta-web a2enmod rewrite
docker exec glinta-web a2enmod headers
docker exec glinta-web a2enmod php8.2

echo -e "\n10. Testing Apache configuration..."
docker exec glinta-web apache2ctl configtest

echo -e "\n11. Restarting Apache..."
docker exec glinta-web service apache2 restart

echo -e "\n12. Testing complex system..."
echo "Testing homepage:"
curl -s -I http://localhost:9000/ | head -3

echo -e "\nTesting reseller.php:"
curl -s -I http://localhost:9000/reseller.php | head -3

echo -e "\nTesting reseller login page:"
curl -s -I "http://localhost:9000/reseller.php?action=login" | head -3

echo -e "\n13. Checking for any errors..."
docker exec glinta-web tail -10 /var/log/apache2/error.log

echo -e "\n14. Running the test reseller fix..."
docker exec glinta-web php /var/www/html/fix_test_reseller.php

echo -e "\n=== COMPLEX SYSTEM FIX COMPLETE ==="
echo ""
echo "Your complex reseller system should now work with:"
echo "- Full MikroTik integration"
echo "- Customer management"
echo "- Payment processing"
echo "- Advanced dashboard"
echo "- Registration system"
echo ""
echo "Test these URLs:"
echo "- https://glintaafrica.com/ (homepage)"
echo "- https://glintaafrica.com/reseller.php (reseller login)"
echo "- https://glintaafrica.com/reseller.php?action=register (registration)"
echo ""
echo "Login with: testreseller / test123"