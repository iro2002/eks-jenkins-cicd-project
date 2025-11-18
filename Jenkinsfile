pipeline {
    agent any

    tools {
        maven 'Maven 3.9.11'
    }

    environment {
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
        DOCKER_HUB_USER = 'irosh2002'
        DOCKER_HUB_PASS = credentials('dockerhub-password') 
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
                    if docker images -q maven-web-app > /dev/null; then
                        docker rmi -f maven-web-app
                    fi
                    docker build -t maven-web-app:1.0 .
                '''
            }
        }

        stage('Docker Login & Push') {
            steps {
                sh '''
                    echo "$DOCKER_HUB_PASS" | docker login -u "$DOCKER_HUB_USER" --password-stdin
                    docker tag maven-web-app:1.0 $DOCKER_HUB_USER/maven-web-app:latest
                    docker push $DOCKER_HUB_USER/maven-web-app:latest
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
        always { echo 'Pipeline finished' }
        success { echo 'Build, push, and deploy completed successfully!' }
        failure { echo 'Pipeline failed. Check logs.' }
    }
}
