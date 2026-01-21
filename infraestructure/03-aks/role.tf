# resource "azurerm_role_assignment" "aks_keyvault_secrets_user" {
#   scope                = azurerm_key_vault.devops.id
#   role_definition_name = "Key Vault Secrets User"

#   principal_id = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id
# }
resource "azurerm_role_assignment" "aks_acr" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}
