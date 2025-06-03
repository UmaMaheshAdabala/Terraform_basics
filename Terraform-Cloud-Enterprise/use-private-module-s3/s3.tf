module "private_module" {
  source      = "app.terraform.io/Terra-Prac-01/private_module/aws"
  version     = "1.0.1"
  bucket_name = var.bucket_name
  # tags        = var.s3_tags
  # insert required variables here
}
