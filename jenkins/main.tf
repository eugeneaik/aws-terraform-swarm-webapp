provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.region}"
}

resource "aws_instance" "jenkins" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.ssh_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg-jenkins.id}"]

  tags {
    Name = "Eugene.Aikashev"
    Desc = "Jenkins"
  }

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.key_name)}"
    timeout     = "2m"
  }

  provisioner "local-exec" {
    command = "echo '#!/bin/bash\nssh ubuntu@${aws_instance.jenkins.public_ip}' > ssh_jenkins.sh '-i ${var.key_name}' && chmod +x ssh_jenkins.sh"
  }

  provisioner "file" {
    source      = "${var.key_name}"
    destination = "~/.ssh/${var.key_name}"
  }

  provisioner "file" {
    source      = "terraform.tfvars"
    destination = "terraform.tfvars"
  }

  provisioner "remote-exec" {
    script = "${var.bootstrap}"
  }
}
