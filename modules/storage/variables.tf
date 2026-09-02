variable "resource_group_name" {
  type        = string
  description = "Resource group name" 
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
}

variable "storage_container_name" {
  type        = string
  description = "Name of the storage container"
}