pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials'
        
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    image = docker.build("ahmedhesham301/weatherapp","--build-arg","--build-arg ")
                }
            }
        }
        stage('push image') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
                        image.push("1.0")
                    }
                }
            }
        }
        // stage('Run ansible playbook'){
        //     steps{
        //         script{
        //             ansiblePlaybook credentialsId: 'akey.pem', inventory: 'inventory.yaml', playbook: 'playbook.yaml'
        //         }
        //     }
        // }
    }
}
