variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP"
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the NAT gateway"
}

variable "vnet_address_space" {
  type        = string
  description = "CIDR for the VNet"
}

variable "subnet_address_prefix" {
  type        = string
  description = "CIDR for the subnet"
}
