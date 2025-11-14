<#
===============================================================
   PRODUCTION-GRADE FRONTEND BUILD SCRIPT (Windows)
===============================================================
#>

# -----------------------------
#  LOGGING FUNCTIONS
# -----------------------------
function Log-Info($msg) {
    Write-Host "[INFO]    $msg" -ForegroundColor Cyan
}

function Log-Success($msg) {
    Write-Host "[SUCCESS] $msg" -ForegroundColor Green
}

function Log-Warn($msg) {
    Write-Host "[WARNING] $msg" -ForegroundColor Yellow
}

function Log-Error($msg) {
    Write-Host "[ERROR]   $msg" -ForegroundColor Red
}


# -----------------------------
#  CONFIGURABLE VARIABLES
# -----------------------------
$FRONTEND_PATH = "C:\jenkins-workspace\frontend"


# -----------------------------
#  CHECK NODE & NPM INSTALLED
# -----------------------------
if (!(Get-Command node.exe -ErrorAction SilentlyContinue)) {
    Log-Error "Node.js is not installed or not in PATH."
    exit 1
}

if (!(Get-Command npm.cmd -ErrorAction SilentlyContinue)) {
    Log-Error "NPM is not installed or not in PATH."
    exit 1
}


Log-Info "=== Starting Frontend Build Process ==="


# -----------------------------
#  VALIDATE FRONTEND FOLDER
# -----------------------------
if (!(Test-Path $FRONTEND_PATH)) {
    Log-Error "Frontend folder not found: $FRONTEND_PATH"
    exit 1
}

Set-Location $FRONTEND_PATH


# -----------------------------
#  NPM INSTALL
# -----------------------------
try {
    Log-Info "Installing dependencies..."
    npm install
    Log-Success "Dependencies installed successfully."
}
catch {
    Log-Error "Failed to install npm dependencies."
    exit 1
}


# -----------------------------
#  FRONTEND BUILD
# -----------------------------
try {
    Log-Info "Running frontend build..."
    npm run build
    Log-Success "Frontend build completed successfully!"
}
catch {
    Log-Error "Frontend build failed."
    exit 1
}


Log-Success "=== Frontend Build Process Completed Successfully ==="
