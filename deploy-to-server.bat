@echo off
setlocal

REM ============================================================
REM  DEPLOYMENT SCRIPT
REM  Customize paths based on server infra
REM ============================================================

set FRONTEND_DIST=C:\jenkins-workspace\frontend\dist
set BACKEND_JAR=C:\jenkins-workspace\backend\target\backend.jar

set FRONTEND_TARGET=C:\nginx\html
set BACKEND_TARGET=C:\deployments\backend

echo ============================================================
echo   STARTING DEPLOYMENT
echo ============================================================

echo [STEP] Deploying backend JAR...
copy "%BACKEND_JAR%" "%BACKEND_TARGET%" /Y

echo [STEP] Deploying frontend static files...
xcopy "%FRONTEND_DIST%\*" "%FRONTEND_TARGET%\" /E /Y

echo [SUCCESS] Deployment completed successfully.
exit /b 0
