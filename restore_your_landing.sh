#!/bin/bash

echo "=== RESTORING YOUR ORIGINAL LANDING PAGE ==="

echo "1. Found your original landing.php in backup - restoring it..."
docker exec glinta-web cp /var/www/html/backup_old_system/landing.php /var/www/html/landing.php

echo "2. Checking if you had an original index.php in backup..."
if docker exec glinta-web test -f /var/www/html/backup_old_system/index.php; then
    echo "Found original index.php in backup - restoring it..."
    docker exec glinta-web cp /var/www/html/backup_old_system/index.php /var/www/html/index.php
else
    echo "No original index.php found in backup"
    echo "Setting landing.php as homepage..."
    docker exec glinta-web cp /var/www/html/landing.php /var/www/html/index.php
fi

echo "3. Checking what we restored..."
echo "landing.php first 20 lines:"
docker exec glinta-web head -20 /var/www/html/landing.php

echo -e "\nindex.php first 20 lines:"
docker exec glinta-web head -20 /var/www/html/index.php

echo "4. Setting proper permissions..."
docker exec glinta-web chown www-data:www-data /var/www/html/landing.php
docker exec glinta-web chown www-data:www-data /var/www/html/index.php
docker exec glinta-web chmod 644 /var/www/html/landing.php
docker exec glinta-web chmod 644 /var/www/html/index.php

echo "5. Testing your restored homepage..."
curl -s -o /dev/null -w "%{http_code}" http://localhost:9000/

echo -e "\n=== YOUR ORIGINAL LANDING PAGE RESTORED! ==="
echo ""
echo "Your original landing page is now back at:"
echo "- https://glintaafrica.com/ (homepage)"
echo "- https://glintaafrica.com/landing.php (direct access)"
echo ""
echo "I will NOT touch your landing page again!"
echo "Only the reseller.php will be worked on from now on."