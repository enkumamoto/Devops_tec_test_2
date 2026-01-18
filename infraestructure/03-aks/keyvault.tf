
resource "azurerm_key_vault_secret" "postgresql_host" {
  name         = "postgresql-host"
  value        = "postgresql-server-placeholder.devops.internal"
  key_vault_id = azurerm_key_vault.devops.id

  content_type = "database-connection"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "database"
    Sensitive   = "true"
  }

  lifecycle {
    ignore_changes        = [value, tags]
    create_before_destroy = true
  }

  depends_on = [
    azurerm_key_vault.devops,
    azurerm_key_vault_access_policy.aks
  ]
}

resource "azurerm_key_vault_secret" "postgresql_username" {
  name         = "postgresql-username"
  value        = "postgres"
  key_vault_id = azurerm_key_vault.devops.id

  content_type = "database-credentials"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "database"
    Sensitive   = "true"
  }

  lifecycle {
    ignore_changes        = [value, tags]
    create_before_destroy = true
  }

  depends_on = [
    azurerm_key_vault.devops,
    azurerm_key_vault_access_policy.aks
  ]
}

resource "azurerm_key_vault_secret" "postgresql_password" {
  name         = "postgresql-password"
  value        = base64encode(random_password.postgresql.result)
  key_vault_id = azurerm_key_vault.devops.id

  content_type = "database-credentials"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "database"
    Sensitive   = "true"
  }

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [
    azurerm_key_vault.devops,
    azurerm_key_vault_access_policy.aks
  ]
}

resource "random_password" "postgresql" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"

  lifecycle {
    ignore_changes = [length, special, override_special]
  }
}

resource "azurerm_key_vault_secret" "app_secret_key" {
  name         = "app-secret-key"
  value        = base64encode(random_password.app_secret.result)
  key_vault_id = azurerm_key_vault.devops.id

  content_type = "application-secret"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "application"
    Sensitive   = "true"
  }

  depends_on = [
    azurerm_key_vault.devops,
    azurerm_key_vault_access_policy.aks
  ]
}

resource "random_password" "app_secret" {
  length  = 32
  special = false
}
