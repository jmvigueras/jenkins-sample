pipeline {
    agent any
    stages {
        stage('Clone app') {
            steps {
                git branch: 'main', url: 'https://github.com/jmvigueras/jenkins-sample'
            }
        }
        stage('SAST FortiDevSec') {
            steps {
                sh '''
                env | grep -E "JENKINS_HOME|BUILD_ID|GIT_BRANCH|GIT_COMMIT" > /tmp/env
                docker pull registry.fortidevsec.forticloud.com/fdevsec_sast:latest
                docker run --rm --env-file /tmp/env --mount type=bind,source=$PWD,target=/scan registry.fortidevsec.forticloud.com/fdevsec_sast:latest
                '''
            }
        }
        stage('Build image') {
            steps {
                sh '''
                docker build -f dockerfile . -t web-server-python
                '''
            }
        }
        stage('Deploy image') {
            steps {
                sh '''
                docker run -p 8000:80 --rm -d --name web-server-python web-server-python
                '''
            }
        }
    }
}