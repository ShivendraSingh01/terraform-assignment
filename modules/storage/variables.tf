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
  description = "Prefix used to name storage resources"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name"
}

variable "storage_container_name" {
  type        = string
  description = "Name of the storage container. Defaults to a name derived from name_prefix."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to storage resources"
  default     = {}
}
