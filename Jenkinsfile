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
        Path = /home/ec2-user
    }
}
