variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "AKS resource group name"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "dns_prefix" {
  description = "AKS DNS prefix"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
}

variable "environment" {
  description = "Dev ou Hom"
  type        = string
}

variable "db_user" {
  description = "Database User"
  type        = string
}

variable "db_host" {
  description = "Database Host"
  type        = string
}
