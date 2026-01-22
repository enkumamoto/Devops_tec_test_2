
resource "azurerm_resource_group" "network" {
  name     = "rg-${var.resource_group_name}-${var.environment}"
  location = var.location

  tags = merge(var.tags, {
    environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "01-network"
    Component   = "networking"
  })

  lifecycle {
    prevent_destroy       = false
    create_before_destroy = true
  }
}

locals {
  naming_prefix = "${var.environment}-devops"

  vnet_name = var.vnet_name != "" ? var.vnet_name : "vnet-${local.naming_prefix}"

  nsg_names = {
    aca      = "nsg-${local.naming_prefix}-aca"
    database = "nsg-${local.naming_prefix}-database"
    bastion  = "nsg-${local.naming_prefix}-bastion"
  }
  route_table_names = {
    aca = "rt-${local.naming_prefix}-aca"
  }

  subnet_names = {
    aca      = "snet-${local.naming_prefix}-aca"
    database = "snet-${local.naming_prefix}-database"
    bastion  = "snet-${local.naming_prefix}-bastion"
  }
}

