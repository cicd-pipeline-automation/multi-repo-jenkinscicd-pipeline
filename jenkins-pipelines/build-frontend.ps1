<#
===============================================================
   PRODUCTION-GRADE FRONTEND BUILD SCRIPT
===============================================================
#>

function Log-Info($msg) { Write-Host "[INFO]    $msg" -ForegroundColor Cyan }
function Log-Success($msg) { Write-Host "[SUCCESS] $msg" -ForegroundColor Green }
function Log-Error($msg) { Write-Host "[ERROR]   $msg" -ForegroundColor Red }

$FRONTEND_PATH = "C:\jenkins-workspace\frontend"

if (!(Test-Path $FRONTEND_PATH)) {
    Log-Error "Frontend folder not found: $FRONTEND_PATH"
    exit 1
}

Set-Location $FRONTEND_PATH

Log-Info "Installing dependencies..."
npm install

Log-Info "Building frontend..."
npm run build

Log-Success "Frontend build completed successfully!"
