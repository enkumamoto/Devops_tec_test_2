resource "azurerm_resource_group" "bastion" {
  name     = "rg-${var.resource_group_name}-${var.environment}"
  location = var.location
}
