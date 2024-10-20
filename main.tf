# Create the VPC.
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}



# Create the Subnets, RT and RT Association.
module "subnets" {
  source   = "./module/subnet"
  for_each = var.subnets
  subnets  = each.value
  vpc_id   = aws_vpc.main.id
}

# Create IGW for public subnets.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-vpc-igw"
  }
}

# # Create route entry for Public Subnet to IGW to access internet
# resource "aws_route" "r" {
#   for_each = lookup(lookup(module.subnets, "public", null ),
#   route_table_id            = aws_route_table.testing.id
#   destination_cidr_block    = "0.0.0.0/0"
#   gateway_id = aws_internet_gateway.igw
# }

output "vpc" {
  value = lookup(lookup(module.subnets, "public", null ), "route_table_ids", null)
}
