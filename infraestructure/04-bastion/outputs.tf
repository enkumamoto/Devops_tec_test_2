output "bastion_private_ip" {
  value = azurerm_network_interface.bastion.private_ip_address
}
