@echo off
setlocal

REM ============================================================
REM  FRONTEND BUILD SCRIPT (React / CRA)
REM ============================================================

set FRONTEND_DIR=C:\jenkins-workspace\frontend

echo ============================================================
echo   BUILDING FRONTEND APPLICATION
echo   Directory: %FRONTEND_DIR%
echo ============================================================

cd /d "%FRONTEND_DIR%" || (
    echo [ERROR] Frontend directory not found.
    exit /b 1
)

echo [STEP] Installing Node dependencies...
npm install
if errorlevel 1 (
    echo [ERROR] npm install failed.
    exit /b 1
)

echo [STEP] Running React build...
npm run build
if errorlevel 1 (
    echo [ERROR] npm run build failed.
    exit /b 1
)

if not exist "%FRONTEND_DIR%\build" (
    echo [ERROR] Frontend build directory not found after build.
    exit /b 1
)

echo [SUCCESS] Frontend build completed.
exit /b 0
