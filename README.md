# Multi-Repository Jenkins CI/CD – Windows Server Pipeline

This document explains how the **multi-repository Jenkins CI/CD pipeline** works on a **Windows Server**, including the folder structure, scripts, Jenkinsfile behavior, build flow, and deployment strategy.

---

## 🚀 1. Overview

This project provides a **production-ready CI/CD system** that:

- Clones multiple repositories (frontend + backend)
- Builds the frontend (Node.js)
- Builds the backend (Spring Boot using `mvnw.cmd`)
- Builds Docker images
- Deploys containers on Windows Server:
  - Backend → **port 8080**
  - Frontend → **port 3000**

All logic is executed through **PowerShell scripts** for safety and clarity.

---

## 📁 2. Folder Structure on Windows Server

```
C:├── jenkins-pipelines│   ├── clone-multiple-repos.ps1
│   ├── build-frontend.ps1
│   ├── build-backend.ps1
│   ├── deploy.ps1
│
└── jenkins-workspace    ├── frontend\   (cloned automatically)
    └── backend\    (cloned automatically)
```

Scripts are stored in `C:\jenkins-pipelines`  
Repositories are cloned into `C:\jenkins-workspace`

---

## 🔧 3. One-Time Setup on Windows Server

### Install Required Tools

Ensure the following tools are installed and visible in PATH:

- Git
- Node.js + npm
- Java JDK (Temurin recommended)
- Docker Desktop / Docker Engine
- Jenkins agent for Windows (`windows` label)

Test each tool:

```
git --version
node -v
npm -v
java -version
docker --version
```

---

## 🔄 4. Jenkins Pipeline Flow (Step-by-Step)

The Jenkins pipeline calls the PowerShell scripts in order.  
Here is **exactly what happens** during a build.

---

### 4.1 Stage 1 – Clone Multi Repositories

Runs:

```
clone-multiple-repos.ps1
```

This script:

1. Ensures `C:\jenkins-workspace` exists
2. Reads repo list:
   - frontend repo
   - backend repo
3. For each repo:
   - If folder **does not exist** → `git clone`
   - If folder **exists**:
     - `git fetch`
     - `git reset --hard`

**Outcome:**

```
C:\jenkins-workspacerontend
C:\jenkins-workspaceackend
```

Both repos contain latest code from GitHub.

---

### 4.2 Stage 2 – Build Frontend

Runs:

```
build-frontend.ps1
```

This script:

1. Navigates to `C:\jenkins-workspacerontend`
2. Installs dependencies:

```
npm install
```

3. Builds the frontend:

```
npm run build
```

**Outcome:**  
Production frontend bundle generated successfully.

---

### 4.3 Stage 3 – Build Backend

Runs:

```
build-backend.ps1
```

This script:

1. Navigates to `C:\jenkins-workspaceackend`
2. Validates `mvnw.cmd` exists
3. Builds Spring Boot application:

```
mvnw.cmd clean package
```

**Outcome:**  
Spring Boot JAR created in:

```
backend	arget```

---

### 4.4 Stage 4 – Deploy (Docker Build + Run)

Runs:

```
deploy.ps1
```

This script:

1. Builds two images:
   - `frontend-app:latest`
   - `backend-api:latest`

2. Removes old containers (safe operation):
   ```
   docker stop ...
   docker rm ...
   ```

3. Runs new containers:

   - Backend → `http://server:8080`
   - Frontend → `http://server:3000`

**Outcome:**  
Latest versions of both apps are deployed and running via Docker.

---

## 🧹 5. Jenkins Post Steps

The `Jenkinsfile` uses:

```
post {
    success { echo "Deployment Success!" }
    failure { echo "Build Failed!" }
    always  { cleanWs() }
}
```

- Logs results cleanly
- Cleans Jenkins workspace directory (not your machine workspace)
- Keeps Jenkins master clean

---

## 🏁 6. Daily Workflow

1. Developer pushes new code
2. Jenkins pipeline is triggered manually or via webhook
3. Jenkins:
   - Pulls latest repos
   - Builds frontend and backend
   - Builds Docker images
   - Deploys updated containers
4. Applications available at:
   - **Frontend:** `http://server:3000`
   - **Backend:** `http://server:8080`

---

## 🎯 7. Summary

This system gives you:

- Multi-repo support
- Clean separation of CI (Jenkinsfile) and logic (PowerShell scripts)
- Fully automated Docker-based deployment
- Production-ready folder structure
- Easy maintenance and scalability

This is suitable for:
- Multi-service architectures
- Windows Server environments
- Enterprise Jenkins setups
- On‑prem builds

---

## 📞 Need More?

I can also generate:

- Dev → Staging → Prod promotion flow
- Automatic versioning (semantic versioning)
- Git webhooks setup
- Reverse proxy (Nginx/Traefik for Windows Docker)
- Kubernetes version of the pipeline

Just ask!
