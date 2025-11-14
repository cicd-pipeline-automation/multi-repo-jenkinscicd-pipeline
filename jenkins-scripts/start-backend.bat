@echo off
setlocal

REM ============================================================
REM  START BACKEND SPRING BOOT SERVICE
REM ============================================================

set BACKEND_JAR=C:\deployments\backend\backend-api-1.0.0.jar

echo ============================================================
echo   STARTING BACKEND SERVICE
echo   JAR: %BACKEND_JAR%
echo ============================================================

if not exist "%BACKEND_JAR%" (
    echo [ERROR] Backend JAR not found!
    exit /b 1
)

echo [STEP] Killing old backend instance...
taskkill /F /IM java.exe >NUL 2>&1

echo [STEP] Starting backend in background...
start "" cmd /c "java -jar %BACKEND_JAR%"

echo [STEP] Waiting for backend to become healthy...

set retries=0
:waitloop
curl http://localhost:8080/health --silent --fail >NUL
if %errorlevel%==0 (
    echo [SUCCESS] Backend is UP!
    exit /b 0
)

set /a retries+=1
if %retries% GEQ 20 (
    echo [ERROR] Backend failed to start after 40 seconds.
    exit /b 1
)

timeout /t 2 >NUL
goto waitloop
