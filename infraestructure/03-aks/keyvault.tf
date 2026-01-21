
# Key Vault
resource "azurerm_key_vault" "devops" {
  name                = coalesce(var.key_vault_name, "kv-${var.aks_name}-${var.environment}")
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku

  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = merge(var.tags, {
    Component = "key-vault"
  })

  lifecycle {
    ignore_changes = [
      network_acls
    ]
  }
}

# Access Policy para a Managed Identity do AKS
resource "azurerm_key_vault_access_policy" "aks" {
  key_vault_id = azurerm_key_vault.devops.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "Get", "List"
  ]

  certificate_permissions = [
    "Get", "List"
  ]
}

# Access Policy para o Service Principal do Terraform
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
    "Get", "List", "Create", "Delete", "Update", "Import", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers"
  ]

  lifecycle {
    ignore_changes = [
      certificate_permissions,
      key_permissions,
      secret_permissions,
      object_id,
      tenant_id
    ]
  }
}


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
    ignore_changes  = [value]
    prevent_destroy = true
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
