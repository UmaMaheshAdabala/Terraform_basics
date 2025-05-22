resource "aws_instance" "demo1-ec2" {
  ami           = var.ec2-ami
  instance_type = var.ins-type
  user_data     = <<-EOF
  #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to StackSimplify ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
  EOF

  tags = {
    "Name" = "web-demo"
  }
  vpc_security_group_ids = [aws_security_group.my-sg-ssh.id]
}


resource "aws_security_group" "my-sg-ssh" {
  name = "vpc-ssh"
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
