output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "app_gateway_subnet_id" {
  value = azurerm_subnet.app_gateway.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private["0"].id
}

output "private_subnet_ids" {
  value = [
    for key in sort(keys(azurerm_subnet.private)) :
    azurerm_subnet.private[key].id
  ]
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.nat_gateway.id
}
