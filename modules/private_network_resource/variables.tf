variable "vpc_id" {
  description = "id of the vpc"
  type        = string
}

variable "subnet_id" {
  description = "id of the subnet"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID that must exist before creating the NAT Gateway"
  type        = string
}