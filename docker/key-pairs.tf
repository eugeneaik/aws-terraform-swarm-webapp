#resource "null_resource" "create-key" {
#  provisioner "local-exec" {
#    command = "yes | ssh-keygen -b 2048 -t rsa -N '' -C server-key -f ${var.key_name}"
#  }
#}

resource "aws_key_pair" "ssh_key" {
  #  depends_on = ["null_resource.create-key"]
  key_name   = "${var.key_name}"
  public_key = "${file(var.key_name_pub)}"
}
