# Create the VPC.
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block

  tags = {
	Name = var.vpc_name
  }
}


# Create the Subnets.
module "subnets" {
  source = "./module/subnet"
  for_each = var.subnets
  subnets = each.value
  vpc_id = aws_vpc.main.id
}


variable "cidr_block" {}
variable "vpc_name" {}
variable "subnets" {}
