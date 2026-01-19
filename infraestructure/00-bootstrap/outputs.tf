output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.devops.name
}

output "storage_account_name" {
  description = "Name of the created storage account"
  value       = azurerm_storage_account.devops.name
  sensitive   = false
}

output "storage_container_name" {
  description = "Name of the blob container"
  value       = azurerm_storage_container.devops.name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.devops.id
}

# ✅ Use data source para obter a chave
output "primary_access_key" {
  description = "Primary access key for the storage account"
  value       = data.azurerm_storage_account.devops.primary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "Primary connection string for the storage account"
  value       = data.azurerm_storage_account.devops.primary_connection_string
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key for the storage account"
  value       = data.azurerm_storage_account.devops.secondary_access_key
  sensitive   = true
}

output "secondary_connection_string" {
  description = "Secondary connection string for the storage account"
  value       = data.azurerm_storage_account.devops.secondary_connection_string
  sensitive   = true
}

output "location" {
  description = "Azure region where resources were created"
  value       = azurerm_resource_group.devops.location
}

output "tags" {
  description = "Tags applied to all resources"
  value = merge(var.tags, {
    Environment = var.environment
    Module      = "bootstrap"
  })
}
