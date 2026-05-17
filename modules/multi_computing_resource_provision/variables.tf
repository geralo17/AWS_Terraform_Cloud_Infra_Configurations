variable "number_of_instances" {
  description = "number of computing resources to be provisioned"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "The AMI used for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The Instance type to use for EC2 instances"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of an existing AWS EC2 key pair to attach to instances"
  type        = string
  default     = "playground-public-ec2"
}

variable "security_group_ids" {
  description = "security groups to attach to the ec2 instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID in which to launch the ec2 instance"
  type        = string
}


variable "is_public" {
  description = "Whether the EC2 instance is launched in a public subnet"
  type        = bool
}

variable "name_prefix" {
  description = "Prefix for the Name tag of the EC2 instances"
  type        = string
  default     = ""
}