pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'ruby --version'
            }
        }
    }

    environment {
        PATH = $PATH:/home/ec2-user
    }
}
