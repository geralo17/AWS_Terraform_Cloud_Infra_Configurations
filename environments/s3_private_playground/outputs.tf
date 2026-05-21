output "s3_url" {
  description = "S3 URI of the bucket for AWS CLI copy commands"
  value       = module.private_s3_resource.bucket_url
}
