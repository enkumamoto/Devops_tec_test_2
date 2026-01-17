variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group for network resources"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for VNet"
  type        = string
}

variable "subnet_aks_cidr" {
  type = string
}

variable "subnet_db_cidr" {
  type = string
}

variable "subnet_bastion_cidr" {
  type = string
}
