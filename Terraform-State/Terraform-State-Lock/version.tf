terraform {
  required_version = ">=1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
  backend "s3" {
    bucket = "terraform-s3-backend-umesh"
    key    = "prac/terraform.tfstate"
    region = "ap-south-1"

    #Backend_Lock
    dynamodb_table = "tab-terraform"
  }
}
