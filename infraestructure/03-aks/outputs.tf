# ============================
# AKS - Core Outputs
# ============================

output "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.devops.id
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.devops.name
}

output "aks_cluster_fqdn" {
  description = "The FQDN of the AKS cluster API server"
  value       = azurerm_kubernetes_cluster.devops.fqdn
}

output "aks_cluster_location" {
  description = "The Azure region where the AKS cluster is deployed"
  value       = azurerm_kubernetes_cluster.devops.location
}

output "aks_node_resource_group" {
  description = "The Resource Group that contains the AKS node pool resources"
  value       = azurerm_kubernetes_cluster.devops.node_resource_group
}

# ============================
# AKS - Identity (RBAC / ACR / KV)
# ============================

output "aks_kubelet_identity_object_id" {
  description = "Object ID of the AKS kubelet managed identity"
  value       = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id
}

output "aks_cluster_identity_principal_id" {
  description = "Principal ID of the AKS system-assigned managed identity"
  value       = azurerm_kubernetes_cluster.devops.identity[0].principal_id
}

output "acr_id" {
  description = "The ID of the Azure Container Registry"
  value       = azurerm_container_registry.this.id
}

output "postgresql_password_secret_id" {
  value     = azurerm_key_vault_secret.postgresql_password.id
  sensitive = false
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
# Resource Group
# ============================

output "resource_group_name" {
  description = "The name of the Resource Group containing AKS resources"
  value       = azurerm_resource_group.aks.name
}

output "resource_group_id" {
  description = "The ID of the Resource Group containing AKS resources"
  value       = azurerm_resource_group.aks.id
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

output "aks_connection_command" {
  description = "Azure CLI command to get credentials for this AKS cluster"
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.aks.name} --name ${azurerm_kubernetes_cluster.devops.name}"
}
