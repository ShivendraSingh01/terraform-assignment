locals {
  app_gateway_nsg_name = "${var.name_prefix}-appgw-nsg"
  vmss_nsg_name        = "${var.name_prefix}-vmss-nsg"
}

resource "azurerm_network_security_group" "app_gateway" {
  name                = local.app_gateway_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "app_gateway_http" {
  name                        = "Allow-HTTP-Internet"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = tostring(var.frontend_port)
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.app_gateway.name
}

resource "azurerm_network_security_rule" "app_gateway_manager" {
  name                        = "Allow-GatewayManager"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "65200-65535"
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.app_gateway.name
}

resource "azurerm_network_security_group" "vmss" {
  name                = local.vmss_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "vmss_from_app_gateway" {
  name                        = "Allow-AppGateway-HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = tostring(var.backend_port)
  source_address_prefix       = var.app_gateway_subnet_address_prefix
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vmss.name
}

resource "azurerm_subnet_network_security_group_association" "app_gateway" {
  subnet_id                 = var.app_gateway_subnet_id
  network_security_group_id = azurerm_network_security_group.app_gateway.id
}

resource "azurerm_subnet_network_security_group_association" "private" {
  for_each = {
    for index, subnet_id in var.private_subnet_ids :
    tostring(index) => subnet_id
  }

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.vmss.id
}
