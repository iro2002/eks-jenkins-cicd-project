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

        stage('Package') {
            steps {
   
                sh 'echo "Packaging stage (optional)"'
            }
        }
    }

    post {
        always {
            echo 'This will always run after the stages finish.'
        }
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed. Please check errors above.'
        }
    }
}
