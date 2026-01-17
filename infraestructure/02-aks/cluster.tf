resource "azurerm_kubernetes_cluster" "devops" {
  name                = var.aks_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name           = "system"
    node_count     = var.node_count
    vm_size        = var.node_vm_size
    vnet_subnet_id = data.terraform_remote_state.network.outputs.aks_subnet_id
    type           = "VirtualMachineScaleSets"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  private_cluster_enabled = true

  role_based_access_control_enabled = true
}
