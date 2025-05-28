module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "my-ec2"

  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-07de70f8054b09d13"]
  subnet_id              = "subnet-08bc45cee50251417"
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "my-ec2-ins"
  }
}
