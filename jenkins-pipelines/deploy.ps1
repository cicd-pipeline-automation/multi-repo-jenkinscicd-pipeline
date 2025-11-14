<#
===============================================================
   PRODUCTION-GRADE DOCKER DEPLOY SCRIPT
===============================================================
#>

function Log-Info($msg) { Write-Host "[INFO]    $msg" -ForegroundColor Cyan }
function Log-Success($msg) { Write-Host "[SUCCESS] $msg" -ForegroundColor Green }
function Log-Warn($msg) { Write-Host "[WARNING] $msg" -ForegroundColor Yellow }
function Log-Error($msg) { Write-Host "[ERROR]   $msg" -ForegroundColor Red }

$FRONTEND_PATH = "C:\jenkins-workspace\frontend"
$BACKEND_PATH = "C:\jenkins-workspace\backend"

$FRONTEND_IMAGE = "frontend-app:latest"
$BACKEND_IMAGE = "backend-api:latest"

Log-Info "Building Docker images..."

docker build -t $FRONTEND_IMAGE $FRONTEND_PATH
docker build -t $BACKEND_IMAGE $BACKEND_PATH

Log-Info "Stopping and removing old containers..."

docker stop frontend-app backend-api 2>$null
docker rm frontend-app backend-api 2>$null

Log-Info "Starting backend container..."
docker run -d --name backend-api -p 8080:8080 $BACKEND_IMAGE

Log-Info "Starting frontend container..."
docker run -d --name frontend-app -p 3000:80 $FRONTEND_IMAGE

Log-Success "Deployment completed successfully!"
