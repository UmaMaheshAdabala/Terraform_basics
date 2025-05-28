output "bucket-name" {
  value = module.my-s3-bucket.name

}

output "arn" {
  value = module.my-s3-bucket.arn
}

output "bucket-domain-name" {
  value = module.my-s3-bucket.bucket_domain_name
}
