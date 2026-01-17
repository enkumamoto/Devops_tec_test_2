resource "azurerm_subnet" "aks" {
  name                 = "subnet-aks"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = [var.subnet_aks_cidr]

  depends_on = [azurerm_virtual_network.devops]
}

resource "azurerm_subnet" "db" {
  name                 = "subnet-db"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = [var.subnet_db_cidr]

  depends_on = [azurerm_virtual_network.devops]

  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "bastion" {
  name                 = "subnet-bastion"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = [var.subnet_bastion_cidr]

  depends_on = [azurerm_virtual_network.devops]
}
