resource "azurerm_postgresql_flexible_server" "devops" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.db.name
  location            = azurerm_resource_group.db.location

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  version    = var.postgres_version
  sku_name   = var.sku_name
  storage_mb = var.storage_mb

  delegated_subnet_id = azurerm_subnet.postgres.id
  private_dns_zone_id = azurerm_private_dns_zone.postgres.id

  backup_retention_days = var.backup_retention_days

  high_availability {
    mode = "ZoneRedundant"
  }
}
