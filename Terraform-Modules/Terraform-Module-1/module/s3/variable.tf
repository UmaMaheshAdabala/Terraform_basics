variable "s3_bucket_name" {
  description = "Name of the S3 bucket. Must be Unique across AWS"
  type        = string
}

variable "s3-tags" {
  description = "Tages to set on the bucket"
  type        = map(string)
  default     = {}
}
