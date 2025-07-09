@echo off
echo === Fixing Your Existing Docker Setup ===
echo.

REM Navigate to project directory
cd /d "D:\Glinta Hotspot\Glinta-Hotspot-Billing-System"

echo 1. Stopping existing containers...
docker stop nuxbill glinta-hotspot-db glinta-hotspot-phpmyadmin 2>nul

echo 2. Starting containers with docker-compose (ensures same network)...
docker-compose up -d

echo 3. Waiting for containers to start...
timeout /t 10

echo 4. Checking container status...
docker-compose ps

echo 5. Testing database connection...
docker exec -it nuxbill ping -c 2 mysql 2>nul
if %errorlevel% neq 0 (
    echo Database connection test failed, trying alternative...
    docker exec -it nuxbill ping -c 2 glinta-hotspot-db 2>nul
)

echo 6. Checking config inside container...
docker exec -it nuxbill cat config.php | findstr db_host

echo 7. Applying security indexes to database...
docker exec -i mysql mysql -u root -p12345678 nuxbill < security_performance_indexes.sql 2>nul

echo.
echo === Setup Complete! ===
echo Try accessing: http://localhost:9000
echo.
pause