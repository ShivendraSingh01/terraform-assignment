variable "identity_name" {
  type        = string
  description = "User assigned identity name"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the identity"
}

variable "scope" {
  type        = string
  description = "Scope of the role assignment"
}

variable "role_definition_name" {
  type        = string
  description = "Name of the role definition"
}