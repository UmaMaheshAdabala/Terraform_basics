terraform {
  required_version = "~>1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0953476d60561c955"
  instance_type = "t2.micro"
  count         = 5

  tags = {
    "Name" = "web-${count.index}"
  }
}
