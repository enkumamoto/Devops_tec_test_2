# data "terraform_remote_state" "network" {
#   backend = "azurerm"

#   config = {
#     resource_group_name  = "rg-terraform-state"
#     storage_account_name = "tfstateeijidevops01"
#     container_name       = "tfstate"
#     key                  = "network.tfstate"
#   }
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}
