pipeline {
    agent any

    environment {
        IMAGE_TAG = ''
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    def branchName = "${env.GIT_BRANCH}".replace("origin/", "")
                    echo "Current branch: ${branchName}"

                    // Set the IMAGE_TAG based on the branch
                    if (branchName == 'dev') {
                        IMAGE_TAG = "josephpatricksoloman/development:1.1"
                    } else if (branchName == 'main') {
                        IMAGE_TAG = "josephpatricksoloman/prod:latest"
                    } else {
                        error "Branch ${branchName} is not supported for Docker push."
                    }

                    // Checkout the branch
                    git branch: branchName, url: 'https://github.com/josephpatricksoloman/ProjectG.git'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Run build script and build Docker image
                    sh 'bash build.sh'
                    sh 'docker build -t web .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Determine if we need to push to prod
                    if (env.GIT_BRANCH == 'main' && env.CHANGE_ID) {
                        echo "Detected merge from dev to main, pushing to production."
                        IMAGE_TAG = "josephpatricksoloman/prod:latest"
                    }

                    echo "Pushing image with tag: ${IMAGE_TAG}"

                    // Tag and push the image
                    sh "docker tag web ${IMAGE_TAG}"

                    withCredentials([usernamePassword(credentialsId: 'jose_dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"
                        sh "docker push ${IMAGE_TAG}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}