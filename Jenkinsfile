pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh './build.sh'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Use withCredentials to access Docker credentials securely
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Login to Docker Hub
                        sh "echo '${DOCKER_PASSWORD}' | docker login -u '${DOCKER_USERNAME}' --password-stdin"
                        
                        def branch = env.GIT_BRANCH
                        if (branch == 'origin/dev') {
                            sh 'docker push josephpatricksoloman/development:latest'
                        } else if (branch == 'origin/main') {
                            sh 'docker tag josephpatricksoloman/development:latest josephpatricksoloman/prod:latest'
                            sh 'docker push josephpatricksoloman/prod:latest'
                        }
                    }
                }
            }
        }
    }
    triggers {
        pollSCM('* * * * *') // Poll SCM every minute
    }
}
