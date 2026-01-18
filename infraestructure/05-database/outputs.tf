output "postgresql_server_id" {
  description = "ID do PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.devops.id
}

output "postgresql_server_name" {
  description = "Nome do PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.devops.name
}

output "postgresql_fqdn" {
  description = "FQDN privado do PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.devops.fqdn
}

output "postgresql_database_name" {
  description = "Nome do banco de dados inicial"
  value       = azurerm_postgresql_flexible_server_database.app.name
}

output "postgresql_admin_username" {
  description = "Usuário administrador do PostgreSQL"
  value       = azurerm_postgresql_flexible_server.devops.administrator_login
  sensitive   = true
}

output "postgresql_admin_password" {
  description = "Senha do administrador do PostgreSQL"
  value       = random_password.postgres_admin.result
  sensitive   = true
}

output "postgresql_private_dns_zone_id" {
  description = "ID da Private DNS Zone do PostgreSQL"
  value       = azurerm_private_dns_zone.postgres.id
}

output "postgresql_connection_details" {
  description = "Detalhes de conexão para aplicações"
  value = {
    host     = azurerm_postgresql_flexible_server.devops.fqdn
    port     = 5432
    database = azurerm_postgresql_flexible_server_database.app.name
    username = azurerm_postgresql_flexible_server.devops.administrator_login
    sslmode  = "require"
  }
  sensitive = true
}
