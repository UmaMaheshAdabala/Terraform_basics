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

## for_each with MAP

resource "aws_s3_bucket" "mys3bucket" {

  # for_each Meta-Argument
  for_each = {
    dev  = "my-dapp-bucket"
    qa   = "my-qapp-bucket"
    stag = "my-sapp-bucket"
    prod = "my-papp-bucket"
  }

  bucket = "${each.key}-${each.value}"
  #acl    = "private" # This argument is deprecated, so commenting it. 


  tags = {
    Environment = each.key
    bucketname  = "${each.key}-${each.value}"
    eachvalue   = each.value
  }
}


## for_each with SET

resource "aws_iam_user" "myuser" {
  for_each = toset(["abc", "mno", "xyz"])
  name     = each.key
}
