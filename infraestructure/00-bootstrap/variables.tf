variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod"
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "storage_account_prefix" {
  description = "Prefix for storage account name (will be combined with environment and random suffix)"
  type        = string
  default     = "tfstate"
}

variable "storage_container_name" {
  description = "Name of the blob container for Terraform state"
  type        = string
  default     = "tfstate"
}

variable "resource_group_name" {
  description = "Name of the resource group for Terraform state backend"
  type        = string
  default     = "rg-terraform-state"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project    = "DevOps-Test"
    ManagedBy  = "Terraform"
    Repository = "devops-technical-test"
  }
}
