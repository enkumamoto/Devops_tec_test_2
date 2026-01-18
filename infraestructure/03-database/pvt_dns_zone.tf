resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.db.name

  tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "03-database"
    Component   = "private-dns"
    Purpose     = "postgresql-private-resolution"
    Service     = "postgresql"
  })

  lifecycle {
    prevent_destroy       = true
    create_before_destroy = true
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "link-${var.environment}-devops-vnet-to-postgres"
  resource_group_name   = azurerm_resource_group.db.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = var.vnet_id
  tags                  = merge(var.tags)
  lifecycle {
    ignore_changes = [tags]
  }
}
