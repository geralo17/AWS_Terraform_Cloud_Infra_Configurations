output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.private_bucket_instance.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.private_bucket_instance.arn
}

output "bucket_url" {
  description = "S3 URI of the bucket for AWS CLI copy commands"
  value       = "s3://${aws_s3_bucket.private_bucket_instance.bucket}/"
}
