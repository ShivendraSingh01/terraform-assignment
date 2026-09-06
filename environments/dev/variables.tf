variable "location" {
  type        = string
  description = "Azure region for the environment"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "name_prefix" {
  type        = string
  description = "Resource naming prefix"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for the VMSS admin user"
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

variable "frontend_port" {
  type        = number
  description = "Application Gateway frontend port"
}

variable "backend_port" {
  type        = number
  description = "VMSS backend port"
}

variable "ssh_source_address_prefix" {
  type        = string
  description = "Source address prefix allowed to SSH into the VMSS"
}

variable "health_probe_path" {
  type        = string
  description = "Application Gateway health probe path"
}

variable "health_probe_host" {
  type        = string
  description = "Application Gateway health probe host header"
}

variable "app_gateway_sku_name" {
  type        = string
  description = "Application Gateway SKU name"
}

variable "app_gateway_sku_tier" {
  type        = string
  description = "Application Gateway SKU tier"
}

variable "app_gateway_sku_capacity" {
  type        = number
  description = "Application Gateway instance capacity"
}

variable "vmss_sku" {
  type        = string
  description = "VMSS SKU"
}

variable "vmss_instance_count" {
  type        = number
  description = "Default VMSS instance count"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones used by the VMSS"
}

variable "autoscale_minimum_instances" {
  type        = number
  description = "Minimum VMSS instance count"
}

variable "autoscale_maximum_instances" {
  type        = number
  description = "Maximum VMSS instance count"
}

variable "scale_out_cpu_threshold" {
  type        = number
  description = "Average CPU percentage that triggers scale out"
}

variable "scale_in_cpu_threshold" {
  type        = number
  description = "Average CPU percentage that triggers scale in"
}

variable "identity_role_definition_name" {
  type        = string
  description = "Role assigned to the VMSS managed identity"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name"
}

variable "storage_container_name" {
  type        = string
  description = "Storage container name"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for resources"
}
