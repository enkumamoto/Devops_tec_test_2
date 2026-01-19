variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for network resources"
  type        = string
}

variable "vnet_address_space" {
  description = "CIDR block for VNet"
  type        = list(string)
}

variable "aks_subnet_address_prefixes" {
  description = "CIDR for AKS subnet"
  type        = list(string)
}

variable "database_subnet_address_prefixes" {
  description = "CIDR for Database subnet"
  type        = list(string)
}

variable "bastion_subnet_address_prefixes" {
  description = "CIDR for Bastion subnet"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

variable "vnet_name" {
  description = "Name for VNet"
  type        = string
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

variable "project_name" {
  description = "Project name for naming resources"
  type        = string
  default     = "devops"
}
