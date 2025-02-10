pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
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
                    docker.withRegistry('', '$DOCKERHUB_CREDENTIALS') {
                        image.push("1.0")
                    }
                }
            }
        }
    }
}
