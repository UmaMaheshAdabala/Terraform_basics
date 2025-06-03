# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh-${terraform.workspace}"
  description = "Dev VPC SSH"
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outboun"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  ports = [80, 443]
}
# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-web" {
  name        = "vpc-web-${terraform.workspace}"
  description = "Dev VPC web"


  dynamic "ingress" {
    for_each = local.ports
    content {
      description = "Allow Port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
