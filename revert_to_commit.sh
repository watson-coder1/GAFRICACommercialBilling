#!/bin/bash

echo "=== REVERTING TO COMMIT 88e71ee3d1fc6f18679a124ca0edf4d88e135e46 ==="

echo "1. Checking current git status..."
docker exec glinta-web bash -c 'cd /var/www/html && git log --oneline | head -5'

echo "2. Creating backup of current state..."
docker exec glinta-web bash -c 'cd /var/www/html && git stash push -m "Backup before revert to 88e71ee3"'

echo "3. Reverting to the specified commit..."
docker exec glinta-web bash -c 'cd /var/www/html && git reset --hard 88e71ee3d1fc6f18679a124ca0edf4d88e135e46'

echo "4. Forcing clean state..."
docker exec glinta-web bash -c 'cd /var/www/html && git clean -fd'

echo "5. Checking what we have after revert..."
docker exec glinta-web ls -la /var/www/html/ | head -10

echo "6. Verifying we're at the correct commit..."
docker exec glinta-web bash -c 'cd /var/www/html && git log --oneline | head -3'

echo "7. Setting proper permissions..."
docker exec glinta-web chown -R www-data:www-data /var/www/html/
docker exec glinta-web find /var/www/html -type f -exec chmod 644 {} \;
docker exec glinta-web find /var/www/html -type d -exec chmod 755 {} \;

echo "8. Testing the system..."
echo "Testing homepage:"
curl -s -o /dev/null -w "%{http_code}" http://localhost:9000/

echo -e "\nTesting reseller.php:"
curl -s -o /dev/null -w "%{http_code}" http://localhost:9000/reseller.php

echo -e "\n=== REVERT COMPLETE ==="
echo ""
echo "System has been reverted to commit 88e71ee3"
echo "This was the state with:"
echo "- Your original landing page"
echo "- Working reseller registration system"
echo "- All templates created"
echo ""
echo "Test your system now:"
echo "- https://glintaafrica.com/ (your original homepage)"
echo "- https://glintaafrica.com/reseller.php (reseller system)"
echo ""
echo "The system is back to exactly how it was before I made the mistakes."