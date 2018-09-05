pipeline {
   environment{
       registry = "helderklemp/cicd-demo"
       registryCredential = "dockerhub"
       dockerImage = ''
       dockerImageLts = ''
   }
   agent any
   stages {
        stage('Tests') {
	    stage('Static analysis') {
	        steps {
	    	     echo "Static analysis"
	        }
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
                sh "poll_results_from_nexus.sh"
            }
        }

        stage('Update Downstream Apps') {
            steps {
                sh "update_downstream_apps.sh"
            }
        }
    }
    
}
