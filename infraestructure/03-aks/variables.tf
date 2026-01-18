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
