<#
===============================================================
  PRODUCTION-GRADE DOCKER BUILD & DEPLOY SCRIPT (Windows)
===============================================================
#>

# Enable colored output
$Host.UI.RawUI.ForegroundColor = "White"

function Log-Info($msg) {
    Write-Host "[INFO]  $msg" -ForegroundColor Cyan
}

function Log-Success($msg) {
    Write-Host "[SUCCESS] $msg" -ForegroundColor Green
}

function Log-Warn($msg) {
    Write-Host "[WARNING] $msg" -ForegroundColor Yellow
}

function Log-Error($msg) {
    Write-Host "[ERROR] $msg" -ForegroundColor Red
}


# ===============================================================
# CONFIGURABLE VARIABLES
# ===============================================================
$FRONTEND_PATH = "C:\jenkins-workspace\frontend"
$BACKEND_PATH  = "C:\jenkins-workspace\backend"

$FRONTEND_IMAGE = "frontend-app:latest"
$BACKEND_IMAGE  = "backend-api:latest"

$FRONTEND_CONTAINER = "frontend-app"
$BACKEND_CONTAINER  = "backend-api"


Log-Info "=== Starting Docker Build & Deployment ==="


# ===============================================================
# BUILD DOCKER IMAGES
# ===============================================================
try {
    Log-Info "Building Frontend Image: $FRONTEND_IMAGE"
    docker build -t $FRONTEND_IMAGE $FRONTEND_PATH
    Log-Success "Frontend image built successfully."

    Log-Info "Building Backend Image: $BACKEND_IMAGE"
    docker build -t $BACKEND_IMAGE $BACKEND_PATH
    Log-Success "Backend image built successfully."
}
catch {
    Log-Error "Docker image build failed."
    exit 1
}


# ===============================================================
# STOP & REMOVE EXISTING CONTAINERS (IDEMPOTENT)
# ===============================================================
function Stop-And-Remove($containerName) {
    Log-Warn "Removing existing container: $containerName"

    docker stop $containerName 2>$null
    docker rm $containerName 2>$null

    Log-Success "Container removed: $containerName"
}

Stop-And-Remove $FRONTEND_CONTAINER
Stop-And-Remove $BACKEND_CONTAINER


# ===============================================================
# RUN NEW UPDATED CONTAINERS
# ===============================================================
try {
    Log-Info "Starting Backend Container..."
    docker run -d `
        --name $BACKEND_CONTAINER `
        -p 8080:8080 `
        $BACKEND_IMAGE
    Log-Success "Backend API deployed successfully on port 8080."

    Log-Info "Starting Frontend Container..."
    docker run -d `
        --name $FRONTEND_CONTAINER `
        -p 3000:80 `
        $FRONTEND_IMAGE
    Log-Success "Frontend App deployed successfully on port 3000."
}
catch {
    Log-Error "Deployment failed while running Docker containers."
    exit 1
}


Log-Success "=== Deployment Completed Successfully ==="
