@echo off
echo === Docker Troubleshooting for Glinta Hotspot System ===
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed or not in PATH
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop/
    echo.
    pause
    exit /b 1
)

echo Docker version:
docker --version
echo.

REM Check if Docker is running
echo Checking if Docker is running...
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not running
    echo Please start Docker Desktop and try again
    echo.
    pause
    exit /b 1
)

echo Docker is running!
echo.

REM Check for port conflicts
echo Checking for port conflicts...
netstat -ano | findstr :8080 >nul 2>&1
if %errorlevel% equ 0 (
    echo WARNING: Port 8080 is already in use
    echo Current processes using port 8080:
    netstat -ano | findstr :8080
    echo.
    echo You may need to:
    echo 1. Stop the process using the port
    echo 2. Or change the port in docker-compose.local.yml
    echo.
)

netstat -ano | findstr :3308 >nul 2>&1
if %errorlevel% equ 0 (
    echo WARNING: Port 3308 is already in use
    echo Current processes using port 3308:
    netstat -ano | findstr :3308
    echo.
)

REM Stop any existing containers
echo Stopping any existing containers...
docker-compose -f docker-compose.local.yml down >nul 2>&1

REM Start the containers
echo Starting containers...
docker-compose -f docker-compose.local.yml up -d --build

REM Wait for containers to start
echo Waiting for containers to start (30 seconds)...
timeout /t 30 /nobreak >nul

REM Check container status
echo Checking container status...
docker-compose -f docker-compose.local.yml ps

REM Test MySQL connection
echo Testing MySQL connection...
timeout /t 5 /nobreak >nul
docker exec mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! -e "SELECT 1" >nul 2>&1
if %errorlevel% equ 0 (
    echo MySQL connection: OK
) else (
    echo MySQL connection: FAILED
    echo MySQL logs:
    docker-compose -f docker-compose.local.yml logs mysql-local
)

REM Import database schema
echo Importing database schema...
docker exec -i mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! nuxbill_local < install\phpnuxbill.sql
if %errorlevel% equ 0 (
    echo Database schema import: OK
) else (
    echo Database schema import: FAILED
)

REM Apply indexes
echo Applying performance indexes...
docker exec -i mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! nuxbill_local < security_performance_indexes.sql
if %errorlevel% equ 0 (
    echo Performance indexes: OK
) else (
    echo Performance indexes: Some may have failed (normal if tables don't exist)
)

echo.
echo === Setup Complete! ===
echo.
echo Access your application at:
echo   - Web Interface: http://localhost:8080
echo   - Admin Panel: http://localhost:8080/admin
echo.
echo Database details:
echo   - Host: localhost
echo   - Port: 3308
echo   - Database: nuxbill_local
echo   - Username: nuxbill
echo   - Password: SecureP@ssw0rd123!
echo.
echo To stop the environment:
echo   docker-compose -f docker-compose.local.yml down
echo.
echo To view logs:
echo   docker-compose -f docker-compose.local.yml logs -f
echo.
pause