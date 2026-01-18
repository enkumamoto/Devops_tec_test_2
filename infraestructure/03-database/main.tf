resource "azurerm_resource_group" "db" {
  name     = var.resource_group_name
  location = var.location

  # Standard tags
  tags = merge(var.tags)

  # Lifecycle policies
  lifecycle {
    prevent_destroy       = var.environment == "prod" ? true : false
    create_before_destroy = true
  }
}
