variable "ami_id" {
  description = "ami for ec2 instance"
  type        = string
}

variable "instance_type" {
  description = "instance type for ec2 instance"
  type        = string
  default     = "t3.micro"
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

variable "key_name" {
  description = "Name of an existing AWS EC2 key pair to attach to instances"
  type        = string
  default     = "playground-public-ec2"
}

variable "tags" {
  description = "tags to assign to the EC2 instance"
  type        = map(string)
}
