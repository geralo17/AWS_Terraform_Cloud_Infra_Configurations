resource "aws_nat_gateway" "nat_gateway_instance" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "nat-gateway_instance"
  }

  depends_on = [var.internet_gateway_id]
}