resource "tls_private_key" "bastion" {
  count     = var.generate_ssh_key ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "bastion" {
  name                = "${var.vm_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.bastion.name
  location            = var.location
  size                = var.vm_size

  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.bastion.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = local.effective_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = filebase64("${path.module}/cloud-init.yaml")

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Role        = "bastion"
    }
  )

  lifecycle {
    ignore_changes = [
      admin_ssh_key,
      custom_data
    ]
  }
}
