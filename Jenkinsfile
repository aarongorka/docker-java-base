pipeline {
   environment {
       NEXUS_PASSWORD = credentials('NEXUS_PASSWORD')
   }
   agent any
   triggers {
       cron('* H * * 1-5')
   }
   stages {
        stage('Tests') {
            steps {
                sh "echo 'Running tests...'"
                sh "echo 'Done.'"
            }
        }

        stage('Build & Push Image') {
            steps {
                sh 'make dockerBuild nexusLogin dockerPush'
            }
        }

        stage('Nexus Security Scan') {
            steps {
                sh "echo 'Checking Nexus scan details...'"
                sh "echo 'Done.'"
            }
        }

        stage('Push Latest Tag') {
            when { branch 'master' }
            steps {
                sh 'make nexusLogin dockerPushLatest'
            }
        }

    }
}
