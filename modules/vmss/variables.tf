variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the virtual machine scale set"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machine scale set"
}

variable "vmss_name" {
  type        = string
  description = "Name of the virtual machine scale set"
}

variable "vmss_sku" {
  type        = string
  description = "SKU for the virtual machine scale set"
}

variable "vmss_instance_count" {
  type        = number
  description = "Instance count for the virtual machine scale set"
}

variable "public_key" {
  type        = string
  description = "SSH public key for the virtual machine scale set"
}

variable "nic_name" {
  type        = string
  description = "Name of the network interface for the virtual machine scale set"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet for the virtual machine scale set"
}

variable "nsg_id" {
  type        = string
  description = "ID of the network security group for the virtual machine scale set"
}

variable "backend_address_pool_id" {
  type        = string
  description = "ID of the backend address pool for the virtual machine scale set"
}

variable "identity_id" {
  type        = string
  description = "ID of the user-assigned managed identity for the virtual machine scale set"
}

variable "vmss_autoscale_name" {
  type        = string
  description = "Name of the autoscale setting for the virtual machine scale set"
}

variable "vmss_id" {
  type        = string
  description = "ID of the virtual machine scale set"
}