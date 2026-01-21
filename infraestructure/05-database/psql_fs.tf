resource "random_password" "postgres_admin" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"

  lifecycle {
    ignore_changes = [length, special, override_special]
  }
}

resource "random_string" "postgres_username" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

resource "random_string" "server_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_postgresql_flexible_server" "devops" {
  name                = lower("${var.db_name}-${var.environment}-${random_string.server_suffix.result}")
  resource_group_name = azurerm_resource_group.db.name
  location            = var.location

  administrator_login    = "pgadmin${random_string.postgres_username.result}"
  administrator_password = random_password.postgres_admin.result

  version    = var.postgres_version
  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  zone       = var.zone != "" ? var.zone : null

  delegated_subnet_id = var.database_subnet_id
  private_dns_zone_id = azurerm_private_dns_zone.postgres.id

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  dynamic "high_availability" {
    for_each = var.high_availability_mode != "Disabled" ? [1] : []
    content {
      mode                      = var.high_availability_mode
      standby_availability_zone = var.zone == "1" ? "2" : "1"
    }
  }

  maintenance_window {
    day_of_week  = var.maintenance_window.day_of_week
    start_hour   = var.maintenance_window.start_hour
    start_minute = var.maintenance_window.start_minute
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      administrator_password,
      tags["LastModified"]
    ]
    create_before_destroy = true
  }
}

resource "azurerm_postgresql_flexible_server_database" "app" {
  name      = "appdb_${var.environment}"
  server_id = azurerm_postgresql_flexible_server.devops.id
  charset   = var.charset
  collation = var.collation

  lifecycle {
    prevent_destroy = true
  }
}
