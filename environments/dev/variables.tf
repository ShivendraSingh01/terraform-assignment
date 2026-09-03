variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region for dev environment"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "name_prefix" {
  type        = string
  default     = "devdemo"
  description = "Resource naming prefix"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username for the VM"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for the VMSS admin user"
}

variable "vnet_address_space" {
  type        = string
  description = "CIDR for the VNet"
  default     = "10.10.0.0/16"
}

variable "app_gateway_subnet_address_prefix" {
  type        = string
  description = "CIDR for the Application Gateway subnet"
  default     = "10.10.0.0/24"
}

variable "private_subnet_address_prefixes" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "frontend_port" {
  type        = number
  description = "Application Gateway frontend port"
  default     = 80
}

variable "backend_port" {
  type        = number
  description = "VMSS backend port"
  default     = 80
}

variable "health_probe_path" {
  type        = string
  description = "Application Gateway health probe path"
  default     = "/"
}

variable "health_probe_host" {
  type        = string
  description = "Application Gateway health probe host header"
  default     = "127.0.0.1"
}

variable "app_gateway_sku_name" {
  type        = string
  description = "Application Gateway SKU name"
  default     = "Standard_v2"
}

variable "app_gateway_sku_tier" {
  type        = string
  description = "Application Gateway SKU tier"
  default     = "Standard_v2"
}

variable "app_gateway_sku_capacity" {
  type        = number
  description = "Application Gateway instance capacity"
  default     = 2
}

variable "vmss_sku" {
  type        = string
  description = "VMSS SKU"
  default     = "Standard_B2ats_v2"
}

variable "vmss_instance_count" {
  type        = number
  description = "Default VMSS instance count"
  default     = 2
}

variable "zones" {
  type        = list(string)
  description = "Availability zones used by the VMSS"
  default     = ["1", "2"]
}

variable "autoscale_minimum_instances" {
  type        = number
  description = "Minimum VMSS instance count"
  default     = 1
}

variable "autoscale_maximum_instances" {
  type        = number
  description = "Maximum VMSS instance count"
  default     = 3
}

variable "scale_out_cpu_threshold" {
  type        = number
  description = "Average CPU percentage that triggers scale out"
  default     = 75
}

variable "scale_in_cpu_threshold" {
  type        = number
  description = "Average CPU percentage that triggers scale in"
  default     = 25
}

variable "identity_role_definition_name" {
  type        = string
  description = "Role assigned to the VMSS managed identity"
  default     = "Reader"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name"
}

variable "storage_container_name" {
  type        = string
  description = "Storage container name"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for resources"
  default     = {}
}
