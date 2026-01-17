data "terraform_remote_state" "network" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.network_state.resource_group_name
    storage_account_name = var.network_state.storage_account_name
    container_name       = var.network_state.container_name
    key                  = var.network_state.key
  }
}

data "azurerm_client_config" "current" {}

