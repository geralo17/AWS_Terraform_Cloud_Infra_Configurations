output vpc_id {
    description = "id of the vpc"
    value = aws_vpc.vpc_instance.id
}

output cidr_block {
    description = "CIDR block of the VPC"
    value = aws_vpc.vpc_instance.cidr_block
}