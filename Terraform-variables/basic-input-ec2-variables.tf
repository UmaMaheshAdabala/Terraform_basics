variable "ec2-ami" {
  type    = string
  default = "ami-0af9569868786b23a"

}

variable "ins-type" {
  type    = string
  default = "t2.micro"
}

variable "aws-region" {
  type    = string
  default = "ap-south-1"
}
