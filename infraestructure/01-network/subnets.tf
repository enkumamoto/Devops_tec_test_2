resource "azurerm_subnet" "aks" {
  name                 = local.subnet_names.aks
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = var.aks_subnet_address_prefixes

  service_endpoints = [
    "Microsoft.ContainerRegistry",
    "Microsoft.KeyVault",
    "Microsoft.Storage"
  ]

  depends_on = [azurerm_virtual_network.devops]
}

resource "azurerm_subnet" "database" {
  name                 = local.subnet_names.database
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = var.database_subnet_address_prefixes
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]

  delegation {
    name = "fs-postgresql-delegation"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

  depends_on = [azurerm_virtual_network.devops]
}

resource "azurerm_subnet" "bastion" {
  name                 = local.subnet_names.bastion
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = var.bastion_subnet_address_prefixes
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]
}
