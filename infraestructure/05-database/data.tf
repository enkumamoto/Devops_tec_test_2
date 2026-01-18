# ============================
# Azure Context
# ============================
data "azurerm_client_config" "current" {
  # Used for tenant_id, object_id, etc.
}

# ============================
# Remote State - Network
# ============================
data "terraform_remote_state" "network" {
  backend = "azurerm"

  config = {
    resource_group_name  = "__TF_BACKEND_RESOURCE_GROUP__"
    storage_account_name = "__TF_BACKEND_STORAGE_ACCOUNT__"
    container_name       = "__TF_BACKEND_CONTAINER__"
    key                  = "network.tfstate"
  }
}
