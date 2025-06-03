resource "random_id" "id" {
  byte_length = 8
}


locals {
  name  = (var.name != "" ? var.name : random_id.id.hex)
  owner = var.team
  common_tags = {
    name  = local.name,
    owner = local.owner
  }
}

resource "aws_instance" "my_ec2" {
  ami                    = var.ami
  instance_type          = var.ins_type
  key_name               = "Mac_Login"
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  count             = (var.high_availability == true ? 2 : 1)
  tags              = local.common_tags
  availability_zone = var.availability_zones[count.index]
}
