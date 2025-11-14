@echo off
setlocal

REM ============================================================
REM  BACKEND BUILD SCRIPT (Spring Boot)
REM ============================================================

set BACKEND_DIR=C:\jenkins-workspace\backend

echo ============================================================
echo   BUILDING BACKEND APPLICATION
echo   Directory: %BACKEND_DIR%
echo ============================================================

cd /d "%BACKEND_DIR%" || (
    echo [ERROR] Backend directory not found.
    exit /b 1
)

echo [STEP] Running Maven build...
call mvn clean package -DskipTests
if errorlevel 1 (
    echo [ERROR] Maven build failed.
    exit /b 1
)

REM Adjust name if you change artifactId/version in pom.xml
set JAR_PATH=%BACKEND_DIR%\target\backend-api-1.0.0.jar

if not exist "%JAR_PATH%" (
    echo [ERROR] Expected JAR not found at:
    echo         %JAR_PATH%
    dir "%BACKEND_DIR%\target"
    exit /b 1
)

echo [SUCCESS] Backend build completed.
exit /b 0
