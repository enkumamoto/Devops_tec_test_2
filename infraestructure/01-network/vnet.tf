resource "azurerm_virtual_network" "devops" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name

  address_space = var.vnet_address_space

  tags = merge(var.tags)

  lifecycle {
    ignore_changes = [
      tags["LastModified"]
    ]
  }
}
