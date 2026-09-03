locals {
  identity_name = "${var.name_prefix}-identity"
}

resource "azurerm_user_assigned_identity" "identity" {
  name                = local.identity_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_role_assignment" "identity_role_assignment" {
  scope                = var.scope
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}
