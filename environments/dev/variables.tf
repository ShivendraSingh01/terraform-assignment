variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region for dev environment"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "prefix" {
  type        = string
  default     = "devdemo"
  description = "Resource naming prefix"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username for the VM"
}

variable "public_key" {
  type        = string
  description = "SSH public key for the VM"
}
