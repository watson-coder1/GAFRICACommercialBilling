@echo off
echo === Security Fixes Verification ===
echo.

set "passed=0"
set "total=0"

REM Check 1: SQL injection fixes
echo 1. Checking SQL injection fixes...
set /a total+=1
findstr /C:"whereRaw(\"BINARY code = '\$voucher'\")" system\controllers\login.php >nul 2>&1
if %errorlevel% neq 0 (
    echo    [OK] Login controller SQL injection fixed
    set /a passed+=1
) else (
    echo    [FAIL] Login controller still vulnerable
)

REM Check 2: Password hashing
echo 2. Checking password hashing...
set /a total+=1
findstr /C:"password_hash(\$password, PASSWORD_DEFAULT)" system\autoload\Password.php >nul 2>&1
if %errorlevel% equ 0 (
    echo    [OK] Password hashing upgraded to bcrypt
    set /a passed+=1
) else (
    echo    [FAIL] Password hashing still using SHA1
)

REM Check 3: eval() removal
echo 3. Checking eval() removal...
set /a total+=1
findstr /C:"eval(" system\widgets\html_php.php >nul 2>&1
if %errorlevel% neq 0 (
    echo    [OK] Widget files - eval() removed
    set /a passed+=1
) else (
    findstr /C:"// SECURITY: eval() removed" system\widgets\html_php.php >nul 2>&1
    if %errorlevel% equ 0 (
        echo    [OK] Widget files - eval() removed
        set /a passed+=1
    ) else (
        echo    [FAIL] Widget files still contain eval()
    )
)

REM Check 4: Production mode
echo 4. Checking production mode...
set /a total+=1
findstr /C:"\$_app_stage = 'Live'" config.php >nul 2>&1
if %errorlevel% equ 0 (
    echo    [OK] Application set to production mode
    set /a passed+=1
) else (
    echo    [FAIL] Application still in development mode
)

REM Check 5: Default passwords
echo 5. Checking default passwords...
set /a total+=1
findstr /C:"12345678" config.php >nul 2>&1
if %errorlevel% neq 0 (
    echo    [OK] Default password changed
    set /a passed+=1
) else (
    echo    [FAIL] Default password still in use
)

REM Check 6: SSL verification
echo 6. Checking SSL verification...
set /a total+=1
findstr /C:"CURLOPT_SSL_VERIFYPEER, true" system\autoload\MpesaIntegration.php >nul 2>&1
if %errorlevel% equ 0 (
    echo    [OK] SSL verification enabled
    set /a passed+=1
) else (
    echo    [FAIL] SSL verification still disabled
)

REM Check 7: Database indexes
echo 7. Checking database indexes script...
set /a total+=1
if exist "security_performance_indexes.sql" (
    echo    [OK] Database indexes script exists
    set /a passed+=1
) else (
    echo    [FAIL] Database indexes script missing
)

echo.
echo === SUMMARY ===
echo Passed: %passed%/%total% checks
echo.

if %passed% equ %total% (
    echo [SUCCESS] All security fixes verified!
    echo Your system is ready for local testing.
) else (
    echo [WARNING] Some fixes may be missing.
    echo Please review the failed checks above.
)

echo.
pause