output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = [for instance in module.ec2_instances : instance.id]
}

output "instance_ips" {
  description = "list of ips for the EC2 instances"
  value       = [for instance in module.ec2_instances : instance.instance_ip]
}