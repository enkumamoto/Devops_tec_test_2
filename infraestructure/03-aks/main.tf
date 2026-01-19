resource "azurerm_resource_group" "aks" {
  name     = "rg-${var.resource_group_name}-${var.environment}"
  location = var.location

  tags = merge(var.tags)

  lifecycle {
    create_before_destroy = true
  }
}
