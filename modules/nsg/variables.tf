variable "nsg_name" {
  type        = string
  description = "Name of the Network Security Group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "app_gateway_port" {
  type        = number
  description = "Port for the App Gateway"
}

variable "app_gateway_subnet_cidr" {
  type        = string
  description = "CIDR for the App Gateway subnet"
}

variable "nsg_rule_name" {
  type        = string
  description = "Name of the NSG rule"
}

variable "nsg_rule_priority" {
  type        = number
  description = "Priority of the NSG rule"
}

variable "nsg_rule_direction" {
  type        = string
  description = "Direction of the NSG rule (Inbound/Outbound)"
}

variable "nsg_rule_access" {
  type        = string
  description = "Access type of the NSG rule (Allow/Deny)"
}

variable "nsg_rule_protocol" {
  type        = string
  description = "Protocol of the NSG rule (Tcp/Udp/Any)"
}

variable "nsg_rule_source_port_range" {
  type        = string
  description = "Source port range of the NSG rule"
}

variable "nsg_rule_destination_port_range" {
  type        = string
  description = "Destination port range of the NSG rule"
}

variable "nsg_rule_source_address_prefix" {
  type        = string
  description = "Source address prefix of the NSG rule"
}

variable "nsg_rule_destination_address_prefix" {
  type        = string
  description = "Destination address prefix of the NSG rule"
}

