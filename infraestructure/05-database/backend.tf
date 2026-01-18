terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "__TF_BACKEND_RESOURCE_GROUP__"
    storage_account_name = "__TF_BACKEND_STORAGE_ACCOUNT__"
    container_name       = "__TF_BACKEND_CONTAINER__"
    key                  = "database.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    postgresql_flexible_server {
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  subscription_id = var.subscription_id
}
