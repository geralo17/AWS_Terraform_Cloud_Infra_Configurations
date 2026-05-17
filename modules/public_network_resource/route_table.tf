module public_route_table {
    source = "../route_table_resource"
    
    vpc_id = var.vpc_id
    internet_gateway_id = aws_internet_gateway.internet_gateway_instance.id
    is_public = true
    tags = {
        Name = "public-route-table"
    }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = var.subnet_id
  route_table_id = module.public_route_table.route_table_id
}