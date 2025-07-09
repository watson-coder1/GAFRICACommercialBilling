@echo off
echo === Glinta Hotspot Billing System - XAMPP Setup ===
echo.

REM Check if XAMPP is installed
if not exist "C:\xampp\htdocs" (
    echo ERROR: XAMPP not found at C:\xampp\
    echo Please install XAMPP from: https://www.apachefriends.org/
    echo.
    pause
    exit /b 1
)

echo 1. Creating project directory in XAMPP...
if not exist "C:\xampp\htdocs\glinta" (
    mkdir "C:\xampp\htdocs\glinta"
)

echo 2. Copying project files to XAMPP...
xcopy /E /Y /Q "." "C:\xampp\htdocs\glinta\"

echo 3. Creating local config for XAMPP...
(
echo ^<?php
echo.
echo $protocol = ^(!empty^($_SERVER['HTTPS']^) ^&^& $_SERVER['HTTPS'] !== 'off' ^|^| 
echo              ^(isset^($_SERVER['SERVER_PORT']^) ^&^& $_SERVER['SERVER_PORT'] == 443^)^) ? "https://" : "http://";
echo.
echo $host = isset^($_SERVER['HTTP_HOST']^) ? $_SERVER['HTTP_HOST'] : ^(isset^($_SERVER['SERVER_NAME']^) ? $_SERVER['SERVER_NAME'] : 'localhost'^);
echo.
echo $baseDir = rtrim^(dirname^($_SERVER['SCRIPT_NAME']^), '/\'^);
echo define^('APP_URL', $protocol . $host . $baseDir^);
echo.
echo $_app_stage = 'Dev'; # Development mode for local testing
echo.
echo // XAMPP LOCAL DATABASE SETTINGS
echo $db_host    = "localhost";
echo $db_port    = "";
echo $db_user    = "root";
echo $db_pass    = "";
echo $db_name    = "nuxbill_local";
echo.
echo //error reporting
echo if^($_app_stage!='Live'^){
echo     error_reporting^(E_ERROR^);
echo     ini_set^('display_errors', 1^);
echo     ini_set^('display_startup_errors', 1^);
echo }else{
echo     error_reporting^(E_ERROR^);
echo     ini_set^('display_errors', 0^);
echo     ini_set^('display_startup_errors', 0^);
echo }
) > "C:\xampp\htdocs\glinta\config.php"

echo 4. Setting up database...
echo Please follow these steps in phpMyAdmin:
echo.
echo   1. Open: http://localhost/phpmyadmin
echo   2. Create database: nuxbill_local
echo   3. Import: install/phpnuxbill.sql
echo   4. Import: security_performance_indexes.sql
echo.
echo 5. Access your application at:
echo   - Web Interface: http://localhost/glinta
echo   - Admin Panel: http://localhost/glinta/admin
echo.
echo Setup complete! Follow the manual database setup steps above.
pause