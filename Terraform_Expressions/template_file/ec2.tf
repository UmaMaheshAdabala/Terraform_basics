resource "aws_instance" "my_ec2" {
  ami                    = var.ami
  instance_type          = var.ins_type
  key_name               = "Mac_Login"
  user_data              = templatefile("user_data.tmpl", { package_name = var.package_name })
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
}
