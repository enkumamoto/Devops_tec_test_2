variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "tfstate_resource_group_name" {
  description = "Resource group for Terraform state"
  type        = string
}

variable "tfstate_storage_account_name" {
  description = "Storage account name for Terraform state (must be globally unique)"
  type        = string
}
