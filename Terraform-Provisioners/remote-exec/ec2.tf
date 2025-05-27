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


  # Provisioner to copy file from local to remote
  provisioner "file" {
    source      = "apps/file-copy.html"
    destination = "/tmp/file-copy.html"
  }
  # Provisioner to copy folder from local to remote
  provisioner "file" {
    source      = "apps/app1"
    destination = "/tmp"
  }
  # Provisioner to copy folder contents from local to remote
  provisioner "file" {
    source      = "apps/app2/"
    destination = "/tmp/"
  }

  # Provisioner to copy string to remote
  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/file.log"
  }
  provisioner "remote-exec" {
    inline = [
      "sleep 120",
      "sudo cp /tmp/file-copy.html /var/www/html"
    ]
  }
}
