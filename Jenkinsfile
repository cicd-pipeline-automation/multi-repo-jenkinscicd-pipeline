pipeline {
    agent any

    stages {

        stage('Clone Repositories') {
            steps {
                echo "Cloning frontend-ui & backend-api..."
                bat "C:\\jenkins-scripts\\clone-multiple-repos.bat"
            }
        }

        stage('Build Frontend') {
            steps {
                echo "Building React frontend..."
                bat "C:\\jenkins-scripts\\build-frontend.bat"
            }
        }

        stage('Build Backend') {
            steps {
                echo "Building Spring Boot backend..."
                bat "C:\\jenkins-scripts\\build-backend.bat"
            }
        }

        stage('Deploy to Server') {
            steps {
                echo "Deploying application artifacts..."
                bat "C:\\jenkins-scripts\\deploy-to-server.bat"
            }
        }

        stage('Start Backend Service') {
            steps {
                echo "Starting backend Spring Boot service..."
                bat "C:\\jenkins-scripts\\start-backend.bat"
            }
        }

        stage('Start Frontend Service') {
            steps {
                echo "Starting frontend (static build on Nginx)..."
                bat "C:\\jenkins-scripts\\start-frontend.bat"
            }
        }

        stage('Validate Deployment') {
            steps {
                echo "Validating backend and frontend availability..."
                bat "C:\\jenkins-scripts\\validate-deployment.bat"
            }
        }
    }

    post {
        success {
            echo "🎉 BUILD & DEPLOYMENT SUCCESSFUL — All systems healthy!"
        }
        failure {
            echo "❌ Deployment FAILED — Check logs!"
        }
    }
}
