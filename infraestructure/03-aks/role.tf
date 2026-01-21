# resource "azurerm_role_assignment" "aks_keyvault_secrets_user" {
#   scope                = azurerm_key_vault.devops.id
#   role_definition_name = "Key Vault Secrets User"

#   principal_id = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id
# }
resource "azurerm_role_assignment" "aks_acr" {
  principal_id = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id

  role_definition_name = "AcrPull"
  scope                = data.terraform_remote_state.acr.outputs.acr_id
  count                = data.terraform_remote_state.acr.outputs.acr_id != "" ? 1 : 0
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  count = var.enable_acr_rbac && data.terraform_remote_state.acr.outputs.acr_id != "" ? 1 : 0

  scope                = data.terraform_remote_state.acr.outputs.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id
}
