data "terraform_remote_state" "network" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstateeijidevops01"
    container_name       = "tfstate"
    key                  = "network.tfstate"
  }
}
