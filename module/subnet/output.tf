# Output for Subnet resource
output "subnet" {
  value = aws_subnet.main
}

# Output for RT resource
output "route_table" {
  value = aws_route_table.main
}