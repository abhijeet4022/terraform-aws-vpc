# Sent the output for Subnet resource to root module.
output "subnet_ids" {
  value = aws_subnet.main
}


# Sent the output for RT resource to root module.
output "route_table_ids" {
  value = aws_route_table.main
}