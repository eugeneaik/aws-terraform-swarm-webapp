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

/*        stage('Terrarom Init') {
            steps {
                sh """
		   cd docker && terraform init 
		   """
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
                sh """
                   cd docker && terraform apply docker.tfplan 
                   """
            }
        }
*/

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
                    ${SSH_MASTER} "mkdir -p webapp"
		    """
		sh  """
		    ${SCP_MASTER}
                    """
            }
        }

// ${SCP_MASTER} webapp\/* ubuntu\@$(cat docker\/ip_master.txt):\/webapp
    }
}
