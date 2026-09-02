resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "networking" {
  source = "../../modules/networking"

  location              = var.location
  resource_group_name   = var.resource_group_name
  vnet_name             = "${var.prefix}-vnet"
  vnet_address_space    = "10.10.0.0/16"
  subnet_name           = "${var.prefix}-subnet"
  subnet_address_prefix = "10.10.1.0/24"
}

module "compute" {
  source = "../../modules/compute"

  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.networking.subnet_id
  nic_name            = "${var.prefix}-nic"
  vm_name             = "${var.prefix}-vm"
  admin_username      = var.admin_username
  public_key          = var.public_key
}
