import jenkins.model.*
jenkins = Jenkins.instance
pipeline {
   environment{
       registry = "nexus:18443/docker-java-base"
       registryCredential = "dockerhub"
       dockerImage = ''
       dockerImageLts = ''
   }
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
                echo "Build Docker image"
                script{
                    dockerImage = docker.build registry + ":${BUILD_NUMBER}"
                    dockerImageLts = docker.build registry + ":latest"
                }
                
            }
        }

        stage('Push Image') {
            when {
                branch 'master'
            }
            steps {
                script{
                    docker.withRegistry ('', registryCredential){
                        dockerImage.push()
                        dockerImageLts.push()
                    }
                     
                }
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
