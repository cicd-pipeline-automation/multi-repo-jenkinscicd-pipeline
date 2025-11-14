@echo off
setlocal

REM ============================================================
REM  START FRONTEND SERVER (React Build on Nginx or Static Hosting)
REM ============================================================

set FRONTEND_DIR=C:\nginx\html

echo ============================================================
echo   STARTING FRONTEND SERVICE
echo   Directory: %FRONTEND_DIR%
echo ============================================================

REM Validate frontend files
if not exist "%FRONTEND_DIR%\index.html" (
    echo [ERROR] Frontend index.html missing.
    exit /b 1
)

if not exist "%FRONTEND_DIR%\static\js" (
    echo [ERROR] Frontend static JS folder missing.
    exit /b 1
)

echo [OK] Frontend files appear valid.

REM If Nginx is installed as a Windows service:
sc query nginx >NUL 2>&1
if %errorlevel%==0 (
    echo Restarting Nginx service...
    sc stop nginx >NUL
    sc start nginx >NUL
    echo [SUCCESS] Nginx started.
) else (
    echo [INFO] Nginx not running as service. Assuming static hosting only.
)

exit /b 0
