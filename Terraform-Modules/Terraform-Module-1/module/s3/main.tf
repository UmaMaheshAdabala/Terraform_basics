resource "aws_s3_bucket" "my-s3" {
  bucket        = var.s3_bucket_name
  tags          = var.s3-tags
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "my-s3" {
  bucket = aws_s3_bucket.my-s3.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_versioning" "my-s3" {
  bucket = aws_s3_bucket.my-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Ownership control

resource "aws_s3_bucket_ownership_controls" "my-s3" {
  bucket = aws_s3_bucket.my-s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# aws-s3-public-access

resource "aws_s3_bucket_public_access_block" "my-s3" {
  bucket                  = aws_s3_bucket.my-s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# aws-s3-acl

resource "aws_s3_bucket_acl" "my-s3" {
  depends_on = [
    aws_s3_bucket_ownership_controls.my-s3,
    aws_s3_bucket_public_access_block.my-s3
  ]
  bucket = aws_s3_bucket.my-s3.id
  acl    = "public-read"
}

# s3-bucket-policy

resource "aws_s3_bucket_policy" "my-s3" {
  bucket = aws_s3_bucket.my-s3.id
  policy = <<EOF
{
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.s3_bucket_name}/*"
          ]
      }
  ]
} 
  EOF
}
