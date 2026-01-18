resource "random_string" "kv_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_key_vault" "devops" {
  name = lower(
    substr(
      "kv-devops-${var.environment}-${random_string.kv_suffix.result}",
      0, 24
    )
  )

  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  purge_protection_enabled   = var.environment == "prod" ? true : false
  soft_delete_retention_days = 30

  public_network_access_enabled = false

  tags = merge(var.tags)

  lifecycle {
    prevent_destroy = var.environment == "prod" ? true : false

    ignore_changes = [name]
  }
}

resource "azurerm_key_vault_access_policy" "aks" {

  key_vault_id = azurerm_key_vault.devops.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",     # For updating secrets
    "Delete",  # For rotating secrets
    "Recover", # For soft-deleted secrets
    "Backup",
    "Restore"
  ]

  certificate_permissions = [
    "Get",
    "List",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]
}
