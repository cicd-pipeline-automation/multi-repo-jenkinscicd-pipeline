function Log-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Log-Success($msg) { Write-Host "[SUCCESS] $msg" -ForegroundColor Green }
function Log-Error($msg) { Write-Host "[ERROR] $msg" -ForegroundColor Red }

$BACKEND_PATH = "C:\jenkins-workspace\backend"
$MAVEN = Join-Path $BACKEND_PATH "mvnw.cmd"

if (!(Test-Path $BACKEND_PATH)) { Log-Error "Backend folder not found"; exit 1 }
if (!(Test-Path $MAVEN)) { Log-Error "mvnw.cmd missing"; exit 1 }

Set-Location $BACKEND_PATH
Log-Info "Running Maven build..."
& $MAVEN clean package
Log-Success "Backend build completed!"
