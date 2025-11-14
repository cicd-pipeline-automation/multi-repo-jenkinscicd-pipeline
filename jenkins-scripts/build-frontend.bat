@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM  FRONTEND BUILD SCRIPT (React / CRA)
REM  Production-Ready Version for Jenkins Windows Agents
REM ============================================================

set FRONTEND_DIR=C:\jenkins-workspace\frontend

echo ============================================================
echo   BUILDING FRONTEND APPLICATION
echo   Directory: %FRONTEND_DIR%
echo ============================================================

REM ---- Navigate to frontend directory ----
cd /d "%FRONTEND_DIR%" || (
    echo [ERROR] Frontend directory not found at: %FRONTEND_DIR%
    exit /b 1
)

REM ---- Install dependencies ----
echo [STEP] Installing Node dependencies...
call npm install
if errorlevel 1 (
    echo [ERROR] npm install failed.
    exit /b 1
)

REM ---- Run CRA build ----
echo [STEP] Running React production build...
call npm run build
if errorlevel 1 (
    echo [ERROR] npm run build failed.
    exit /b 1
)

REM ---- Verify build output exists ----
if not exist "%FRONTEND_DIR%\build" (
    echo [ERROR] Build directory missing after build:
    echo         %FRONTEND_DIR%\build
    exit /b 1
)

echo [SUCCESS] Frontend build completed successfully.
exit /b 0
