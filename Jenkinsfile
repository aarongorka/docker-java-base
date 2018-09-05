pipeline {
   agent any
   stages {
        stage('Tests') {
            steps {
                sh "echo 'Running tests...'"
                sh "echo 'Done.'"
            }
        }

        stage('Build Image') {
            steps {
                sh 'make dockerBuild'
            }
        }

        stage('Push Image') {
            steps {
                sh 'make dockerPush'
            }
        }

        stage('Nexus Security Scan') {
            steps {
                sh "echo 'Checking Nexus scan details...'"
                sh "echo 'Done.'"
            }
        }

        stage('Update Downstream Apps') {
            steps {
                sh "echo 'Updating downstream apps...'"
                sh "echo 'Done.'"
            }
        }
    }
    
}
