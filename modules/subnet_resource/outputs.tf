output "is_public" {
  description = "Whether this subnet should auto-assign public IPs on launch"
  value       = var.is_public
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = aws_subnet.subnet_instance.id
}
