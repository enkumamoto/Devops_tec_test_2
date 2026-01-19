# Atualizar arquivo: infraestructure/01-network/backend.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "__TF_BACKEND_RESOURCE_GROUP__"
    storage_account_name = "__TF_BACKEND_STORAGE_ACCOUNT__"
    container_name       = "__TF_BACKEND_CONTAINER__"
    key                  = "network.tfstate"
  }

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
