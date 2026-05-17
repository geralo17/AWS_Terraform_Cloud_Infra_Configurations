locals {
  availability_zone       = "${var.aws_region}a"
  allowed_ssh_cidr_blocks = ["0.0.0.0/0"]
}

module "vpc" {
  source = "../../modules/vpc_resource"
  tags = {
    Name  = "playground-vpc",
    Owner = "playground_user"
  }
}

module "public_subnet" {
  source = "../../modules/subnet_resource"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = local.availability_zone
  is_public         = true
  tags = {
    Name = "public_subnet"
  }
}

module "private_subnet" {
  source = "../../modules/subnet_resource"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = local.availability_zone
  is_public         = false
  tags = {
    Name = "private_subnet"
  }
}

module "public_network_resources" {
  source = "../../modules/public_network_resource"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.public_subnet.subnet_id
}

module "private_network_resources" {
  source = "../../modules/private_network_resource"

  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.private_subnet.subnet_id
  internet_gateway_id = module.public_network_resources.internet_gateway_id
}

resource "aws_security_group" "public-sg" {
  name        = "playground-public-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.allowed_ssh_cidr_blocks
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = local.allowed_ssh_cidr_blocks
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = local.allowed_ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.allowed_ssh_cidr_blocks
  }
  tags = {
    Name = "playground-public-sg"
  }
}

resource "aws_security_group" "private-sg" {
  name        = "playground-private-sg"
  description = "Allow SSH access from within the VPC"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.allowed_ssh_cidr_blocks
  }

  tags = {
    Name = "playground-private-sg"
  }
}

module "public_instance" {
  source = "../../modules/computing_resource"

  ami_id             = var.ami_id
  is_public          = true
  subnet_id          = module.public_subnet.subnet_id
  security_group_ids = [aws_security_group.public-sg.id]
  instance_type      = var.instance_type
  key_name           = var.ssh_key_name
  tags = {
    Name = "public-instance"
  }
}

module "private_instance" {
  source = "../../modules/computing_resource"

  ami_id             = var.ami_id
  is_public          = false
  subnet_id          = module.private_subnet.subnet_id
  security_group_ids = [aws_security_group.private-sg.id]
  instance_type      = var.instance_type
  key_name           = var.ssh_key_name
  tags = {
    Name = "private-instance"
  }
}
