#!/bin/bash
sudo apt-get update -y

udo apt-get --yes curl

echo === Install Terraform ===
sudo apt-get --yes install unzip
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/

echo === Installing Java ===
sudo apt-get --yes install default-jre
sudo chmod go+w /etc/environment
sudo echo "JAVA_HOME=\"/usr/lib/jvm/default-java/jre\"" >> /etc/environment
sudo chmod go-w /etc/environment
source /etc/environment

echo === Installing Jenkins ===
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update -y
sudo apt-get --yes install jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo mkdir /var/lib/jenkins/.ssh
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod og-xr /var/lib/jenkins/.ssh
sudo cp ~/.ssh/sshkey.pem  /var/lib/jenkins/.ssh
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/sshkey.pem
sudo chmod go-r /var/lib/jenkins/.ssh/sshkey.pem
sudo mv terraform.tfvars /var/lib/jenkins/terraform.tfvars
sudo chown jenkins:jenkins /var/lib/jenkins/terraform.tfvars
echo === End ===

