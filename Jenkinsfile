pipeline {
    agent any
    stages {
        stage('before-build') {
            steps {
                sh 'git pull'
                sh 'source setup.sh'
                sh 'curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter'
                sh 'chmod +x ./cc-test-reporter'
                sh './cc-test-reporter before-build'
            }
        }

        stage('build'){
            steps{
                sh 'rake cucumber'
                sh 'rspec'
            }
        }

        stage('after build'){
            steps{
                sh './cc-test-reporter after-build'
            }
        }
    }
}