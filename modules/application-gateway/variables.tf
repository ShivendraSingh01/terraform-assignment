variable "resource_group_name" {
  type        = string
  description = "Resource group name" 
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "sku_name" {
  type        = string
  description = "SKU name for the application gateway"
}

variable "sku_tier" {
  type        = string
  description = "SKU tier for the application gateway"
}

variable "sku_capacity" {
  type        = number
  description = "SKU capacity for the application gateway"
}

variable "gateway_name" {
  type        = string
  description = "Name of the gateway IP configuration"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet for the application gateway"
}

variable "private_ip_address" {
  type        = string
  description = "Private IP address for the frontend IP configuration"
}
variable "public_ip_name" {
    type = string
    description = "Name of the public IP for the application gateway"
}

variable "gateway_ip_configuration_name" {
    type = string
    description = "Name of the gateway IP configuration"
}

variable "frontend_port_name" {
    type = string
    description = "Name of the frontend port"
}

variable "frontend_ip_configuration_name" {
    type = string
    description = "Name of the frontend IP configuration"
}

variable "gateway_backend_address_pool_name" {
    type = string
    description = "Name of the backend address pool"
}

variable "gateway_backend_http_settings_name" {
    type = string
    description = "Name of the backend HTTP settings"
}

variable "gateway_probe_name" {
    type = string
    description = "Name of the probe"
}

variable "gateway_http_listener_name" {
    type = string
    description = "Name of the HTTP listener"
}

variable "gateway_request_routing_rule_name" {
    type = string
    description = "Name of the request routing rule"
}