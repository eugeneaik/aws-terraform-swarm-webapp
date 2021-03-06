variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "region" {
  default = "eu-central-1"
}

variable "bootstrap" {
  default = "install_jenkins.sh"
}

variable "key_name" {
  default = "sshkey.pem"
}

variable "key_name_pub" {
  default = "sshkey.pem.pub"
}
