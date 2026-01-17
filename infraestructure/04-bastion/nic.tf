resource "azurerm_network_interface" "bastion" {
  name                = "nic-bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.network.outputs.bastion_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
