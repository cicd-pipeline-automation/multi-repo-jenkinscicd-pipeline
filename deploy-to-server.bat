@echo off
setlocal

REM ============================================================
REM  DEPLOYMENT SCRIPT
REM ============================================================

set FRONTEND_DIST=C:\jenkins-workspace\frontend\build
set BACKEND_JAR=C:\jenkins-workspace\backend\target\backend-api-1.0.0.jar

set FRONTEND_TARGET=C:\nginx\html
set BACKEND_TARGET=C:\deployments\backend

echo ============================================================
echo   STARTING DEPLOYMENT
echo ============================================================

REM ---------- Backend ----------
if not exist "%BACKEND_JAR%" (
    echo [ERROR] Backend JAR not found:
    echo         %BACKEND_JAR%
    exit /b 1
)

if not exist "%BACKEND_TARGET%" (
    echo [INFO] Creating backend deploy directory: %BACKEND_TARGET%
    mkdir "%BACKEND_TARGET%" || (
        echo [ERROR] Failed to create backend target directory.
        exit /b 1
    )
)

echo [STEP] Deploying backend JAR...
copy "%BACKEND_JAR%" "%BACKEND_TARGET%" /Y
if errorlevel 1 (
    echo [ERROR] Failed to copy backend JAR.
    exit /b 1
)

REM ---------- Frontend ----------
if not exist "%FRONTEND_DIST%" (
    echo [ERROR] Frontend build directory not found:
    echo         %FRONTEND_DIST%
    exit /b 1
)

if not exist "%FRONTEND_TARGET%" (
    echo [INFO] Creating frontend deploy directory: %FRONTEND_TARGET%
    mkdir "%FRONTEND_TARGET%" || (
        echo [ERROR] Failed to create frontend target directory.
        exit /b 1
    )
)

echo [STEP] Deploying frontend static files...
xcopy "%FRONTEND_DIST%\*" "%FRONTEND_TARGET%\" /E /Y
if errorlevel 1 (
    echo [ERROR] Failed to copy frontend files.
    exit /b 1
)

echo [SUCCESS] Deployment completed successfully.
exit /b 0
