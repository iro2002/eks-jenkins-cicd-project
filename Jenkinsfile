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

        stage('Build & Push Docker Image') {
            steps {
                sh '''
                    # Remove old image if exists
                    if docker images -q irosh2002/maven-web-app > /dev/null; then
                        docker rmi -f irosh2002/maven-web-app
                    fi

                    # Build new Docker image
                    docker build -t irosh2002/maven-web-app:latest .

                    # Login to Docker Hub
                    echo $DOCKER_HUB_PASS | docker login -u $DOCKER_HUB_USER --password-stdin

                    # Push image to Docker Hub
                    docker push irosh2002/maven-web-app:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                dir('k8s') {
                    echo "Deleting old Kubernetes resources..."

                
                    sh 'kubectl delete -f deployment.yaml || true'
                    sh 'kubectl delete -f service.yaml || true'

                    echo "Applying new Kubernetes resources..."

                 
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }

    post {
        always { echo 'Pipeline finished' }
        success { echo 'Build and deploy completed successfully!' }
        failure { echo 'Pipeline failed. Check logs.' }
    }
}
