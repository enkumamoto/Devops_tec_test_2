# ============================
# Global / Environment
# ============================

variable "environment" {
  description = "Environment name (dev, hom, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "hom", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, hom, staging, prod."
  }
}

variable "location" {
  description = "Azure region where AKS will be deployed"
  type        = string
}

variable "tags" {
  description = "Tags applied to AKS resources"
  type        = map(string)
}

# ============================
# Resource Group
# ============================

variable "resource_group_name" {
  description = "Name of the Resource Group for AKS"
  type        = string
}

# ============================
# AKS Cluster
# ============================

variable "aks_name" {
  description = "Base name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
}

# ============================
# Node Pool
# ============================

variable "system_node_pool_name" {
  description = "Name of the system node pool"
  type        = string
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
}

variable "min_node_count" {
  description = "Minimum number of nodes for autoscaling"
  type        = number
}

variable "max_node_count" {
  description = "Maximum number of nodes for autoscaling"
  type        = number
}

# ============================
# Maintenance Window
# ============================

variable "maintenance_day" {
  description = "Allowed day for AKS maintenance"
  type        = string
}

variable "maintenance_hours" {
  description = "Allowed hours for AKS maintenance"
  type        = list(number)
}


variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = ""
}

variable "azure_client_id" {
  description = "Azure Service Principal Client ID"
  type        = string
  default     = ""
}

variable "azure_client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = ""
}

variable "aks_subnet_id" {
  description = "ID da subnet para o AKS"
  type        = string
  default     = "" # Pode ficar vazio para teste
}

variable "key_vault_name" {
  description = "Nome do Azure Key Vault"
  type        = string
  default     = ""
}

variable "key_vault_sku" {
  description = "SKU do Key Vault (standard ou premium)"
  type        = string
  default     = "standard"
}

variable "enabled_for_disk_encryption" {
  description = "Habilitar para disk encryption"
  type        = bool
  default     = false
}

variable "enabled_for_deployment" {
  description = "Habilitar para deployment"
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Habilitar para template deployment"
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Dias de retenção para soft delete"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Habilitar purge protection"
  type        = bool
  default     = false
}

variable "enable_acr_rbac" {
  description = "Habilitar RBAC para ACR"
  type        = bool
  default     = false
}

variable "acr_id" {
  description = "ID do ACR (necessário se enable_acr_rbac = true)"
  type        = string
  default     = ""
}

# Em rbac_acr.tf, modificar:
resource "azurerm_role_assignment" "aks_acr_pull" {
  count = var.enable_acr_rbac && var.acr_id != "" ? 1 : 0

  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.devops.kubelet_identity[0].object_id
}
