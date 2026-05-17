variable aws_region {
    description = "aws region to deploy resources in"
    type = string
    default = "ap-southeast-4"
}

variable vpc_id {
    description = "VPC ID to which the subnet will be associated"
    type = string
}

variable "cidr_block" {
    description = "cidr block for subnet instance"
    type = string
}

variable "availability_zone" {
    description = "availability zone for subnet instance"
    type = string
}

variable "is_public" {
    description = "indicates if the subnet is public"
    type = bool
    default = false
}

variable "tags" {
    description = "tags to assign to the subnet instance"
    type = map(string)
}