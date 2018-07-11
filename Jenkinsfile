pipeline {
    agent any

    stages {

	stage('Checkout') {
            steps {
              checkout scm
            }
        }

/*       stage('Keys') {
            steps {
		 sh '/bin/bash -c \\"yes n | ssh-keygen -b 2048 -t rsa -N \\\"\\\" -C server-key -f sshkey.pem\\"'
		 sh 'cd docker'
		 sh 'yes n | ssh-keygen -b 2048 -t rsa -N "" -C server-key -f sshkey.pem'
            }
	}
*/

        stage('Init') {
            steps {
                sh """
		   cd docker && terraform init -input=false
		   """
            }
        }

        stage('Plan') {
            steps {
		sh """
                   cd docker && terraform plan -out=tfplan -input=false
                   """

            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
