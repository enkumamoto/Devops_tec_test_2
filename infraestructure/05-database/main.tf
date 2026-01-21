resource "azurerm_resource_group" "db" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location

  tags = var.tags

  lifecycle {
    prevent_destroy = true
  }
}
