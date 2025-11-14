pipeline {

    /************************************************************
     *  AGENT CONFIGURATION
     ************************************************************/
    agent any

    /************************************************************
     *  GLOBAL OPTIONS
     ************************************************************/
    options {
        ansiColor('xterm')                   // Enable colored output
        timestamps()                          // Add timestamps to logs
        buildDiscarder(logRotator(
            daysToKeepStr: '30',
            numToKeepStr: '20'
        ))
        timeout(time: 30, unit: 'MINUTES')    // Protect against stuck builds
    }

    /************************************************************
     *  ENVIRONMENT VARIABLES
     ************************************************************/
    environment {
        PIPELINE_SCRIPTS = "C:\\jenkins-scripts"
        WORKSPACE_DIR    = "C:\\jenkins-workspace"
    }

    /************************************************************
     *  STAGES
     ************************************************************/
    stages {

        stage('Clone Multi Repositories') {
            steps {
                script {
                    echo "Starting clone operations into: ${WORKSPACE_DIR}"
                }
                powershell """
                    & "${PIPELINE_SCRIPTS}\\clone-multiple-repos.ps1"
                """
            }
        }

        stage('Build Frontend') {
            steps {
                script {
                    echo "Running frontend build..."
                }
                powershell """
                    & "${PIPELINE_SCRIPTS}\\build-frontend.ps1"
                """
            }
        }

        stage('Build Backend') {
            steps {
                script {
                    echo "Running backend Maven build..."
                }
                powershell """
                    & "${PIPELINE_SCRIPTS}\\build-backend.ps1"
                """
            }
        }

        stage('Deploy to Server') {
            steps {
                script {
                    echo "Executing Docker deployment..."
                }
                powershell """
                    & "${PIPELINE_SCRIPTS}\\deploy.ps1"
                """
            }
        }
    }

    /************************************************************
     *  POST-ACTIONS
     ************************************************************/
    post {

        success {
            echo "Deployment Completed Successfully!"
        }

        failure {
            echo "Build/Deployment Failed — Check logs!"
        }
    }
}
