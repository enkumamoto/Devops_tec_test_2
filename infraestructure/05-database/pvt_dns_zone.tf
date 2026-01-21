resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.db.name
  #zone_type           = "private"


  tags = merge(var.tags)

  lifecycle {
    prevent_destroy       = true
    create_before_destroy = true
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "link-${var.environment}-vnet-postgres"
  resource_group_name   = azurerm_resource_group.db.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = var.vnet_id

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}
