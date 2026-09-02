variable "resource_group_name" {
  description = "The name of the resource group where the remote state storage account is located."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account to be created for remote state storage."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container to be created for remote state storage."
  type        = string
}