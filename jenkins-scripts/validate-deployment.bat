@echo off
setlocal

REM ============================================================
REM  VALIDATE FRONTEND + BACKEND DEPLOYMENT
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

curl http://localhost --silent --fail >NUL
if %errorlevel% neq 0 (
    echo [ERROR] Frontend HTTP check failed.
    exit /b 1
)

echo [OK] Frontend is responding.


REM ------------------------------
REM Validate Backend
REM ------------------------------
echo [STEP] Checking backend...

curl http://localhost:8080/health --silent --fail >NUL
if %errorlevel% neq 0 (
    echo [ERROR] Backend /health failed.
    exit /b 1
)

echo [OK] Backend is responding.

echo ============================================================
echo   ALL DEPLOYMENT VALIDATIONS PASSED
echo ============================================================
exit /b 0
