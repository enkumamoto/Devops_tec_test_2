output "acr_id" {
  description = "ACR ID"
  value       = azurerm_container_registry.devops.id
}

output "acr_name" {
  description = "ACR name"
  value       = azurerm_container_registry.devops.name
}

output "acr_login_server" {
  description = "ACR login server"
  value       = azurerm_container_registry.devops.login_server
}
