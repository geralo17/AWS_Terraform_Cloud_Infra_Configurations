resource "aws_s3_bucket" "website_bucket_instance" {
  bucket = "www.${var.bucket_name}"

  tags = var.tags
}

resource "aws_s3_bucket_website_configuration" "website_config_instance" {
  bucket = aws_s3_bucket.website_bucket_instance.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block_instance" {
  bucket = aws_s3_bucket.website_bucket_instance.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy_instance" {
  bucket = aws_s3_bucket.website_bucket_instance.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.website_bucket_instance.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index_document_instance" {
    bucket = aws_s3_bucket.website_bucket_instance.id
    key    = var.index_document
    source = var.index_document_path
}
