

resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location

  tags = merge(var.tags)

  lifecycle {
    prevent_destroy       = false
    create_before_destroy = true
  }
}
