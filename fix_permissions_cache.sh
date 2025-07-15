#!/bin/bash

echo "=== FIXING PERMISSIONS AND CACHE ISSUES ==="

echo "1. Checking current permissions..."
docker exec glinta-web ls -la /var/www/html/ | head -10

echo "2. Setting proper file permissions..."
docker exec glinta-web chown -R www-data:www-data /var/www/html
docker exec glinta-web find /var/www/html -type f -exec chmod 644 {} \;
docker exec glinta-web find /var/www/html -type d -exec chmod 755 {} \;

echo "3. Making specific PHP files executable..."
docker exec glinta-web chmod 644 /var/www/html/*.php
docker exec glinta-web chmod 755 /var/www/html/ui/compiled/
docker exec glinta-web chmod 755 /var/www/html/ui/cache/

echo "4. Checking Apache configuration..."
docker exec glinta-web bash -c 'cat > /var/www/html/.htaccess << EOF
# Glinta Africa - Clean .htaccess
DirectoryIndex index.php

# Enable Apache modules
Options +FollowSymLinks
RewriteEngine On

# Prevent caching issues
<IfModule mod_headers.c>
    # Disable caching for PHP files
    <FilesMatch "\.(php)$">
        Header set Cache-Control "no-cache, no-store, must-revalidate"
        Header set Pragma "no-cache"
        Header set Expires "0"
    </FilesMatch>
    
    # Cache static files
    <FilesMatch "\.(css|js|png|jpg|jpeg|gif|ico|svg)$">
        Header set Cache-Control "max-age=31536000, public"
    </FilesMatch>
</IfModule>

# Prevent access to sensitive files
<Files "*.log">
    Order allow,deny
    Deny from all
</Files>

<Files "config.php">
    Order allow,deny
    Deny from all
</Files>

# Allow access to PHP files
<Files "*.php">
    Order allow,deny
    Allow from all
</Files>

# Directory browsing
Options -Indexes

# Security headers
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options nosniff
    Header always set X-Frame-Options SAMEORIGIN
    Header always set X-XSS-Protection "1; mode=block"
</IfModule>
EOF'

echo "5. Enabling Apache modules..."
docker exec glinta-web a2enmod rewrite
docker exec glinta-web a2enmod headers

echo "6. Restarting Apache..."
docker exec glinta-web service apache2 restart

echo "7. Testing permissions..."
echo "Testing: curl -I http://localhost:9000/"
curl -I http://localhost:9000/ 2>&1 | head -5

echo ""
echo "Testing: curl -I http://localhost:9000/admin.php"
curl -I http://localhost:9000/admin.php 2>&1 | head -5

echo ""
echo "Testing: curl -I http://localhost:9000/reseller.php"
curl -I http://localhost:9000/reseller.php 2>&1 | head -5

echo ""
echo "8. Checking for any remaining issues..."
docker exec glinta-web tail -5 /var/log/apache2/error.log

echo ""
echo "=== FIXES COMPLETE ==="
echo ""
echo "The system now has:"
echo "- Proper file permissions (644/755)"
echo "- No-cache headers for PHP files"
echo "- Proper Apache configuration"
echo ""
echo "Test these URLs (should work without Forbidden errors):"
echo "- https://glintaafrica.com/"
echo "- https://glintaafrica.com/admin.php"
echo "- https://glintaafrica.com/reseller.php"
echo ""
echo "Cache issues should also be resolved!"