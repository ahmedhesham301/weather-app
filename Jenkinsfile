pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS = 'dockerhub-credentials'
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    image = docker.build("ahmedhesham301/weatherapp")
                }
            }
        }
        stage('push image') {
            steps {
                script {
                    docker.withRegistry('', 'DOCKER_CREDENTIALS') {
                        image.push("1.0")
                    }
                }
            }
        }
    }
}
