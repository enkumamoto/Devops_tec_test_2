# ============================
# ACA - Core Outputs
# ============================

output "aca_environment_id" {
  description = "The ID of the Container Apps Environment"
  value       = azurerm_container_app_environment.devops.id
}

output "aca_environment_name" {
  description = "The name of the Container Apps Environment"
  value       = azurerm_container_app_environment.devops.name
}

output "aca_app_url" {
  description = "The URL of the FastAPI container app"
  value       = azurerm_container_app.fastapi.ingress[0].fqdn
}

output "aca_location" {
  description = "The Azure region where ACA is deployed"
  value       = var.location
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.aca.id
}

# ============================
# Resource Group
# ============================

output "resource_group_name" {
  description = "The name of the Resource Group"
  value       = azurerm_resource_group.aca.name
}

output "resource_group_id" {
  description = "The ID of the Resource Group"
  value       = data.azurerm_resource_group.aca.id
}

# ============================
# Key Vault
# ============================

output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.devops.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.devops.vault_uri
}

output "key_vault_secrets_created" {
  description = "List of secret names created in Key Vault"
  value = [
    azurerm_key_vault_secret.postgresql_host.name,
    azurerm_key_vault_secret.postgresql_username.name,
    azurerm_key_vault_secret.postgresql_password.name,
    azurerm_key_vault_secret.app_secret_key.name
  ]
}

# ============================
# Metadata
# ============================

output "environment" {
  description = "Environment name for this deployment"
  value       = var.environment
}

output "location" {
  description = "Azure region used for this deployment"
  value       = var.location
}

# ============================
# Helper
# ============================

output "aca_connection_command" {
  description = "Azure CLI command to get ACA logs"
  value       = "az containerapp logs show --name fastapi-${var.environment} --resource-group ${azurerm_resource_group.aca.name} --follow"
}

output "aca_app_fqdn" {
  description = "FQDN of the Container App"
  value       = azurerm_container_app.fastapi.ingress[0].fqdn
}

output "deployment_complete" {
  description = "Indicates deployment is complete"
  value       = true
}
