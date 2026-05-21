resource "aws_kms_key" "s3_kms_key_instance" {
  description             = "KMS key for encrypting S3 bucket"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "s3_kms_key_alias" {
  name          = "alias/s3-kms-key-a"
  target_key_id = aws_kms_key.s3_kms_key_instance.id
}

resource "aws_s3_bucket" "private_bucket_instance" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption" {
  bucket = aws_s3_bucket.private_bucket_instance.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_kms_key_instance.arn
    }
  }
}
