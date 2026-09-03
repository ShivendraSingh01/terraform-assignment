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
  description = "Prefix used to name Application Gateway resources"
}

variable "sku_name" {
  type        = string
  description = "SKU name for the application gateway"
  default     = "Standard_v2"
}

variable "sku_tier" {
  type        = string
  description = "SKU tier for the application gateway"
  default     = "Standard_v2"
}

variable "sku_capacity" {
  type        = number
  description = "SKU capacity for the application gateway"
  default     = 2
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet for the application gateway"
}

variable "frontend_port" {
  type        = number
  description = "Frontend listener port"
  default     = 80
}

variable "backend_port" {
  type        = number
  description = "Backend HTTP port"
  default     = 80
}

variable "health_probe_path" {
  type        = string
  description = "Application Gateway health probe path"
  default     = "/"
}

variable "health_probe_host" {
  type        = string
  description = "Host header used by the Application Gateway health probe"
  default     = "127.0.0.1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to Application Gateway resources"
  default     = {}
}
