output "app_gateway_nsg_id" {
  value = azurerm_network_security_group.app_gateway.id
}

output "vmss_nsg_id" {
  value = azurerm_network_security_group.vmss.id
}
