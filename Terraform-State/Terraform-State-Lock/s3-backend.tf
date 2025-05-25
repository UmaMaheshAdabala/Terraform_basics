
provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0af9569868786b23a"
  instance_type = "t2.micro"
}
