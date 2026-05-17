module "ec2_instances" {
  source             = "../computing_resource"
  count              = var.number_of_instances
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  security_group_ids = var.security_group_ids
  subnet_id          = var.subnet_id
  tags = {
    Name = "${var.name_prefix}-instance-${count.index + 1}"
  }
  is_public = var.is_public
}