# Output for Subnet resource
output "subnet_ids" {
  value = aws_subnet.main
}

# Output for RT resource
output "route_table_ids" {
  value = aws_route_table.main
}