variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name for bastion"
  type        = string
}

variable "vnet_id" {
  description = "VNet ID from network remote state"
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID da subnet para o bastion"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/.*/resourceGroups/.*/providers/Microsoft.Network/virtualNetworks/.*/subnets/.*", var.bastion_subnet_id)) || var.bastion_subnet_id == ""
    error_message = "O subnet ID deve ser um Azure Resource ID válido ou vazio."
  }
}

variable "aca_subnet_address_prefixes" {
  description = "CIDR for aca subnet"
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

variable "vm_name" {
  description = "Bastion VM name"
  type        = string
}

variable "vm_size" {
  description = "Bastion VM size"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "ssh_public_key_path" {
  description = "SSH public key path"
  type        = string
}

variable "generate_ssh_key" {
  description = "Generate SSH key automatically"
  type        = bool
}

variable "pgadmin_enabled" {
  description = "Enable pgAdmin container"
  type        = bool
}

variable "pgadmin_port" {
  description = "pgAdmin exposed port"
  type        = number
}

variable "pgadmin_default_email" {
  description = "pgAdmin admin email"
  type        = string
}

variable "pgadmin_default_password" {
  description = "pgAdmin admin password"
  type        = string
  sensitive   = true
}

variable "allowed_source_ips" {
  description = "Allowed source IPs for SSH"
  type        = list(string)
}

variable "enable_public_ip" {
  description = "Enable public IP for bastion"
  type        = bool
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string

  validation {
    condition = contains([
      "Standard_LRS",
      "StandardSSD_LRS",
      "Premium_LRS"
    ], var.os_disk_type)
    error_message = "Invalid OS disk type."
  }
}

variable "ssh_public_key_content" {
  description = "SSH public key content (alternative to file path)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "tf_backend_resource_group" {
  description = "Backend Resource Group"
  type        = string
}

variable "tf_backend_storage_account" {
  description = "Backend Storage Account"
  type        = string
}

variable "tf_backend_container" {
  description = "Backend Container"
  type        = string
}

variable "tf_backend_sas_token" {
  description = "SAS Token for backend"
  type        = string
  sensitive   = true
}
