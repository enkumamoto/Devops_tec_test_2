resource "azurerm_kubernetes_cluster" "devops" {
  name                = "${var.aks_name}-${var.environment}"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${var.dns_prefix}-${var.environment}"
  kubernetes_version  = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name    = var.system_node_pool_name
    vm_size = var.node_vm_size
    type    = "VirtualMachineScaleSets"

    enable_auto_scaling = true
    min_count           = var.min_node_count
    max_count           = var.max_node_count

    vnet_subnet_id = var.aks_subnet_id != "" ? var.aks_subnet_id : null

    node_labels = {
      pool        = "system"
      environment = var.environment
    }
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  private_cluster_enabled           = true
  role_based_access_control_enabled = true

  tags = var.tags

  lifecycle {
    ignore_changes = [
      kubernetes_version
    ]
  }
}
