<#
===============================================================
   PRODUCTION-GRADE BACKEND BUILD SCRIPT
===============================================================
#>

function Log-Info($msg) { Write-Host "[INFO]    $msg" -ForegroundColor Cyan }
function Log-Success($msg) { Write-Host "[SUCCESS] $msg" -ForegroundColor Green }
function Log-Error($msg) { Write-Host "[ERROR]   $msg" -ForegroundColor Red }

$BACKEND_PATH = "C:\jenkins-workspace\backend"
$MAVEN_WRAPPER = Join-Path $BACKEND_PATH "mvnw.cmd"

if (!(Test-Path $BACKEND_PATH)) {
    Log-Error "Backend folder not found: $BACKEND_PATH"
    exit 1
}

if (!(Test-Path $MAVEN_WRAPPER)) {
    Log-Error "Maven wrapper not found: $MAVEN_WRAPPER"
    exit 1
}

Set-Location $BACKEND_PATH

Log-Info "Building backend using Maven wrapper..."
& $MAVEN_WRAPPER clean package

Log-Success "Backend build completed successfully!"
