# terraform {
#   required_version = ">= 1.5.0"

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

provider "azurerm" {
  features {} # Simplificado: remova subblocos para evitar conflitos
  # subscription_id = var.subscription_id
}
