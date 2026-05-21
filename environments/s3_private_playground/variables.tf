variable "bucket_name" {
  description = "name of the s3 bucket to be created"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-4"
}

variable "aws_profile" {
  description = "Optional local AWS CLI profile. Leave empty in CI."
  type        = string
  default     = ""
}
