variable "s3_bucket_name" {
  description = "s3-bucket name"
  type        = string
  default     = "umesh-bucket-terra-module-01"
}

variable "s3-tags" {
  description = "s3-tags"
  type        = map(string)
  default = {
  }
}
