resource "aws_vpc" "playground-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name  = "playground-vpc",
    Owner = "playground_user"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.playground-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-4a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.playground-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-southeast-4a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet"
  }
}

// public subnet networking resources

resource "aws_internet_gateway" "playground_igw" {
  vpc_id = aws_vpc.playground-vpc.id

  tags = {
    Name = "playground-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.playground-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.playground_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


// private subnet networking resources
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "playground_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "playground-nat-gateway"
  }

  depends_on = [aws_internet_gateway.playground_igw]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.playground-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.playground_nat_gateway.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}


// instance resources

resource "aws_security_group" "playground-public-sg" {
  name        = "playground-public-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.playground-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "playground-public-sg"
  }
}

resource "aws_security_group" "playground-private-sg" {
  name        = "playground-private-sg"
  description = "Allow SSH access from within the VPC"
  vpc_id      = aws_vpc.playground-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.playground-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "playground-private-sg"
  }
}

resource "aws_instance" "public_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.playground-public-sg.id]
  tags = {
    Name = "public_instance"
  }
}

resource "aws_instance" "private_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.playground-private-sg.id]
  tags = {
    Name = "private_instance"
  }
}
