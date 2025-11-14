@echo off
setlocal

REM ============================================================
REM  FRONTEND BUILD SCRIPT
REM ============================================================

set FRONTEND_DIR=C:\jenkins-workspace\frontend

echo ============================================================
echo   BUILDING FRONTEND APPLICATION
echo   Directory: %FRONTEND_DIR%
echo ============================================================

cd /d "%FRONTEND_DIR%"

echo [STEP] Installing Node dependencies...
npm install

echo [STEP] Building frontend bundle...
npm run build

echo [SUCCESS] Frontend build completed.
exit /b 0
