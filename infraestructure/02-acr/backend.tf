# backend.tf (APENAS backend, SEM provider)
terraform {
  backend "azurerm" {
    resource_group_name  = "__TF_BACKEND_RESOURCE_GROUP__"
    storage_account_name = "__TF_BACKEND_STORAGE_ACCOUNT__"
    container_name       = "__TF_BACKEND_CONTAINER__"
    key                  = "acr.tfstate"
  }
}
