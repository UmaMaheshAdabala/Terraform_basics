variable "ami" {
  description = "ami_id"
  type        = string
  default     = "ami-0f535a71b34f2d44a"
}

variable "ins_type" {
  description = "Instace Type"
  type        = string
  default     = "t2.micro"
}

variable "package_name" {
  description = "Name of the package that needed to be installed"
  type        = string
  default     = "httpd"
}
