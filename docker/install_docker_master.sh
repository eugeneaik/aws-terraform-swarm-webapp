#!/bin/bash
sudo apt-get update -y
sudo apt-get --yes install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get --yes install docker-ce
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
sudo docker swarm init
sudo docker swarm join-token --quiet worker > /home/ubuntu/swarm_token.txt
sudo docker service create --name registry --publish published=5000,target=5000 registry:2

