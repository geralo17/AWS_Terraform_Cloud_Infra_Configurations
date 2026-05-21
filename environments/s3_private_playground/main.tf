module "private_s3_resource" {
  source      = "../../modules/private_s3_resource"
  bucket_name = var.bucket_name
}