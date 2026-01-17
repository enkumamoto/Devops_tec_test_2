resource "azurerm_network_security_group" "bastion" {
  name                = "nsg-bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name

  security_rule {
    name                       = "Allow-SSH-Internal"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = var.allowed_ssh_subnet
    destination_port_range     = "22"
    source_port_range          = "*"
    destination_address_prefix = "*"
  }
}
