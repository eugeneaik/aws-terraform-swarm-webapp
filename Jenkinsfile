pipeline {
    agent any

environment {
	SCP_MASTER = 'scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i ~/.ssh/sshkey.pem webapp/* ubuntu@$(cat docker/ip_master.txt):webapp/'
	SSH_MASTER = 'ssh ubuntu@$(cat docker/ip_master.txt) -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i ~/.ssh/sshkey.pem'
    }

    stages {

	stage('Checkout') {
            steps {
              checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'cd docker && terraform init' 
            }
        }

        stage('Terraform Plan') {
            steps {
		sh """
                   cd docker && terraform plan -out=docker.tfplan -var-file=\"~/terraform.tfvars\" 
                   """
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'cd docker && terraform apply docker.tfplan' 
            }
        }

	stage('Check Docker Registry') {
            steps {
                sh  """
                    ${SSH_MASTER} "curl http://localhost:5000/v2/"
                    """
            }
        }

        stage('Copy App to Docker') {
            steps {
                sh  """
                    ${SSH_MASTER} "mkdir -p webapp/templates"
		    """
		sh  """
		    ${SCP_MASTER}
                    """
            }
        }

        stage('Compose Build') {
            steps {
                sh  """
                    ${SSH_MASTER} "cd webapp && docker-compose build"
                    """
            }
        }

        stage('Compose Push') {
            steps {
                sh  """
                    ${SSH_MASTER} "cd webapp && docker-compose push"
                    """
            }
        }

        stage('Stack Deploy') {
            steps {
                sh  """
                    ${SSH_MASTER} "cd webapp && docker stack deploy --compose-file docker-compose.yml stackwebapp"
                    """
            }
        }

        stage('Check App') {
            steps {
               sh """ 
		    sleep 10
                    ${SSH_MASTER} "curl http://localhost"
		  """ 
	    	}		
        }

    }
}
