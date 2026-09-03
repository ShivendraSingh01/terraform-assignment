variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the virtual machine scale set"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used to name VMSS resources"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machine scale set"
}

variable "vmss_sku" {
  type        = string
  description = "SKU for the virtual machine scale set"
  default     = "Standard_B2ts_v2"
}

variable "vmss_instance_count" {
  type        = number
  description = "Instance count for the virtual machine scale set"
  default     = 2
}

variable "public_key" {
  type        = string
  description = "SSH public key for the virtual machine scale set"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet for the virtual machine scale set"
}

variable "backend_address_pool_id" {
  type        = string
  description = "ID of the backend address pool for the virtual machine scale set"
}

variable "identity_id" {
  type        = string
  description = "ID of the user-assigned managed identity for the virtual machine scale set"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones used by the virtual machine scale set"
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

variable "tags" {
  type        = map(string)
  description = "Tags to apply to VMSS resources"
  default     = {}
}
