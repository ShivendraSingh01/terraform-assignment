variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used to name NSG resources"
}

variable "app_gateway_subnet_id" {
  type        = string
  description = "ID of the Application Gateway subnet"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of private subnets that should use the VMSS NSG"
}

variable "app_gateway_subnet_address_prefix" {
  type        = string
  description = "CIDR for the App Gateway subnet"
}

variable "frontend_port" {
  type        = number
  description = "Application Gateway frontend port allowed from the internet"
  default     = 80
}

variable "backend_port" {
  type        = number
  description = "VMSS backend port allowed from the Application Gateway subnet"
  default     = 80
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to NSG resources"
  default     = {}
}

