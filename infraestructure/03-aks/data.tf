data "azurerm_client_config" "current" {}

data "terraform_remote_state" "network" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.tf_backend_resource_group
    storage_account_name = var.tf_backend_storage_account
    container_name       = var.tf_backend_container
    key                  = "network.tfstate"
    sas_token            = var.tf_backend_sas_token
  }
}

data "terraform_remote_state" "acr" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.tf_backend_resource_group
    storage_account_name = var.tf_backend_storage_account
    container_name       = var.tf_backend_container
    key                  = "acr.tfstate"
    sas_token            = var.tf_backend_sas_token
  }
}

data "azurerm_resource_group" "aks" {
  name = var.resource_group_name
}
