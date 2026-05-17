output "route_table_id" {
  description = "ID of the route table"
  value       = module.public_route_table.route_table_id
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.internet_gateway_instance.id
}