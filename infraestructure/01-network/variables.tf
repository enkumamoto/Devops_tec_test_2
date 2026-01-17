variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for network resources"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for VNet"
  type        = string
}

variable "subnet_aks_cidr" {
  description = "CIDR for AKS subnet"
  type        = string
}

variable "subnet_db_cidr" {
  description = "CIDR for Database subnet"
  type        = string
}

variable "subnet_bastion_cidr" {
  description = "CIDR for Bastion subnet"
  type        = string
}
