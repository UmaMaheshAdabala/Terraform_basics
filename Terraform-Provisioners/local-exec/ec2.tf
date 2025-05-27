resource "aws_instance" "my_ec2" {
  ami                    = var.ami_id
  instance_type          = var.ins_type
  key_name               = "Mac_Login"
  user_data              = file("apache-install.sh")
  vpc_security_group_ids = [aws_security_group.http.id, aws_security_group.ssh.id]
  tags = {
    "Name" = "my_ec2-${terraform.workspace}"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("private-key/Mac_Login.pem")
  }

  provisioner "local-exec" {
    command     = "echo ${aws_instance.my_ec2.public_ip} >> public.txt"
    working_dir = "local-files/"
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "echo destroyed at `date` >> deleted.txt"
    working_dir = "local-files/"
  }

}
