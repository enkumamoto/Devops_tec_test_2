# terraform {
#   required_version = ">= 1.5.0"

#   backend "azurerm" {
#     resource_group_name  = ""
#     storage_account_name = ""
#     container_name       = ""
#     key                  = "database.tfstate"
#     # use_azuread_auth     = false  # Remova se presente
#   }

#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 3.0"
#     }
#     random = {
#       source  = "hashicorp/random"
#       version = "~> 3.0"
#     }
#   }
# }
