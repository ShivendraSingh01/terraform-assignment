# Core
resource_group_name = "infra_rg"
location            = "eastasia"
name_prefix         = "devdemo"
admin_username      = "azureuser"
vnet_address_space  = "10.10.0.0/16"

# Network
app_gateway_subnet_address_prefix = "10.10.0.0/24"
private_subnet_address_prefixes   = ["10.10.1.0/24", "10.10.2.0/24"]

# Access
frontend_port             = 80
backend_port              = 80
ssh_source_address_prefix = "*"

# Health probe
health_probe_path = "/healthz"
health_probe_host = "127.0.0.1"

# Application Gateway
app_gateway_sku_name     = "Standard_v2"
app_gateway_sku_tier     = "Standard_v2"
app_gateway_sku_capacity = 2

# VMSS
vmss_sku            = "Standard_B2ts_v2"
vmss_instance_count = 2
zones               = ["1", "2"]

# Autoscale
autoscale_minimum_instances = 1
autoscale_maximum_instances = 3
scale_out_cpu_threshold     = 75
scale_in_cpu_threshold      = 25

# Identity
identity_role_definition_name = "Reader"

# Storage
storage_account_name   = "devdemostorage1703"
storage_container_name = null

# Tags
tags = {}
