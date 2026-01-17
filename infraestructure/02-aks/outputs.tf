output "aks_id" {
  value = azurerm_kubernetes_cluster.devops.id
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.devops.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.devops.kube_config_raw
  sensitive = true
}
