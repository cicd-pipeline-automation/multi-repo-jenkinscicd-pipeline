<#
===============================================================
   PRODUCTION-GRADE MULTI-REPO CLONE SCRIPT (Windows)
===============================================================
#>

function Log-Info($msg) { Write-Host "[INFO]    $msg" -ForegroundColor Cyan }
function Log-Success($msg) { Write-Host "[SUCCESS] $msg" -ForegroundColor Green }
function Log-Warn($msg) { Write-Host "[WARNING] $msg" -ForegroundColor Yellow }
function Log-Error($msg) { Write-Host "[ERROR]   $msg" -ForegroundColor Red }

$BASE_FOLDER = "C:\jenkins-workspace"

$REPOS = @(
    @{ Name = "frontend"; Url = "https://github.com/cicd-pipeline-automation/frontend-ui.git"; Branch = "main" },
    @{ Name = "backend";  Url = "https://github.com/cicd-pipeline-automation/backend-api.git"; Branch = "main" }
)

Log-Info "=== Starting Multi-Repository Clone Process ==="

if (!(Test-Path $BASE_FOLDER)) {
    Log-Warn "Workspace not found, creating: $BASE_FOLDER"
    New-Item -ItemType Directory -Path $BASE_FOLDER | Out-Null
}

Set-Location $BASE_FOLDER

foreach ($repo in $REPOS) {

    $TARGET_PATH = Join-Path $BASE_FOLDER $repo.Name

    Log-Info "Processing repository: $($repo.Name)"

    try {

        if (Test-Path $TARGET_PATH) {

            Log-Warn "Repository exists — pulling latest changes..."
            Set-Location $TARGET_PATH
            git fetch --all
            git reset --hard ("origin/" + $repo.Branch)
            Log-Success "Updated repository: $($repo.Name)"

        }
        else {

            Log-Info "Cloning repository..."
            git clone -b $repo.Branch $repo.Url $TARGET_PATH
            Log-Success "Cloned repository: $($repo.Name)"

        }

    }
    catch {

        Log-Error "Failed processing repository: $($repo.Name)"
        exit 1

    }

}

##Log-Success "All Repositories Successfully Cloned/Updated"
