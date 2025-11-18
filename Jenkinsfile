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

        stage('Build Docker Image') {
            steps {
                sh '''
                    if docker images -q iro2002/maven-web-app; then
                        docker rmi -f iro2002/maven-web-app
                    fi
                    docker build -t iro2002/maven-web-app .
                '''
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
        always { echo 'Pipeline finished.' }
        success { echo 'Build and deploy completed successfully!' }
        failure { echo 'Pipeline failed. Check logs .' }
    }
}
