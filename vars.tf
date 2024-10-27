variable "cidr_block" {
  description = "The primary CIDR block defining the IP address range for the main VPC, e.g., '10.0.0.0/16'."
}

variable "vpc_name" {
  description = "The name to assign to the main VPC for identification and tagging purposes."
}

variable "subnets" {
  description = "A list of subnet configurations for the VPC, including each subnet's CIDR block and availability zone."
}

variable "default_vpc_id" {
  description = "The ID of the public VPC to enable VPC peering with the main VPC."
}

variable "default_vpc_cidr" {
  description = "The CIDR block of the public VPC to add to the main VPC route table for VPC peering."
}

variable "default_vpc_rt_id" {
  description = "The route table ID of the public VPC, used to configure routing for VPC peering from the public VPC to the main VPC."
}

variable "tags" {
  description = "A map of tags to apply to resources created within the VPC for organization and metadata."
}

variable "env" {
  description = "The environment label, such as 'dev', 'staging', or 'production', to assign to the VPC for organizational purposes."
}
