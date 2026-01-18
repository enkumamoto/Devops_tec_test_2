output "postgresql_server_id" {
  value = azurerm_postgresql_flexible_server.devops.id
}

output "postgresql_server_name" {
  value = azurerm_postgresql_flexible_server.devops.name
}

output "postgresql_server_fqdn" {
  value = azurerm_postgresql_flexible_server.devops.fqdn
}

output "postgresql_server_hostname" {
  value = azurerm_postgresql_flexible_server.devops.name
}

output "postgresql_server_location" {
  value = azurerm_postgresql_flexible_server.devops.location
}

output "postgresql_database_name" {
  value = azurerm_postgresql_flexible_server_database.app.name
}

output "postgresql_administrator_login" {
  value     = azurerm_postgresql_flexible_server.devops.administrator_login
  sensitive = true
}

output "postgresql_administrator_password" {
  value     = random_password.postgres_admin.result
  sensitive = true
}

output "postgresql_connection_string" {
  value     = "postgresql://${azurerm_postgresql_flexible_server.devops.administrator_login}@${azurerm_postgresql_flexible_server.devops.fqdn}:5432/${azurerm_postgresql_flexible_server_database.app.name}"
  sensitive = false
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.postgres.id
}

output "private_dns_zone_name" {
  value = azurerm_private_dns_zone.postgres.name
}

output "resource_group_name" {
  value = azurerm_resource_group.devops.name
}

output "resource_group_id" {
  value = azurerm_resource_group.devops.id
}

output "postgresql_connection_details" {
  value = {
    host        = azurerm_postgresql_flexible_server.devops.fqdn
    port        = 5432
    database    = azurerm_postgresql_flexible_server_database.app.name
    username    = azurerm_postgresql_flexible_server.devops.administrator_login
    sslmode     = "require"
    sslrootcert = ""
  }
  sensitive = false
}

output "environment" {
  value = var.environment
}

output "location" {
  value = var.location
}

output "key_vault_secrets_to_set" {
  value = {
    "postgresql-host"     = azurerm_postgresql_flexible_server.devops.fqdn
    "postgresql-username" = azurerm_postgresql_flexible_server.devops.administrator_login
    "postgresql-password" = "***PASSWORD_REDACTED***" # Will be set by pipeline
    "postgresql-database" = azurerm_postgresql_flexible_server_database.app.name
  }
  sensitive = false
}

output "module_summary" {
  value = {
    postgresql_server = {
      id       = azurerm_postgresql_flexible_server.devops.id
      name     = azurerm_postgresql_flexible_server.devops.name
      fqdn     = azurerm_postgresql_flexible_server.devops.fqdn
      location = azurerm_postgresql_flexible_server.devops.location
      version  = azurerm_postgresql_flexible_server.devops.version
      sku      = azurerm_postgresql_flexible_server.devops.sku_name
    }
    database = {
      name      = azurerm_postgresql_flexible_server_database.app.name
      charset   = azurerm_postgresql_flexible_server_database.app.charset
      collation = azurerm_postgresql_flexible_server_database.app.collation
    }
    dns = {
      zone_id   = azurerm_private_dns_zone.postgres.id
      zone_name = azurerm_private_dns_zone.postgres.name
    }
    resource_group = {
      name = azurerm_resource_group.devops.name
      id   = azurerm_resource_group.devops.id
    }
  }
  sensitive = false
}
