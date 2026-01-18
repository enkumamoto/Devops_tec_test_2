output "resource_group_name" {
  description = "Name of the Resource Group created for Terraform state backend"
  value       = azurerm_resource_group.devops.name
}

output "resource_group_id" {
  description = "ID of the Resource Group created for Terraform state backend"
  value       = azurerm_resource_group.devops.id
}

output "resource_group_location" {
  description = "Location of the Resource Group created for Terraform state backend"
  value       = azurerm_resource_group.devops.location
}

output "storage_account_name" {
  description = "Name of the Storage Account created for Terraform state backend"
  value       = azurerm_storage_account.devops.name
}

output "storage_account_id" {
  description = "ID of the Storage Account created for Terraform state backend"
  value       = azurerm_storage_account.devops.id
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint URL for the Storage Account"
  value       = azurerm_storage_account.devops.primary_blob_endpoint
}

output "storage_container_name" {
  description = "Name of the blob container for Terraform state files"
  value       = azurerm_storage_container.devops.name
}

output "storage_account_primary_access_key" {
  description = "Primary access key for the Storage Account (sensitive - use with caution)"
  value       = azurerm_storage_account_primary_access_key.devops.value
  sensitive   = true # Mark as sensitive to hide in console output
}

output "environment" {
  description = "Environment name used for this deployment"
  value       = var.environment
}

output "location" {
  description = "Azure region used for this deployment"
  value       = var.location
}

output "backend_config" {
  description = "Complete backend configuration for Terraform modules (as map)"
  value = {
    resource_group_name  = azurerm_resource_group.devops.name
    storage_account_name = azurerm_storage_account.devops.name
    container_name       = azurerm_storage_container.devops.name
    key_prefix           = "${var.environment}/"
  }
}

output "terraform_backend_config_hcl" {
  description = "Terraform backend configuration in HCL format (for automation)"
  value       = <<-EOT
    backend "azurerm" {
      resource_group_name  = "${azurerm_resource_group.devops.name}"
      storage_account_name = "${azurerm_storage_account.devops.name}"
      container_name       = "${azurerm_storage_container.devops.name}"
      key                  = "__MODULE_NAME__.tfstate"
    }
  EOT
}
