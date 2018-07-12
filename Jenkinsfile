pipeline {
    agent any

environment {
    ssh_var = '-o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i ~/.ssh/sshkey.pem'
    }


    stages {

	stage('Checkout') {
            steps {
              checkout scm
            }
        }

/*        stage('Init') {
            steps {
                sh """
		   cd docker && terraform init 
		   """
            }
        }

        stage('Plan') {
            steps {
		sh """
                   cd docker && terraform plan -out=docker.tfplan -var-file=\"~/terraform.tfvars\" 
                   """
            }
        }

        stage('Apply') {
            steps {
                sh """
                   cd docker && terraform apply docker.tfplan 
                   """
            }
        }
*/

	stage('test') {
            steps {
                sh  """
                    ssh ubuntu@(cat ip_master.txt) ${ssh_var} "docker node ls"
                    """
            }
        }

    }
}
