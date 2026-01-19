resource "azurerm_resource_group" "devops" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location

  tags = merge(var.tags, {
    Environment = var.environment
    Purpose     = "terraform-state-backend"
    ManagedBy   = "Terraform"
  })

  lifecycle {
    prevent_destroy = false # Permitir destruição para testes
  }
}
