resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
    name                = var.vmss_name
    location            = var.location
    resource_group_name = var.resource_group_name
    admin_username      = var.admin_username
    sku                 = var.vmss_sku
    instances           = var.vmss_instance_count
    zones = ["1", "2"]

    identity {
        type = "UserAssigned"
        identity_ids = [var.identity_id]
    }

    admin_ssh_key {
        username   = var.admin_username
        public_key = var.public_key
    }
    network_interface {
      name    = var.nic_name
      primary = true

      ip_configuration {
        name      = "internal"
        subnet_id = var.subnet_id
        primary   = true
        application_gateway_backend_address_pool_ids = [var.backend_address_pool_id]
      }
      network_security_group_id = var.nsg_id
    }

    os_disk {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
    lifecycle {
        ignore_changes = ["instances"]
    }
}

resource "azurerm_monitor_autoscale_settings" "autoscale" {
  name                = var.vmss_autoscale_name
  resource_group_name = var.resource_group_name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

  profile {
    name = "autoscale-profile"

    capacity {
      minimum = "1"
      maximum = "3"
      default = "2"
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_namespace   = "Microsoft.Compute/virtualMachineScaleSets"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_namespace   = "Microsoft.Compute/virtualMachineScaleSets"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }

}
