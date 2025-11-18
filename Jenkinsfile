pipeline {
    agent any

    tools {
        maven 'Maven 3.9.11'
    }

    environment {
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
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

        stage('Build Docker Image') {
            steps {
                sh '''
                    # Remove existing image if exists
                    if docker images -q maven-web-app > /dev/null; then
                        docker rmi -f maven-web-app
                    fi
                    # Build new Docker image
                    docker build -t maven-web-app:1.0 .
                '''
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-password', 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag maven-web-app:1.0 $DOCKER_USER/maven-web-app:latest
                        docker push $DOCKER_USER/maven-web-app:latest
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') { 
            steps {
                dir('k8s') {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }

    post {
        always { echo 'Pipeline finished' }
        success { echo 'Build, push, and deploy completed successfully!' }
        failure { echo 'Pipeline failed. Check logs.' }
    }
}
