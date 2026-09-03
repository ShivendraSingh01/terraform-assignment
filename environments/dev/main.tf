locals {
  common_tags = merge(var.tags, {
    Environment = "dev"
    ManagedBy   = "Terraform"
  })
}

module "resource_group" {
  source = "../../modules/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.common_tags
}

module "network" {
  source = "../../modules/network"

  name_prefix                       = var.name_prefix
  resource_group_name               = module.resource_group.resource_group_name
  location                          = var.location
  vnet_address_space                = var.vnet_address_space
  app_gateway_subnet_address_prefix = var.app_gateway_subnet_address_prefix
  private_subnet_address_prefixes   = var.private_subnet_address_prefixes
  tags                              = local.common_tags
}

module "nsg" {
  source = "../../modules/nsg"

  name_prefix                       = var.name_prefix
  resource_group_name               = module.resource_group.resource_group_name
  location                          = var.location
  app_gateway_subnet_id             = module.network.app_gateway_subnet_id
  private_subnet_ids                = module.network.private_subnet_ids
  app_gateway_subnet_address_prefix = var.app_gateway_subnet_address_prefix
  frontend_port                     = var.frontend_port
  backend_port                      = var.backend_port
  tags                              = local.common_tags
}

module "identity" {
  source = "../../modules/identity"

  name_prefix          = var.name_prefix
  resource_group_name  = module.resource_group.resource_group_name
  location             = var.location
  scope                = module.resource_group.resource_group_id
  role_definition_name = var.identity_role_definition_name
  tags                 = local.common_tags
}

module "application_gateway" {
  source = "../../modules/application-gateway"

  name_prefix         = var.name_prefix
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  subnet_id           = module.network.app_gateway_subnet_id
  sku_name            = var.app_gateway_sku_name
  sku_tier            = var.app_gateway_sku_tier
  sku_capacity        = var.app_gateway_sku_capacity
  frontend_port       = var.frontend_port
  backend_port        = var.backend_port
  health_probe_host   = var.health_probe_host
  health_probe_path   = var.health_probe_path
  tags                = local.common_tags

  depends_on = [module.nsg]
}

module "vmss" {
  source = "../../modules/vmss"

  name_prefix                 = var.name_prefix
  location                    = var.location
  resource_group_name         = module.resource_group.resource_group_name
  subnet_id                   = module.network.private_subnet_id
  backend_address_pool_id     = module.application_gateway.backend_address_pool_id
  identity_id                 = module.identity.identity_id
  admin_username              = var.admin_username
  public_key                  = file(pathexpand(var.public_key_path))
  vmss_sku                    = var.vmss_sku
  vmss_instance_count         = var.vmss_instance_count
  zones                       = var.zones
  autoscale_minimum_instances = var.autoscale_minimum_instances
  autoscale_maximum_instances = var.autoscale_maximum_instances
  scale_out_cpu_threshold     = var.scale_out_cpu_threshold
  scale_in_cpu_threshold      = var.scale_in_cpu_threshold
  tags                        = local.common_tags

  depends_on = [module.nsg]
}

module "storage" {
  source = "../../modules/storage"

  name_prefix            = var.name_prefix
  resource_group_name    = module.resource_group.resource_group_name
  location               = var.location
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  tags                   = local.common_tags
}
