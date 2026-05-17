output "vpc_id" {
  description = "id of the vpc"
  value       = module.vpc.vpc_id
}

output "instance_public_ip" {
  description = "public ip of the EC2 instance"
  value       = module.public_instance.instance_ip
}

output "private_instance_private_ip" {
  description = "private IP of the private EC2 instance"
  value       = module.private_instance.instance_ip
}
