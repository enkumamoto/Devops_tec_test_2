# O Azure Bastion exige uma subnet com este nome exato
resource "azurerm_subnet" "bastion_service_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = data.terraform_remote_state.network.outputs.resource_group_name
  virtual_network_name = data.terraform_remote_state.network.outputs.vnet_name
  address_prefixes     = ["10.0.255.0/27"] # Exemplo de range pequeno
}

resource "azurerm_public_ip" "bastion_service_pip" {
  name                = "pip-bastion-service"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "main" {
  name                = "bastion-service"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_service_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_service_pip.id
  }
}
