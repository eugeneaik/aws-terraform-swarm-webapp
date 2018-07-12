provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.region}"
}

resource "aws_instance" "master" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg-swarm.id}"]

  tags {
    Name = "Eugene.Aikashev"
    Desc = "Docker Master"
  }

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(~/.ssh/var.key_name)}"
    timeout     = "2m"
  }

  provisioner "local-exec" {
    command = "echo '#!/bin/bash\nssh ubuntu@${aws_instance.master.public_ip}' > ssh_master.sh '-i ${var.key_name}' && chmod +x ssh_master.sh"
  }

  provisioner "file" {
    source      = "${var.key_name}"
    destination = "~/.ssh/${var.key_name}"
  }

  provisioner "remote-exec" {
    script = "${var.bootstrap_master}"
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod 400 ~/.ssh/${var.key_name}"]
  }
}

resource "aws_instance" "worker" {
  depends_on             = ["aws_instance.master"]
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg-swarm.id}"]

  tags {
    Name = "Eugene.Aikashev"
    Desc = "Docker Worker"
  }

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(~/.ssh/var.key_name)}"
    timeout     = "2m"
  }

  provisioner "local-exec" {
    command = "echo '#!/bin/bash\nssh ubuntu@${aws_instance.worker.public_ip}' > ssh_worker.sh '-i ${var.key_name}' && chmod +x ssh_worker.sh"
  }

  provisioner "file" {
    source      = "${var.key_name}"
    destination = "~/.ssh/${var.key_name}"
  }

  provisioner "remote-exec" {
    script = "${var.bootstrap_worker}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 ~/.ssh/${var.key_name}",
      "sudo scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i ~/.ssh/${var.key_name} ubuntu@${aws_instance.master.private_ip}:/home/ubuntu/swarm_token.txt .",
      "sudo docker swarm join --token $(cat /home/ubuntu/swarm_token.txt) ${aws_instance.master.private_ip}:2377",
    ]
  }
}
