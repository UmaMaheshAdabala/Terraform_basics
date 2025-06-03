variable "bucket_name" {
  description = "bucket name"
  type        = string
  default     = "my-s3-bucket-name-private"
}

variable "s3_tags" {
  description = "s3- tags"
  type        = map(string)
  default = {
    "tag1" = "val1"
  }
}
