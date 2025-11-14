@echo off
setlocal

REM ============================================================
REM  START BACKEND SPRING BOOT SERVICE  (Jenkins-safe)
REM ============================================================

set BACKEND_JAR=C:\deployments\backend\backend-api-1.0.0.jar
set BACKEND_PORT=8081

echo ============================================================
echo   STARTING BACKEND SERVICE
echo   JAR: %BACKEND_JAR%
echo   PORT: %BACKEND_PORT%
echo ============================================================

if not exist "%BACKEND_JAR%" (
    echo [ERROR] Backend JAR not found!
    exit /b 1
)

echo [STEP] Killing old backend instance...
taskkill /F /IM java.exe >NUL 2>&1

echo [STEP] Starting backend in background...
start "" cmd /c "java -jar %BACKEND_JAR% --server.port=%BACKEND_PORT%"

echo [STEP] Waiting for backend to become healthy...

set retries=0

:waitloop
curl -s --connect-timeout 2 -o NUL http://localhost:%BACKEND_PORT%/health
if %errorlevel%==0 (
    echo [SUCCESS] Backend is UP!
    exit /b 0
)

set /a retries+=1
if %retries% geq 20 (
    echo [ERROR] Backend failed to start after 40 seconds.
    exit /b 1
)

timeout /t 2 >NUL
goto waitloop
