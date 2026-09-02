

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_application_gateway" "gateway" {
    name                = var.gateway_name
    resource_group_name = var.resource_group_name
    location            = var.location

    sku {
        name     = var.sku_name
        tier     = var.sku_tier
        capacity = var.sku_capacity
    }

    gateway_ip_configuration {
        name      = var.gateway_ip_configuration_name
        subnet_id = var.subnet_id
    }

    frontend_port {
        name = var.frontend_port_name
        port = 80
    }

    frontend_ip_configuration {
        name                 = var.frontend_ip_configuration_name
        subnet_id            = var.subnet_id
        private_ip_address   = var.private_ip_address
        private_ip_address_allocation = "Static"
    }

    backend_address_pool {
        name = var.gateway_backend_address_pool_name
    }

    backend_http_settings {
        name                  = var.gateway_backend_http_settings_name
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 20
    }
    probe {
        name                = var.gateway_probe_name
        protocol            = "Http"
        path                = "/"
        interval            = 30
        timeout             = 30
        unhealthy_threshold = 3
    }
    http_listener {
        name                           = var.gateway_http_listener_name
        frontend_ip_configuration_name = var.frontend_ip_configuration_name
        frontend_port_name             = var.frontend_port_name
        protocol                       = "Http"
    }
    request_routing_rule {
        name                       = var.gateway_request_routing_rule_name
        rule_type                  = "Basic"
        http_listener_name         = var.gateway_http_listener_name
        backend_address_pool_name  = var.gateway_backend_address_pool_name
        backend_http_settings_name = var.gateway_backend_http_settings_name
    }
}
