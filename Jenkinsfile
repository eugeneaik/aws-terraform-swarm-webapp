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
                   cd docker && echo -e \'n\\n\' | ssh-keygen -b 2048 -t rsa -N \'\' -C server-key -f sshkey.pem
                   """
            }
	}

        stage('Init') {
            steps {
                sh """
		   cd docker && terraform init -input=false
		   """
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
