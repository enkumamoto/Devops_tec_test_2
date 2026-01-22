resource "azurerm_network_security_group" "bastion" {
  name                = "nsg-bastion-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name

  # Remova o bloco dynamic inteiro e substitua por esta regra única para permitir SSH de qualquer IP
  security_rule {
    name                       = "Allow-SSH-Any"
    priority                   = 100 # Prioridade baixa para ser avaliada primeiro
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*" # Permite de qualquer IP externo
    source_port_range          = "*"
    destination_address_prefix = "*"  # Aplica à VM bastion (ou ajuste se necessário)
    destination_port_range     = "22" # Porta SSH
  }

  # Mantenha as outras regras existentes
  security_rule {
    name                       = "AllowVnetInBound"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
    destination_address_prefix = "VirtualNetwork"
    destination_port_range     = "*"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancerInBound"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "AzureLoadBalancer"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
  }

  security_rule {
    name                       = "DenyAllInBound"
    priority                   = 4000 # Número mais alto
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
  }

  tags = var.tags
}
