# Terraform Block
terraform {
  required_version = ">= 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.33"
    }
  }
  # Update backend information as Terraform Cloud

  cloud {

    organization = "Terra-Prac-01"

    workspaces {
      name = "Terraform-sentinel"
    }
  }


}

# Provider Block
provider "aws" {
  region = var.aws_region
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
