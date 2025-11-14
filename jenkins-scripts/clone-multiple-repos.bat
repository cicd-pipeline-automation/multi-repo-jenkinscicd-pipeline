@echo off
setlocal enabledelayedexpansion

REM ======================================================================
REM   MULTI-REPOSITORY CLONE / UPDATE SCRIPT (Production Ready - Jenkins Safe)
REM ======================================================================

set BASE_DIR=C:\jenkins-workspace

REM Define repos
set REPO1_NAME=frontend
set REPO1_BRANCH=main
set REPO1_URL=https://github.com/cicd-pipeline-automation/frontend-ui.git

set REPO2_NAME=backend
set REPO2_BRANCH=main
set REPO2_URL=https://github.com/cicd-pipeline-automation/backend-api.git

echo =====================================================================
echo   STARTING MULTI-REPO CLONE / UPDATE PROCESS
echo =====================================================================

if not exist "%BASE_DIR%" (
    echo Creating base directory...
    mkdir "%BASE_DIR%"
)

cd /d "%BASE_DIR%"

REM =====================================================================
REM Process Repository 1
REM =====================================================================
call :processRepo "%REPO1_NAME%" "%REPO1_BRANCH%" "%REPO1_URL%"

REM =====================================================================
REM Process Repository 2
REM =====================================================================
call :processRepo "%REPO2_NAME%" "%REPO2_BRANCH%" "%REPO2_URL%"

echo =====================================================================
echo   ALL REPOSITORIES SUCCESSFULLY CLONED/UPDATED
echo =====================================================================
exit /b 0


REM =====================================================================
REM  FUNCTION: processRepo
REM =====================================================================
:processRepo
set NAME=%~1
set BRANCH=%~2
set URL=%~3
set TARGET=%BASE_DIR%\%NAME%

echo ------------------------------------------------------------
echo Processing Repository: %NAME%
echo Branch: %BRANCH%
echo URL: %URL%
echo ------------------------------------------------------------

if exist "%TARGET%" (
    echo Updating existing repo...
    cd /d "%TARGET%"
    git fetch --all
    git reset --hard origin/%BRANCH%
    echo [SUCCESS] Updated %NAME%
) else (
    echo Cloning fresh repo...
    git clone -b %BRANCH% %URL% "%TARGET%"
    echo [SUCCESS] Cloned %NAME%
)

echo.
exit /b 0
