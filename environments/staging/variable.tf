variable "aws_region" {
  description = "AWS region resources will be created on"
  default     = "ap-southeast-4"
}

variable "instance_type" {
  description = "The Instance type to use for EC2 instances"
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI used for the EC2 instance"
  default     = "ami-04b37eacc26b7446c"
}

variable "ssh_key_name" {
  description = "Name of an existing AWS EC2 key pair to attach to instances"
  default     = "playground-public-ec2"
}
