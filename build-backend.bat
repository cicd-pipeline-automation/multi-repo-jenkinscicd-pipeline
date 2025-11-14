@echo off
setlocal

REM ============================================================
REM  BACKEND BUILD SCRIPT
REM ============================================================

set BACKEND_DIR=C:\jenkins-workspace\backend

echo ============================================================
echo   BUILDING BACKEND APPLICATION
echo   Directory: %BACKEND_DIR%
echo ============================================================

cd /d "%BACKEND_DIR%"

echo [STEP] Running Maven build...
call mvn clean package -DskipTests

echo [SUCCESS] Backend build completed.
exit /b 0
