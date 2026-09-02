terraform {
	backend "azurerm" {
        resource_group_name  = "terraform_rg"
        storage_account_name = "terraformstorage1703"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}
