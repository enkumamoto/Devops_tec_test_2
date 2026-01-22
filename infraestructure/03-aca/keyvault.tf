# Key Vault (mantido, mas sem policies de AKS)
resource "azurerm_key_vault" "devops" {
  name                = coalesce(var.key_vault_name, "kv-aca-${var.environment}")
  location            = var.location
  resource_group_name = azurerm_resource_group.aca.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku

  enabled_for_disk_encryption     = false # ACA não usa disk encryption
  enabled_for_deployment          = true  # Importante para ACA
  enabled_for_template_deployment = true

  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = merge(var.tags, {
    Component = "key-vault"
  })
}

# Access Policy para o Service Principal do Terraform (mantido)
resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id = azurerm_key_vault.devops.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "List", "Create", "Delete", "Update", "Import", "Backup", "Restore"
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Backup", "Restore", "Purge"
  ]

  certificate_permissions = [
    "Get", "List", "Create", "Delete", "Update", "Import", "Backup", "Restore"
  ]
}

# Secrets (mantidos, mas simplificados)
resource "azurerm_key_vault_secret" "postgresql_host" {
  name         = "postgresql-host"
  value        = var.postgresql_host
  key_vault_id = azurerm_key_vault.devops.id

  content_type = "database-connection"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "database"
  }

  depends_on = [azurerm_key_vault_access_policy.terraform]
}

resource "azurerm_key_vault_secret" "postgresql_username" {
  name         = "postgresql-username"
  value        = var.postgresql_username
  key_vault_id = azurerm_key_vault.devops.id

  content_type = "database-credentials"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "database"
  }

  depends_on = [azurerm_key_vault_access_policy.terraform]
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

  depends_on = [azurerm_key_vault_access_policy.terraform]
}

resource "random_password" "postgresql" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "app_secret_key" {
  name         = "app-secret-key"
  value        = random_password.app_secret.result
  key_vault_id = azurerm_key_vault.devops.id

  content_type = "application-secret"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "application"
  }

  depends_on = [azurerm_key_vault_access_policy.terraform]
}

resource "random_password" "app_secret" {
  length  = 32
  special = false
}
