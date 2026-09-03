locals {
  autoscale_name = "${var.name_prefix}-vmss-autoscale"
  nic_name       = "${var.name_prefix}-vmss-nic"
  vmss_name      = "${var.name_prefix}-vmss"
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = local.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name
  admin_username      = var.admin_username
  sku                 = var.vmss_sku
  instances           = var.vmss_instance_count
  zones               = var.zones
  tags                = var.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  network_interface {
    name    = local.nic_name
    primary = true

    ip_configuration {
      name      = "internal"
      subnet_id = var.subnet_id
      primary   = true

      application_gateway_backend_address_pool_ids = [var.backend_address_pool_id]
    }
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
    ignore_changes = [instances]
  }
}

resource "azurerm_virtual_machine_scale_set_extension" "nginx" {
  name                         = "install-nginx"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"
  auto_upgrade_minor_version   = true

  settings = jsonencode({
    commandToExecute = "apt-get update && apt-get install -y nginx && systemctl enable nginx && systemctl restart nginx && echo 'devdemo VMSS backend healthy' > /var/www/html/index.html"
  })
}

resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = local.autoscale_name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

  profile {
    name = "autoscale-profile"

    capacity {
      minimum = tostring(var.autoscale_minimum_instances)
      maximum = tostring(var.autoscale_maximum_instances)
      default = tostring(var.vmss_instance_count)
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
        threshold          = var.scale_out_cpu_threshold
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
        threshold          = var.scale_in_cpu_threshold
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
