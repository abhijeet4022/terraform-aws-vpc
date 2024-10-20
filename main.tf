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
resource "aws_route" "igw" {
  for_each               = lookup(lookup(module.subnets, "public", null), "route_table_ids", null)
  route_table_id         = each.value["id"]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Create Elastic IPs for Nat Gateway
resource "aws_eip" "ngw" {
  count  = length(local.public_subnet_ids)
  domain = "vpc"
  tags   = { Name = "eip-${count.index + 1}" }
}

# Create nat gateway in public subnets
resource "aws_nat_gateway" "nwg" {
  count         = length(local.public_subnet_ids)
  allocation_id = element(aws_eip.ngw.*.id, count.index)
  subnet_id     = element(local.public_subnet_ids, count.index)
  tags          = { Name = "ngw-${count.index + 1}" }

}

# # Create route entry for Private Subnet to Nat Gateway to access internet
resource "aws_route" "ngw" {
  count                  = length(local.private_route_table_ids)
  route_table_id         = element(local.private_route_table_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nwg.*.id, count.index)
}