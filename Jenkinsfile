pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                docker.build("ahmedhesham301/weatherapp")
            }
        }
    }
}
