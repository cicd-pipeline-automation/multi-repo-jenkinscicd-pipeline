<#
===============================================================
   PRODUCTION-GRADE BACKEND BUILD SCRIPT (Windows)
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
$BACKEND_PATH = "C:\jenkins-workspace\backend"
$MAVEN_WRAPPER = Join-Path $BACKEND_PATH "mvnw.cmd"


Log-Info "=== Starting Backend Build Process ==="


# -----------------------------
#  VALIDATE BACKEND DIRECTORY
# -----------------------------
if (!(Test-Path $BACKEND_PATH)) {
    Log-Error "Backend folder not found: $BACKEND_PATH"
    exit 1
}

Set-Location $BACKEND_PATH


# -----------------------------
#  VALIDATE JAVA INSTALLATION
# -----------------------------
if (!(Get-Command java.exe -ErrorAction SilentlyContinue)) {
    Log-Error "Java is not installed or not found in PATH."
    exit 1
}


# -----------------------------
#  VALIDATE MAVEN WRAPPER
# -----------------------------
if (!(Test-Path $MAVEN_WRAPPER)) {
    Log-Error "mvnw.cmd (Maven Wrapper) not found at: $MAVEN_WRAPPER"
    exit 1
}


# -----------------------------
#  CLEAN & PACKAGE THE BACKEND
# -----------------------------
try {
    Log-Info "Running Maven build: clean + package"
    & $MAVEN_WRAPPER clean package
    Log-Success "Backend build completed successfully!"
}
catch {
    Log-Error "Backend build failed."
    exit 1
}


Log-Success "=== Backend Build Process Completed Successfully ==="
