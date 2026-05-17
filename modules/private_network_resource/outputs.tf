output "route_table_id" {
  description = "ID of the route table"
  value       = module.private_route_table.route_table_id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat_gateway_instance.id
}