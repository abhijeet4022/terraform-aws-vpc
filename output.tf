# Sent the Subnet Module info to root Module.
output "subnets" {
  value = module.subnets
}

# Sent the VPC ID to root module.
output "vpc_id" {
  value = aws_vpc.main.id
}