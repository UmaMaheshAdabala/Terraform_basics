variable "ami-id" {
  description = "my-ec2-1_ami-id"
  default     = "ami-0af9569868786b23a"
  #   sensitive   = true
}

variable "ins-type" {
  description = "my-ec2-ins-type"
  default     = "t2.micro"
}

variable "ins_count" {
  description = "my-ec2-1_count"
  default     = 2
}
