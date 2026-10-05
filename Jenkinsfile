pipeline {
    agent any
    triggers { pollSCM('* * * * *') }
    environment {
        IMAGE = "cyrina1hedhli/counter-app"
    }
    stages {
        stage('Build et Tests unitaires') {
            steps {
                sh '''
                python3 -m venv venv
                . venv/bin/activate
                pip install -r requirements.txt pytest
                pytest
                '''
            }
        }
        stage('Build image') {
            steps {
                sh 'docker build -t $IMAGE:$BUILD_NUMBER -t $IMAGE:latest .'
            }
        }
        stage('Push Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub',
                        usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
                    sh '''
                    echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin
                    docker push $IMAGE:$BUILD_NUMBER
                    docker push $IMAGE:latest
                    '''
                }
            }
        }
    }
}
