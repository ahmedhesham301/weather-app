pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials'
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
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
                        image.push("1.0")
                    }
                }
            }
        }
        stage('Run ansible playbook')   {
            steps{
                script{
                    ansiblePlaybook credentialsId: 'aws-ssh-key', inventory: 'inventory.yaml', playbook: 'playbook.yaml'
                }
            }
        }
    }
    post{
        failure {
        mail bcc: '', body: 'pipeline failed', cc: '', from: '', replyTo: '', subject: 'pipeline failed', to: 'ahmed.hesham.farag@gmail.com'
        }
        success {
        mail bcc: '', body: 'pipeline succeed', cc: '', from: '', replyTo: '', subject: 'pipeline succeed', to: 'ahmed.hesham.farag@gmail.com'
        }
    }
}
