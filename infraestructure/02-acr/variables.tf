variable "environment" {
  description = "Environment name (dev, hml, prod)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where ACR will be deployed"
  type        = string
}

variable "acr_sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  type        = string
}

variable "admin_enabled" {
  description = "Enable admin user for ACR"
  type        = bool
}
