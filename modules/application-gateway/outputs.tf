output "backend_address_pool_id" {
  value = one(
    azurerm_application_gateway.gateway.backend_address_pool
  ).id
}