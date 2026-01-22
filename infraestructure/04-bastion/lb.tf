resource "azurerm_lb" "bastion_internal" {
  name                = "lb-bastion-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name
  sku                 = "Standard"

  dynamic "frontend_ip_configuration" {
    for_each = var.bastion_subnet_id != "" ? [1] : []

    content {
      name                          = "LoadBalancerFrontEnd"
      subnet_id                     = var.bastion_subnet_id
      private_ip_address_allocation = "Dynamic"
    }
  }

  tags = var.tags
}

resource "azurerm_lb_probe" "bastion_ssh_probe" {
  name = "ssh-probe"
  #resource_group_name = azurerm_resource_group.bastion.name
  loadbalancer_id     = azurerm_lb.bastion_internal.id
  protocol            = "Tcp"
  port                = 22
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "bastion_ssh_rule" {
  name = "ssh-rule"
  #resource_group_name            = azurerm_resource_group.bastion.name
  loadbalancer_id                = azurerm_lb.bastion_internal.id
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  #backend_address_pool_id        = azurerm_lb_backend_address_pool.bastion_backend_pool.id
  probe_id = azurerm_lb_probe.bastion_ssh_probe.id
}

resource "azurerm_lb_backend_address_pool" "bastion_backend_pool" {
  name = "bastion-backend-pool"
  #resource_group_name = azurerm_resource_group.bastion.name
  loadbalancer_id = azurerm_lb.bastion_internal.id
}

resource "azurerm_network_interface_backend_address_pool_association" "bastion_nic_lb_backend" {
  network_interface_id    = azurerm_network_interface.bastion.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bastion_backend_pool.id
}
