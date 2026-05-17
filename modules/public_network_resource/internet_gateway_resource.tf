resource "aws_internet_gateway" "internet_gateway_instance" {
  vpc_id = var.vpc_id

  tags = {
    Name = "igw_instance"
  }
}