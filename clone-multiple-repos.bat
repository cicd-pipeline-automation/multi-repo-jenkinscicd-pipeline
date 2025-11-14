@echo off
setlocal enabledelayedexpansion

REM ======================================================================
REM   MULTI-REPOSITORY CLONE / UPDATE SCRIPT (Production Ready)
REM   Author: DevOps Team
REM   Purpose: Clone or update multiple Git repositories on Windows Agents
REM ======================================================================

REM ---------------------------
REM  Base workspace directory
REM ---------------------------
set BASE_DIR=C:\jenkins-workspace

REM ---------------------------------------------------------
REM  Repository list (name | branch | url)
REM  Add / remove repositories as needed
REM ---------------------------------------------------------
set REPO1=frontend|main|https://github.com/cicd-pipeline-automation/frontend-ui.git
set REPO2=backend|main|https://github.com/cicd-pipeline-automation/backend-api.git

echo =====================================================================
echo   STARTING MULTI-REPO CLONE / UPDATE PROCESS
echo   TARGET DIRECTORY: %BASE_DIR%
echo =====================================================================

REM -------------------------------
REM  Ensure workspace exists
REM -------------------------------
if not exist "%BASE_DIR%" (
    echo [INFO] Workspace not found. Creating directory...
    mkdir "%BASE_DIR%"
)

cd /d "%BASE_DIR%"

REM ===============================
REM  Process each repository entry
REM ===============================
for %%R in (REPO1 REPO2) do (

    for /f "tokens=1,2,3 delims=|" %%a in ("!%%R!") do (
        set NAME=%%a
        set BRANCH=%%b
        set URL=%%c

        echo ---------------------------------------------------------------------
        echo   Processing Repository: !NAME!
        echo   Branch: !BRANCH!
        echo   URL: !URL!
        echo ---------------------------------------------------------------------

        set TARGET=%BASE_DIR%\!NAME!

        REM ======================
        REM  Repository exists?
        REM ======================
        if exist "!TARGET!" (
            echo [INFO] Updating existing repository...
            cd /d "!TARGET!"
            git fetch --all
            git reset --hard origin/!BRANCH!
            echo [SUCCESS] Updated repository: !NAME!
        ) else (
            echo [INFO] Cloning repository for first time...
            git clone -b !BRANCH! !URL! "!TARGET!"
            echo [SUCCESS] Cloned repository: !NAME!
        )

        echo.
    )
)

echo =====================================================================
echo   ALL REPOSITORIES SUCCESSFULLY CLONED OR UPDATED
echo =====================================================================

endlocal
exit /b 0
