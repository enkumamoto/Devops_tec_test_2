resource "random_password" "postgresql" {
  length  = 16
  special = true
}

resource "azurerm_key_vault_secret" "postgresql_password" {
  name         = "postgresql-password"
  value        = random_password.postgresql.result
  key_vault_id = azurerm_key_vault.devops.id

  content_type = "database-credentials"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "database"
  }

  lifecycle {
    ignore_changes = [value, tags]
  }

  depends_on = [
    azurerm_key_vault.devops
  ]
}
