variable "subscription_id" {
  description = "Azure Subscription ID where resources will be created"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "eastus"

  validation {
    condition = contains([
      "eastus", "eastus2", "westus", "westus2",
      "centralus", "northcentralus", "southcentralus",
      "westeurope", "northeurope", "uksouth", "ukwest",
      "southeastasia", "eastasia", "australiaeast", "australiasoutheast",
      "brazilsouth", "canadacentral", "canadaeast", "japaneast", "japanwest"
    ], var.location)
    error_message = "Invalid Azure region specified. Please use a supported region."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "resource_group_name" {
  description = "Base name for the Resource Group that will host Terraform state"
  type        = string
  default     = "rg-terraform-state"
}

variable "storage_account_name" {
  description = "Base name for Storage Account (will be combined with environment and random suffix)"
  type        = string
  default     = "tfstatedevops"
}

variable "storage_container_name" {
  description = "Name of the blob container for Terraform state files"
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
