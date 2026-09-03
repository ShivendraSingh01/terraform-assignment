locals {
  app_gateway_subnet_name = "${var.name_prefix}-appgw-subnet"
  nat_gateway_name        = "${var.name_prefix}-natgw"
  nat_public_ip_name      = "${var.name_prefix}-natgw-pip"
  private_subnet_names = {
    for index, cidr in var.private_subnet_address_prefixes :
    tostring(index) => format("%s-private-%02d", var.name_prefix, index + 1)
  }
  vnet_name = "${var.name_prefix}-vnet"
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]
  tags                = var.tags
}

resource "azurerm_subnet" "app_gateway" {
  name                 = local.app_gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.app_gateway_subnet_address_prefix]
}

resource "azurerm_subnet" "private" {
  for_each = {
    for index, cidr in var.private_subnet_address_prefixes :
    tostring(index) => cidr
  }

  name                 = local.private_subnet_names[each.key]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}

resource "azurerm_public_ip" "public_ip" {
  name                = local.nat_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = local.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  for_each = azurerm_subnet.private

  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
