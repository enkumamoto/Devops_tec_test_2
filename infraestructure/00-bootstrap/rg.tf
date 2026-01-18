resource "azurerm_resource_group" "devops" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location

  # Standard tags for all resources
  tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "bootstrap"
    Purpose     = "terraform-state-backend"
    Created     = timestamp()
  })

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags["Created"]
    ]
  }
}
