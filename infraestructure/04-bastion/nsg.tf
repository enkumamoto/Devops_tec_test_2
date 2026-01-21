resource "azurerm_network_security_group" "bastion" {
  name                = "nsg-bastion-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name

  dynamic "security_rule" {
    for_each = var.allowed_source_ips

    content {
      name                       = "Allow-SSH-${replace(replace(security_rule.value, ".", "-"), "/", "-")}"
      priority                   = 100 + index(var.allowed_source_ips, security_rule.value)
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "${security_rule.value}/32"
      destination_port_range     = "22"
      source_port_range          = "*"
      destination_address_prefix = "*"
    }
  }

  tags = var.tags
}
