environment = "dev"
location    = "canadacentral"

tags = {
  Environment = "dev"
  Project     = "devops-test"
  ManagedBy   = "Terraform"
}

resource_group_name = "aks"

aks_name   = "aks-devops-dev"
dns_prefix = "aks-devops"

kubernetes_version = "1.28.5"

system_node_pool_name = "system"

node_vm_size = "Standard_DS2_v2"

min_node_count = 1
max_node_count = 3

aks_subnet_id = ""

key_vault_name = ""

enabled_for_disk_encryption     = false
enabled_for_deployment          = false
enabled_for_template_deployment = false
purge_protection_enabled        = false

enable_acr_rbac = false
acr_id          = ""
