variable "subscription_id" {
  description = "Azure Subscription ID for database deployment"
  type        = string
}

variable "location" {
  description = "Azure region where database will be deployed"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "hom", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, hom, staging, prod."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group for database resources"
  type        = string
}

variable "vnet_id" {
  description = "ID of the Virtual Network from network module"
  type        = string
}

variable "database_subnet_id" {
  description = "ID of the database subnet from network module"
  type        = string
}

variable "db_name" {
  description = "Base name for PostgreSQL Flexible Server (will be made unique)"
  type        = string
  default     = "psql-devops"
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "14"
  validation {
    condition     = contains(["11", "12", "13", "14", "15", "16"], var.postgres_version)
    error_message = "PostgreSQL version must be one of: 11, 12, 13, 14, 15, 16."
  }
}

variable "sku_name" {
  description = "SKU name for PostgreSQL Flexible Server"
  type        = string
  default     = "Standard_D2s_v3"
  validation {
    condition     = can(regex("^(B_|GP_|MO_)[A-Za-z0-9_]+$", var.sku_name))
    error_message = "SKU name must follow Azure naming pattern (B_, GP_, MO_ prefixes)."
  }
}

variable "storage_mb" {
  description = "Storage size in MB for PostgreSQL"
  type        = number
  default     = 32768
  validation {
    condition     = var.storage_mb >= 32768 && var.storage_mb <= 16777216
    error_message = "Storage must be between 32768 MB (32GB) and 16777216 MB (16TB)."
  }
}

variable "backup_retention_days" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 35
    error_message = "Backup retention must be between 7 and 35 days."
  }
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "Maintenance window configuration"
  type = object({
    day_of_week  = number
    start_hour   = number
    start_minute = number
  })
  default = {
    day_of_week  = 0
    start_hour   = 2
    start_minute = 0
  }
}

variable "charset" {
  description = "Database charset"
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = "Database collation"
  type        = string
  default     = "en_US.utf8"
}

variable "tags" {
  description = "Additional tags for database resources"
  type        = map(string)
  default     = {}
}

variable "zone" {
  description = "Availability zone for the database server"
  type        = string
  default     = "1"
  validation {
    condition     = contains(["1", "2", "3", ""], var.zone)
    error_message = "Zone must be 1, 2, 3, or empty for no zone preference."
  }
}

variable "high_availability_mode" {
  description = "High availability mode for PostgreSQL"
  type        = string
  default     = "Disabled"
  validation {
    condition     = contains(["Disabled", "ZoneRedundant"], var.high_availability_mode)
    error_message = "High availability mode must be Disabled or ZoneRedundant."
  }
}

variable "vnet_id" {}

variable "database_subnet_id" {}
