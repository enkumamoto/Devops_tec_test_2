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
  description = "The location/region of the AKS cluster"
  value       = azurerm_kubernetes_cluster.devops.location
}

output "aks_node_resource_group" {
  description = "The name of the Resource Group containing cluster node resources"
  value       = azurerm_kubernetes_cluster.devops.node_resource_group
}

output "aks_kubelet_identity_object_id" {
  description = "Object ID of the cluster's kubelet identity (for Key Vault access)"
  value       = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id
  sensitive   = false
}

output "aks_kube_config_raw" {
  description = "Raw Kubernetes config to connect to the cluster (sensitive)"
  value       = azurerm_kubernetes_cluster.devops.kube_config_raw
  sensitive   = true
}

output "aks_kube_config" {
  description = "Kubernetes configuration for connecting to the cluster (structured)"
  value = {
    host                   = azurerm_kubernetes_cluster.devops.kube_config[0].host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.devops.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.devops.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.devops.kube_config[0].cluster_ca_certificate)
  }
  sensitive = true
}

output "aks_kube_admin_config_raw" {
  description = "Raw Kubernetes admin config (if enabled)"
  value       = try(azurerm_kubernetes_cluster.devops.kube_admin_config_raw, null)
  sensitive   = true
}

output "key_vault_id" {
  description = "The ID of the Key Vault for secrets management"
  value       = azurerm_key_vault.devops.id
}

output "key_vault_name" {
  description = "The name of the Key Vault for secrets management"
  value       = azurerm_key_vault.devops.name
}

output "key_vault_uri" {
  description = "The URI of the Key Vault for secrets management"
  value       = azurerm_key_vault.devops.vault_uri
}

output "resource_group_name" {
  description = "The name of the Resource Group containing AKS resources"
  value       = azurerm_resource_group.aks.name
}

output "resource_group_id" {
  description = "The ID of the Resource Group containing AKS resources"
  value       = azurerm_resource_group.devops.id
}

output "aks_connection_command" {
  description = "Azure CLI command to get credentials for this cluster"
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.aks.name} --name ${azurerm_kubernetes_cluster.devops.name} --admin"
  sensitive   = false
}

output "environment" {
  description = "Environment name for this deployment"
  value       = var.environment
}

output "location" {
  description = "Azure region used for this deployment"
  value       = var.location
}

output "module_summary" {
  description = "Summary of all resources created by the AKS module"
  value = {
    cluster = {
      id       = azurerm_kubernetes_cluster.devops.id
      name     = azurerm_kubernetes_cluster.devops.name
      fqdn     = azurerm_kubernetes_cluster.devops.fqdn
      location = azurerm_kubernetes_cluster.devops.location
      version  = azurerm_kubernetes_cluster.devops.kubernetes_version
    }
    key_vault = {
      id   = azurerm_key_vault.devops.id
      name = azurerm_key_vault.devops.name
      uri  = azurerm_key_vault.devops.vault_uri
    }
    resource_group = {
      name = azurerm_resource_group.aks.name
      id   = azurerm_resource_group.devops.id
    }
    network = {
      subnet_id = var.aks_subnet_id
    }
  }
  sensitive = false
}
