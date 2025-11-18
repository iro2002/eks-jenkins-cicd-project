pipeline {
    agent any

    tools {
        maven 'Maven 3.9.11' 
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/iro2002/eks-jenkins-cicd-project.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                        echo "Logging into Docker Hub..."
                        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Remove any existing image (ignore errors if it doesn't exist)
                    sh 'docker rmi irosh2002/maven-web-app:latest || true'
                    
                    // Build the Docker image
                    sh 'docker build -t irosh2002/maven-web-app .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                        echo "Pushing image to Docker Hub..."
                        docker push irosh2002/maven-web-app:latest
                    '''
                }
            }

        }
        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    echo "Applying Kubernetes deployment and service..."
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                '''
            }
        }
    }

    post {
        always {
            echo 'This will always run after the stages finish.'
            // Clean up - logout from Docker Hub
            sh 'docker logout || true'
        }
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed. Please check errors above.'
        }
    }
}