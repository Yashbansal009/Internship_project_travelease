// Shared Jenkins Groovy function for deployment pipeline
def call(Map config = [:]) {
    pipeline {
        agent any
        stages {
            stage('Checkout') {
                steps {
                    checkout scm
                }
            }
            stage('Build') {
                steps {
                    echo "Building ${config.serviceName}..."
                }
            }
            stage('Test') {
                steps {
                    echo "Testing ${config.serviceName}..."
                }
            }
            stage('Deploy') {
                steps {
                    echo "Deploying ${config.serviceName}..."
                }
            }
        }
        post {
            always {
                echo 'Pipeline finished.'
            }
            failure {
                echo 'Pipeline failed.'
            }
        }
    }
}
