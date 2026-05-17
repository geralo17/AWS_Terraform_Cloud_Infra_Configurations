variable vpc_id {
    description = "VPC ID to which the subnet will be associated"
    type = string
}

variable internet_gateway_id {
    description = "Internet Gateway ID to which the route table will be associated"
    type = string
    default = null
}

variable tags {
    description = "tags to assign to the route table instance"
    type = map(string)
}

variable is_public {
    description = "indicates if the route table is for public subnet"
    type = bool
    default = false
}

variable additional_routes {
    description = "additional routes to add to the route table"
    type = list(object({
        cidr_block     = string
        gateway_id     = string
        nat_gateway_id = string
    }))
    default = []
}

variable nat_gateway_id {
    description = "NAT Gateway ID to which the route table will be associated (if not public)"
    type = string
    default = null
}