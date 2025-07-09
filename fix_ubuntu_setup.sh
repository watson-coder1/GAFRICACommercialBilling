#!/bin/bash

echo "=== Fixing Ubuntu Docker Setup ==="
echo

# Navigate to project directory
cd "/mnt/d/Glinta Hotspot/Glinta-Hotspot-Billing-System"

echo "1. Stopping existing containers..."
docker stop nuxbill glinta-hotspot-db glinta-hotspot-phpmyadmin 2>/dev/null || true

echo "2. Starting containers with docker-compose..."
docker-compose up -d

echo "3. Waiting for MySQL to be ready..."
sleep 30

echo "4. Checking container status..."
docker-compose ps

echo "5. Testing database connection..."
docker exec -i mysql mysql -u root -pSecureP@ssw0rd123! -e "SELECT 1;" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ Database connection successful"
else
    echo "❌ Database connection failed"
fi

echo "6. Importing database schema..."
docker exec -i mysql mysql -u root -pSecureP@ssw0rd123! nuxbill < install/phpnuxbill.sql

echo "7. Applying security indexes..."
docker exec -i mysql mysql -u root -pSecureP@ssw0rd123! nuxbill < security_performance_indexes.sql

echo "8. Testing web application..."
curl -I http://localhost:9000 2>/dev/null | head -1

echo
echo "=== Setup Complete! ==="
echo "Access your application at: http://localhost:9000"
echo "Database: mysql container, user: root, password: SecureP@ssw0rd123!"
echo