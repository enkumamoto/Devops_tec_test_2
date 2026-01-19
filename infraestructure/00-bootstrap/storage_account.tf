resource "azurerm_storage_account" "devops" {
  # Nome deve ser único globalmente, max 24 chars, somente lowercase
  name                     = "tfstatedevdevops"
  resource_group_name      = azurerm_resource_group.devops.name
  location                 = azurerm_resource_group.devops.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  # Segurança
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false

  # Blob properties
  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 30
    }

    container_delete_retention_policy {
      days = 7
    }
  }

  tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "bootstrap"
    Purpose     = "terraform-state-backend"
  })

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      account_replication_type
    ]
  }
}

resource "azurerm_storage_container" "devops" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.devops.name
  container_access_type = "private"

  metadata = {
    purpose     = "terraform-state-files"
    environment = var.environment
    created_by  = "terraform-bootstrap"
  }
}

resource "azurerm_storage_account_network_rules" "devops" {
  storage_account_id = azurerm_storage_account.devops.id

  default_action             = "Deny"
  ip_rules                   = []
  virtual_network_subnet_ids = []

  bypass = ["AzureServices"]
}

data "azurerm_storage_account" "devops" {
  name                = azurerm_storage_account.devops.name
  resource_group_name = azurerm_resource_group.devops.name

  depends_on = [azurerm_storage_account.devops]
}
