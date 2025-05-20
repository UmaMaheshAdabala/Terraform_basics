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

# Create VPC

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "my_VPC"
  }
}

# Create subnet

resource "aws_subnet" "my_vpc_subnet-1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# create IGW

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

}

# Create Route Table 

resource "aws_route_table" "my_vpc_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

# create route in route table

resource "aws_route" "my_vpc_route" {
  route_table_id         = aws_route_table.my_vpc_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_vpc_igw.id
}

# Associate Route Table with subnet

resource "aws_route_table_association" "my_vpc_route_associate" {
  route_table_id = aws_route_table.my_vpc_route_table.id
  subnet_id      = aws_subnet.my_vpc_subnet-1.id
}

# create Security Group

resource "aws_security_group" "my_vpc_sg-1" {
  name   = "my_vpc_sg-1"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "my_ec2" {
  ami                    = "ami-0953476d60561c955"
  instance_type          = "t2.micro"
  key_name               = "login_us"
  subnet_id              = aws_subnet.my_vpc_subnet-1.id
  vpc_security_group_ids = [aws_security_group.my_vpc_sg-1.id]
  user_data              = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to StackSimplify ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
    EOF

  tags = {
    "Name" = "my_ec2_ins"
  }
}

resource "aws_eip" "my_eip" {
  instance = aws_instance.my_ec2.id
  vpc      = true

  # Meta Argument
  depends_on = [aws_internet_gateway.my_vpc_igw]

}
