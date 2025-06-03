resource "aws_instance" "myec2" {
  ami           = "ami-0f535a71b34f2d44a"
  key_name      = "Mac_Login"
  instance_type = "t2.micro"
  tags = {
    "Name" : "web-2"
  }
}
