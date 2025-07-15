#!/bin/bash

echo "=== RESTORING ORIGINAL LANDING PAGE ==="

echo "1. Checking what's in backup..."
docker exec glinta-web ls -la /var/www/html/backup_old_system/ 2>/dev/null || echo "No backup found"

echo "2. Looking for original index.php in git history..."
docker exec glinta-web bash -c 'cd /var/www/html && git log --oneline | head -10'

echo "3. Restoring from git if available..."
docker exec glinta-web bash -c 'cd /var/www/html && git checkout HEAD~10 -- index.php' 2>/dev/null || echo "Could not restore from git"

echo "4. If that didn't work, let's check what index.php we have..."
docker exec glinta-web ls -la /var/www/html/index.php

echo "5. Checking first 30 lines of current index.php..."
docker exec glinta-web head -30 /var/www/html/index.php

echo "6. Looking for any other potential landing pages..."
docker exec glinta-web find /var/www/html -name "*.php" | grep -E "(home|landing|main)" | head -5

echo "7. Checking for any HTML files that might be the landing page..."
docker exec glinta-web find /var/www/html -name "*.html" | head -5

echo "=== RESTORATION ATTEMPT COMPLETE ==="
echo ""
echo "Please tell me:"
echo "1. What was your original landing page called?"
echo "2. What did it look like?"
echo "3. Where should I find it?"
echo ""
echo "I will restore it exactly as it was!"