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

variable "availability_zones" {
  description = "Availability_Zones"
  type        = list(string)
}

variable "high_availability" {
  type    = bool
  default = true
}

variable "name" {
  type    = string
  default = ""
}

variable "team" {
  type    = string
  default = "team-1"
}
