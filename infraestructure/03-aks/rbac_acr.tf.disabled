resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = data.terraform_remote_state.acr.outputs.acr_id
  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id
}
