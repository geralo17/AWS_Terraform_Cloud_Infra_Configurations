module private_route_table {
    source = "../route_table_resource"
    
    vpc_id = var.vpc_id
    nat_gateway_id = aws_nat_gateway.nat_gateway_instance.id
    is_public = false
    tags = {
        Name = "private-route-table"
    }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = var.subnet_id
  route_table_id = module.private_route_table.route_table_id
}