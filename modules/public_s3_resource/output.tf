output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_instance.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_instance.arn
}

output "bucket_endpoint" {
  description = "Endpoint of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_instance.website_endpoint
}