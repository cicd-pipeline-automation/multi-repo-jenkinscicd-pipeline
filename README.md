# Multi-Repo CI/CD Pipeline — Complete Setup Guide

## 1. Software Tools Installation

### Required Tools
- **Java 17+** (Backend)
- **Node.js 18 LTS** (Frontend)
- **Maven 3.9+**
- **Git for Windows**
- **Jenkins (Windows)**
- **Nginx (for serving frontend)**
- **Curl (included with Windows 10+)**

### Install Instructions & Version Checks

#### Java
Download: https://adoptium.net  
Check version:
```bash
java -version
```

#### Node.js
Download: https://nodejs.org  
Check version:
```bash
node -v
npm -v
```

#### Maven
Download: https://maven.apache.org  
Check:
```bash
mvn -v
```

#### Git
Download: https://git-scm.com  
Check:
```bash
git --version
```

---

## 2. Environment Variable Setup (Windows)

Add the following to **Environment Variables → System PATH:**

| Tool | Path Example |
|------|--------------|
| Java | `C:\Program Files\Eclipse Foundation\jdk-17\bin` |
| Maven | `C:\apache-maven-3.9.6\bin` |
| Node | `C:\Program Files\nodejs` |
| Git | `C:\Program Files\Git\bin` |

Verify using Command Prompt:
```
echo %PATH%
```

---

## 3. Folder Structure

```
C:/
 ├─ jenkins-scripts/
 │   ├─ clone-multiple-repos.bat
 │   ├─ build-frontend.bat
 │   ├─ build-backend.bat
 │   ├─ deploy-to-server.bat
 │   ├─ start-backend.bat
 │   ├─ start-frontend.bat
 │   ├─ validate-deployment.bat
 │
 ├─ jenkins-workspace/
 │   ├─ frontend/
 │   ├─ backend/
 │
 ├─ deployments/
 │   └─ backend/
 │
 ├─ nginx/
     └─ html/ (Frontend deployment)
```

---

## 4. GitHub Repository Setup

### A. Multi-Repo Pipeline Repository
```
multi-repo-jenkinscicd-pipeline/
 ├── Jenkinsfile
 └── README.md
```

Purpose:
- Stores Jenkinsfile
- Drives CI/CD automation

### B. Frontend Repository (React)
```
frontend-ui/
 ├── public/
 ├── src/
 ├── package.json
 └── README.md
```

### C. Backend Repository (Spring Boot)
```
backend-api/
 ├── src/
 │    ├── main/
 │    │    ├── java/com/example/app/
 │    │    │      ├── HealthController.java
 │    │    │      ├── Application.java
 │    │    └── resources/
 │    │          └── application.properties
 ├── pom.xml
 └── README.md
```

---

## 5. Jenkins Pipeline Stages Explanation

### **1. Clone Repositories**
Runs:
```
clone-multiple-repos.bat
```
Creates:
- `C:\jenkins-workspacerontend`
- `C:\jenkins-workspaceackend`

### **2. Build Frontend**
Steps:
- Install dependencies (`npm install`)
- Compile React build (`npm run build`)
- Output → `build/` folder

### **3. Build Backend**
Steps:
- Maven clean package
- Generate spring-boot JAR
- Output → `target/backend-api-1.0.0.jar`

### **4. Deploy Artifacts**
Copies:
- Backend → `C:\deploymentsackend`
- Frontend → `C:
ginx\html`

### **5. Start Backend Service**
- Kills old java
- Starts new backend on port 8081
- Verifies with `/health`

### **6. Start Frontend**
- Restart nginx OR verify static files

### **7. Validate Deployment**
Frontend check:
```
curl http://localhost/
```
Backend check:
```
curl http://localhost:8081/health
```

---

## 6. Jenkins Scripts Folder Setup

### Step-by-step:
1. Create folder:
```
C:\jenkins-scripts
```

2. Copy all `.bat` scripts:

```
clone-multiple-repos.bat
build-frontend.bat
build-backend.bat
deploy-to-server.bat
start-backend.bat
start-frontend.bat
validate-deployment.bat
```

3. Ensure Jenkins has permission:
```
icacls "C:\jenkins-scripts" /grant Everyone:F
```

4. Reference scripts in Jenkinsfile:
```groovy
bat "C:\jenkins-scripts\build-frontend.bat"
```

---

## 7. Build Process Summary

### Frontend (React)
- Install dependencies
- Build optimized bundle
- Output → `build/`
- Copy to nginx

### Backend (Spring Boot)
- Maven clean, compile, test, package
- Boot JAR created
- Deploy JAR to server
- Start service

---

## 8. Deployment Process Summary

### Backend
- Stop old instance
- Copy new jar
- Start new java process

### Frontend
- Remove old static files
- Copy new build files

---

## 9. Validation Process Summary

### Frontend:
- Check index.html
- Check static/js exists
- Test homepage response with curl

### Backend:
- Hit `/health`
- Expect JSON response confirming service is UP

---

## 10. Final Notes

This documentation gives:
✔ Full environment setup  
✔ Tools installation  
✔ GitHub repo structure  
✔ Jenkinsfile explanation  
✔ Script setup  
✔ Deployment flow  
✔ Validation checklist  

This README can be directly added to your main Git repo.
