module "my-s3-bucket" {
  source         = "./module/s3"
  s3_bucket_name = var.s3_bucket_name
}
