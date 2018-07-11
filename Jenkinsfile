pipeline {
    agent any

    stages {

	stage('Checkout') {
            steps {
              checkout scm
            }
        }

       stage('Keys') {
            steps {
                sh """
                   yes | ssh-keygen -b 2048 -t rsa -N '' -C server-key -f sshkey.pem
                   """
            }
	}

        stage('Build') {
            steps {
                echo 'Building..'
            }
        }

        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
