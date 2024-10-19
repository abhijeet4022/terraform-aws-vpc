# Create the Subnets.
resource "aws_subnet" "main" {
  for_each = var.subnets
  vpc_id     = var.vpc_id
  cidr_block = each.value["cidr"]

  tags = {
	Name = each.key
  }
}


variable "vpc_id" {}
variable "subnets" {}