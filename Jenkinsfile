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
                    def branch = env.GIT_BRANCH
                    // Login to Docker Hub
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                    
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
    triggers {
        pollSCM('* * * * *') // Poll SCM every minute
    }
}
