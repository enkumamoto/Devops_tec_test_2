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

variable "project_name" {
  description = "Project name for naming resources"
  type        = string
  default     = "devops"
}

variable "snet-management_address_prefixes" {
  description = "CIDR for Management subnet"
  type        = list(string)
}

variable "snet_management" {
  description = "Name for Management subnet"
  type        = string
}
