resource "azurerm_subnet" "aca" {
  name                 = local.subnet_names.aca
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = var.aca_subnet_address_prefixes

  delegation {
    name = "aca-delegation"

    service_delegation {
      name = "Microsoft.App/environments"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }

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
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  lifecycle {
    create_before_destroy = true
    #ignore_changes        = [tags["LastModified"]]
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

  lifecycle {
    create_before_destroy = true
    #ignore_changes        = [tags["LastModified"]]
  }

  depends_on = [azurerm_virtual_network.devops]
}

# Subnet para a sua VM Bastion (O Host que você vai gerenciar)
resource "azurerm_subnet" "mgmt" {
  name                 = var.snet_management
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = var.snet-management_address_prefixes

  lifecycle {
    create_before_destroy = true
    #ignore_changes        = [tags["LastModified"]]
  }

  depends_on = [azurerm_virtual_network.devops]
}
