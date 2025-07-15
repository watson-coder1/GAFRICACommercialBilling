#!/bin/bash

echo "=== FIXING APACHE REDIRECT LOOP ==="

# Check current Apache configuration
echo "1. Checking Apache configuration..."
docker exec glinta-web cat /etc/apache2/sites-available/000-default.conf

echo -e "\n2. Looking for .htaccess files..."
docker exec glinta-web find /var/www/html -name ".htaccess" -exec echo "Found: {}" \; -exec cat {} \;

echo -e "\n3. Checking for redirect loops in Apache config..."
docker exec glinta-web grep -r "Redirect" /etc/apache2/ || echo "No Redirect directives found"

echo -e "\n4. Checking for RewriteRule issues..."
docker exec glinta-web grep -r "RewriteRule" /etc/apache2/ || echo "No RewriteRule directives found"

echo -e "\n5. Testing direct container access..."
echo "Testing: curl -I http://localhost:9000/"
curl -I http://localhost:9000/ 2>&1 | head -10

echo -e "\n6. Recent Apache access logs..."
docker exec glinta-web tail -10 /var/log/apache2/access.log

echo -e "\n7. Recent Apache error logs..."
docker exec glinta-web tail -10 /var/log/apache2/error.log

echo -e "\n=== POTENTIAL FIXES ==="

echo -e "\nIf you see redirect loops, try these fixes:"
echo "1. Remove problematic .htaccess:"
echo "   docker exec glinta-web rm -f /var/www/html/.htaccess"

echo -e "\n2. Disable SSL redirect if causing issues:"
echo "   docker exec glinta-web a2dismod rewrite"

echo -e "\n3. Restart Apache:"
echo "   docker exec glinta-web service apache2 restart"

echo -e "\n4. Check if port 9000 works directly:"
echo "   curl -I http://YOUR_SERVER_IP:9000/"

echo -e "\n=== END ==="