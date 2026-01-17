resource "azurerm_key_vault" "devops" {
  name                       = "kv-devops-${var.environment}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id

    secret_permissions = [
      "Get",
      "List"
    ]
  }
}
