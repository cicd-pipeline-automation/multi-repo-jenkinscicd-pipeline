function Log-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Log-Success($msg) { Write-Host "[SUCCESS] $msg" -ForegroundColor Green }

$FRONTEND_PATH="C:\jenkins-workspace\frontend"
$BACKEND_PATH="C:\jenkins-workspace\backend"

docker build -t frontend-app:latest $FRONTEND_PATH
docker build -t backend-api:latest $BACKEND_PATH

docker stop frontend-app backend-api 2>$null
docker rm frontend-app backend-api 2>$null

docker run -d --name backend-api -p 8080:8080 backend-api:latest
docker run -d --name frontend-app -p 3000:80 frontend-app:latest

Log-Success "Deployment completed!"
