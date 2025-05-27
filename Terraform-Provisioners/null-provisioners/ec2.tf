resource "aws_instance" "my_ec2" {
  ami                    = var.ami_id
  instance_type          = var.ins_type
  key_name               = "Mac_Login"
  user_data              = file("apache-install.sh")
  vpc_security_group_ids = [aws_security_group.http.id, aws_security_group.ssh.id]
  tags = {
    "Name" = "my_ec2"
  }


}

resource "time_sleep" "wait_90" {
  depends_on      = [aws_instance.my_ec2]
  create_duration = "90s"
}

resource "null_resource" "sync_time" {
  depends_on = [time_sleep.wait_90]
  # triggers = {
  #   always-update = timestamp()
  # }

  connection {
    type        = "ssh"
    host        = aws_instance.my_ec2.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("private-key/Mac_Login.pem")
  }

  provisioner "file" {
    source      = "apps/app1"
    destination = "/tmp/"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp -r /tmp/app1 /var/www/html"
    ]
  }
}
