variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used to name network resources"
}

variable "vnet_address_space" {
  type        = string
  description = "CIDR for the VNet"
}

variable "app_gateway_subnet_address_prefix" {
  type        = string
  description = "CIDR for the Application Gateway subnet"
}

variable "private_subnet_address_prefixes" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to taggable network resources"
  default     = {}
}
