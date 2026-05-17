output "route_table_id" {
  description = "ID of the route table"
  value       = aws_route_table.rt_instance.id
}