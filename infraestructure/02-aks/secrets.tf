resource "azurerm_key_vault_secret" "db_host" {
  name         = "DB-HOST"
  value        = var.db_host
  key_vault_id = azurerm_key_vault.devops.id
}

resource "azurerm_key_vault_secret" "db_user" {
  name         = "DB-USER"
  value        = var.db_user
  key_vault_id = azurerm_key_vault.devops.id
}
