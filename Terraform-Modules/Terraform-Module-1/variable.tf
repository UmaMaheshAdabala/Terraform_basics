variable "s3_bucket_name" {
  description = "S3 Bucket name that we pass to S3 Custom Module"
  type        = string
}

## Create Variable for S3 Bucket Tags
variable "s3-tags" {
  description = "Tags to set on the bucket"
  type        = map(string)
}
