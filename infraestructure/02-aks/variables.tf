
variable "subscription_id" {
  description = "Azure Subscription ID for AKS deployment"
  type        = string
  # Will come from GitHub Secrets: ARM_SUBSCRIPTION_ID
}

variable "location" {
  description = "Azure region where AKS will be deployed"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "hom", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, hom, staging, prod."
  }
}

# Resource Group configuration
variable "resource_group_name" {
  description = "Name of the Resource Group for AKS resources"
  type        = string
}

# Network integration (from 01-network module outputs)
variable "vnet_id" {
  description = "ID of the Virtual Network from network module"
  type        = string
}

variable "aks_subnet_id" {
  description = "ID of the AKS subnet from network module"
  type        = string
}

# AKS Cluster configuration
variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "aks-devops"
}

variable "dns_prefix" {
  description = "DNS prefix for AKS cluster"
  type        = string
  default     = "aks-devops"
}

variable "kubernetes_version" {
  description = "Kubernetes version for AKS cluster"
  type        = string
  default     = "1.27" # LTS version
}

# Node Pool configuration
variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_D2s_v3" # Good for dev/test
}

# Optional: System node pool configuration
variable "system_node_pool_name" {
  description = "Name of the system node pool"
  type        = string
  default     = "system"
}

variable "min_node_count" {
  description = "Minimum number of nodes for autoscaling"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes for autoscaling"
  type        = number
  default     = 3
}

# Tags
variable "tags" {
  description = "Additional tags for AKS resources"
  type        = map(string)
  default     = {}
}
