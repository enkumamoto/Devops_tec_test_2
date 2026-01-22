data "azurerm_resource_group" "aca" {
  name     = var.resource_group_name
  location = var.location
}

# Log Analytics Workspace para ACA logs
resource "azurerm_log_analytics_workspace" "aca" {
  name                = "log-aca-${var.environment}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.aca.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

# Container Apps Environment (substitui o cluster AKS)
resource "azurerm_container_app_environment" "devops" {
  name                       = "cae-${var.environment}"
  location                   = var.location
  resource_group_name        = data.azurerm_resource_group.aca.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aca.id

  infrastructure_subnet_id = local.aca_subnet_id

  tags = var.tags
}
