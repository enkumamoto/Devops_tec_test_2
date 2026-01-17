resource "azurerm_virtual_network" "devops" {
  name                = "vnet-devops-test"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = [var.vnet_cidr]
}
