variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "region" {
  default = "eu-central-1"
}

variable "bootstrap_master" {
  default = "install_docker_master.sh"
}

variable "bootstrap_worker" {
  default = "install_docker.sh"
}

variable "key_name" {
  default = "sshkey.pem"
}

variable "key_name_pub" {
  default = "sshkey.pem.pub"
}
