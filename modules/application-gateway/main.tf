

locals {
  backend_address_pool_name  = "${var.name_prefix}-backend-pool"
  backend_http_settings_name = "${var.name_prefix}-http-settings"
  frontend_ip_name           = "${var.name_prefix}-frontend-ip"
  frontend_port_name         = "${var.name_prefix}-frontend-port"
  gateway_ip_config_name     = "${var.name_prefix}-gateway-ip-config"
  gateway_name               = "${var.name_prefix}-appgw"
  http_listener_name         = "${var.name_prefix}-http-listener"
  probe_name                 = "${var.name_prefix}-health-probe"
  public_ip_name             = "${var.name_prefix}-appgw-pip"
  request_routing_rule_name  = "${var.name_prefix}-routing-rule"
}

resource "azurerm_public_ip" "public_ip" {
  name                = local.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_application_gateway" "gateway" {
  name                = local.gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_config_name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.backend_http_settings_name
    cookie_based_affinity = "Disabled"
    port                  = var.backend_port
    probe_name            = local.probe_name
    protocol              = "Http"
    request_timeout       = 20
  }

  probe {
    name                = local.probe_name
    host                = var.health_probe_host
    protocol            = "Http"
    path                = var.health_probe_path
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
  }

  http_listener {
    name                           = local.http_listener_name
    frontend_ip_configuration_name = local.frontend_ip_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.http_listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.backend_http_settings_name
    priority                   = 100
  }
}
