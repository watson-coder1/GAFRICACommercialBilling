#!/bin/bash

echo "=== RESTORING CLEAN SYSTEM ==="

echo "1. Installing new index.php..."
docker exec glinta-web cp /var/www/html/new_index.php /var/www/html/index.php

echo "2. Ensuring no problematic .htaccess exists..."
docker exec glinta-web rm -f /var/www/html/.htaccess

echo "3. Creating simple .htaccess for clean URLs..."
docker exec glinta-web bash -c 'cat > /var/www/html/.htaccess << EOF
# Simple .htaccess for Glinta Africa
DirectoryIndex index.php
RewriteEngine On

# Prevent access to sensitive files
<Files "*.log">
    Order allow,deny
    Deny from all
</Files>

# Optional: Redirect www to non-www (if needed)
# RewriteCond %{HTTP_HOST} ^www\.(.*)$ [NC]
# RewriteRule ^(.*)$ https://%1/$1 [R=301,L]

# Optional: Force HTTPS (if needed)
# RewriteCond %{HTTPS} off
# RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
EOF'

echo "4. Setting proper permissions..."
docker exec glinta-web chown -R www-data:www-data /var/www/html
docker exec glinta-web chmod -R 755 /var/www/html

echo "5. Restarting Apache..."
docker exec glinta-web service apache2 restart

echo "6. Testing the new system..."
echo "Testing: curl -I http://localhost:9000/"
curl -I http://localhost:9000/ 2>&1 | head -5

echo ""
echo "=== CLEAN SYSTEM RESTORED ==="
echo ""
echo "Test these URLs:"
echo "- https://glintaafrica.com/ (new homepage)"
echo "- https://glintaafrica.com/admin.php (admin dashboard)"
echo "- https://glintaafrica.com/reseller.php (reseller dashboard)"
echo "- https://glintaafrica.com/test_redirect_simple.php (test file)"
echo ""
echo "If these work without redirects, the system is clean!"