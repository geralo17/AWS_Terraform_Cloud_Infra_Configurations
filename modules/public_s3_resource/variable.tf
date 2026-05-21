variable "bucket_name" {
  description = "name of the s3 bucket to be created"
  type        = string
}

variable "tags" {
  description = "tags to assign to the s3 bucket instance"
  type        = map(string)
}

variable "index_document" {
  description = "index document for the s3 bucket"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "error document for the s3 bucket"
  type        = string
  default     = "error.html"
}

variable "index_document_path" {
  description = "path to the index document"
  type        = string
}