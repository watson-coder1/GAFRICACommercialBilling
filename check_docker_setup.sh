#!/bin/bash

echo "=== DOCKER CONTAINER CHECK ==="
echo "Running containers:"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

echo -e "\n=== TESTING DATABASE CONNECTION ==="
echo "From host to MySQL container:"
docker exec glinta-mysql mysql -u phpnuxbill -pnuxbill2025! -e "SELECT 'Connection successful!' as Result;" phpnuxbill 2>&1

echo -e "\n=== CHECKING WEB CONTAINER ==="
echo "Checking which web container exists:"
if docker ps | grep -q "nuxbill"; then
    echo "Web container name: nuxbill"
    WEB_CONTAINER="nuxbill"
elif docker ps | grep -q "glinta-web"; then
    echo "Web container name: glinta-web"
    WEB_CONTAINER="glinta-web"
else
    echo "No web container found!"
    exit 1
fi

echo -e "\n=== TESTING PHP IN WEB CONTAINER ==="
docker exec $WEB_CONTAINER php -r "echo 'PHP is working in container!';"

echo -e "\n=== CHECKING DATABASE CONNECTION FROM WEB CONTAINER ==="
docker exec $WEB_CONTAINER php -r "
try {
    \$pdo = new PDO('mysql:host=glinta-mysql;dbname=phpnuxbill', 'phpnuxbill', 'nuxbill2025!');
    echo 'Database connection from web container: SUCCESS\n';
} catch (Exception \$e) {
    echo 'Database connection from web container: FAILED - ' . \$e->getMessage() . '\n';
}
"

echo -e "\n=== DONE ==="