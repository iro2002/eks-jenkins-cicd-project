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
                    docker images -q iro2002/maven-web-app | grep -q . && docker rmi -f iro2002/maven-web-app || echo "No existing image"
                    docker build -t iro2002/maven-web-app .
                '''
            }
        }

       
    }

    post {
        always { echo 'Pipeline finished' }
        success { echo 'Build and deploy completed successfully!' }
        failure { echo 'Pipeline failed. Check logs.' }
    }
}
