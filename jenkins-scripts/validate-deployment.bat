@echo off
setlocal

REM ============================================================
REM  VALIDATE FRONTEND + BACKEND DEPLOYMENT  (Jenkins-safe)
REM ============================================================

echo ============================================================
echo   VALIDATING DEPLOYMENT
echo ============================================================

REM ------------------------------
REM Validate Frontend
REM ------------------------------
echo [STEP] Checking frontend...

set FRONTEND_DIR=C:\nginx\html

if not exist "%FRONTEND_DIR%\index.html" (
    echo [ERROR] index.html missing in frontend deployment.
    exit /b 1
)

REM Use -s (silent) and -o NUL (discard output) for Jenkins-safe curl
curl -s -o NUL http://localhost/
if %errorlevel% neq 0 (
    echo [ERROR] Frontend HTTP check failed.
    exit /b 1
)

echo [OK] Frontend is responding.


REM ------------------------------
REM Validate Backend
REM ------------------------------
echo [STEP] Checking backend...

curl -s -o NUL http://localhost:8081/health
if %errorlevel% neq 0 (
    echo [ERROR] Backend /health failed.
    exit /b 1
)

echo [OK] Backend is responding.


echo ============================================================
echo   ALL DEPLOYMENT VALIDATIONS PASSED
echo ============================================================
exit /b 0
