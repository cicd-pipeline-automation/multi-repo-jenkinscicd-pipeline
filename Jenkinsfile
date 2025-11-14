pipeline {
    agent any

    stages {

        stage('Clone Repositories') {
            steps {
                bat "C:\\jenkins-scripts\\clone-multiple-repos.bat"
            }
        }

        stage('Build Frontend') {
            steps {
                bat "C:\\jenkins-scripts\\build-frontend.bat"
            }
        }

        stage('Build Backend') {
            steps {
                bat "C:\\jenkins-scripts\\build-backend.bat"
            }
        }

        stage('Deploy to Server') {
            steps {
                bat "C:\\jenkins-scripts\\deploy-to-server.bat"
            }
        }

    }

    post {
        success {
            echo "BUILD & DEPLOYMENT SUCCESSFUL"
        }
        failure {
            echo "BUILD FAILED — CHECK LOGS"
        }
    }
}
