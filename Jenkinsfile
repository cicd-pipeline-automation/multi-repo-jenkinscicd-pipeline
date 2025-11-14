pipeline {

    /************************************************************
     *  AGENT CONFIGURATION
     ************************************************************/
    agent {
        label 'windows'
    }

    /************************************************************
     *  GLOBAL OPTIONS
     ************************************************************/
    options {
        ansiColor('xterm')                  // Colored console output
        timestamps()                         // Timestamp each line in console
        buildDiscarder(logRotator(          // Keep Jenkins clean
            daysToKeepStr: '30',
            numToKeepStr: '20'
        ))
        timeout(time: 30, unit: 'MINUTES')   // Fail fast on stuck pipelines
    }

    /************************************************************
     *  ENVIRONMENT VARIABLES
     ************************************************************/
    environment {
        PIPELINE_SCRIPTS = "C:\\jenkins-pipelines"
        WORKSPACE_DIR    = "C:\\jenkins-workspace"
    }

    /************************************************************
     *  STAGES
     ************************************************************/
    stages {

        stage('📥 Clone Multi Repositories') {
            steps {
                script {
                    echo "Cloning all required repositories into: ${WORKSPACE_DIR}"
                }
                powershell """
                    ${PIPELINE_SCRIPTS}\\clone-multiple-repos.ps1
                """
            }
        }

        stage('🛠 Build Frontend') {
            steps {
                script {
                    echo "Starting frontend build..."
                }
                powershell """
                    ${PIPELINE_SCRIPTS}\\build-frontend.ps1
                """
            }
        }

        stage('⚙️ Build Backend') {
            steps {
                script {
                    echo "Compiling backend application..."
                }
                powershell """
                    ${PIPELINE_SCRIPTS}\\build-backend.ps1
                """
            }
        }

        stage('🚀 Deploy to Server') {
            steps {
                script {
                    echo "Starting Docker build & deployment..."
                }
                powershell """
                    ${PIPELINE_SCRIPTS}\\deploy.ps1
                """
            }
        }
    }

    /************************************************************
     *  POST-ACTIONS (Run even if failure occurs)
     ************************************************************/
    post {

        success {
            echo "🎉 Deployment Completed Successfully!"
        }

        failure {
            echo "❌ Build/Deployment Failed — Check logs!"
        }

        always {
            echo "🧹 Cleaning up workspace..."
            cleanWs()
        }
    }
}
