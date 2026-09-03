variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the identity"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used to name identity resources"
}

variable "scope" {
  type        = string
  description = "Scope of the role assignment"
}

variable "role_definition_name" {
  type        = string
  description = "Name of the role definition"
  default     = "Reader"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to identity resources"
  default     = {}
}
