pipeline {
    agent any

    stages {

	stage('Checkout') {
            steps {
              checkout scm
            }
        }

        stage('Init') {
            steps {
                sh """
		   cd docker && terraform init 
		   """
            }
        }

        stage('Plan') {
            steps {
		sh """
                   cd docker && terraform plan -out=tfplan -var-file=\"~/terraform.tfvars\" 
                   """
            }
        }

        stage('Apply') {
            steps {
                sh """
                   cd docker && terraform apply tfplan 
                   """
            }
        }
    }
}
