output "vpc_id" {
  description = "id of the vpc"
  value       = aws_vpc.playground-vpc.id
}

output "instance_public_id" {
  description = "public id of the EC2 instance"
  value       = aws_instance.public_instance.public_ip
}

output "private_instance_private_ip" {
  description = "private IP of the private EC2 instance"
  value       = aws_instance.private_instance.private_ip
}
