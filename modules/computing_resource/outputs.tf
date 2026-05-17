output "instance_ip" {
  description = "IP of the EC2 instance"
  value       = var.is_public ? aws_instance.ec2_instance.public_ip : aws_instance.ec2_instance.private_ip
}
