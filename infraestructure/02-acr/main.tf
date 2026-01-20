resource "azurerm_container_registry" "devops" {
  name                = lower("${var.project}-${var.environment}-acr")
  resource_group_name = var.resource_group_name
  location            = var.location

  sku           = var.acr_sku
  admin_enabled = var.admin_enabled

  tags = {
    project     = var.project
    environment = var.environment
  }
}
