resource "azurerm_subnet" "postgres" {
  name                 = "snet-postgres"
  resource_group_name  = data.terraform_remote_state.network.outputs.vnet_rg_name
  virtual_network_name = data.terraform_remote_state.network.outputs.vnet_name
  address_prefixes     = ["10.0.20.0/24"]

  delegation {
    name = "postgresql"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}
