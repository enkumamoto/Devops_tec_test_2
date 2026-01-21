variable "subscription_id" {
  description = "Azure Subscription ID for database deployment"
  type        = string
}

variable "location" {
  description = "Azure region where database will be deployed"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, hom, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "hom", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, hom, staging, prod."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group for database resources"
  type        = string
}

# =========================
# Network (from 01-network)
# =========================
variable "vnet_id" {
  description = "ID of the Virtual Network from network module"
  type        = string
}

variable "database_subnet_id" {
  description = "ID of the delegated database subnet"
  type        = string
}

# =========================
# PostgreSQL Configuration
# =========================
variable "db_name" {
  description = "Base name for PostgreSQL Flexible Server"
  type        = string
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string

  validation {
    condition     = contains(["11", "12", "13", "14", "15", "16"], var.postgres_version)
    error_message = "PostgreSQL version must be one of: 11, 12, 13, 14, 15, 16."
  }
}

variable "sku_name" {
  description = "SKU name for PostgreSQL Flexible Server"
  type        = string
}

variable "storage_mb" {
  description = "Storage size in MB for PostgreSQL"
  type        = number
}

variable "backup_retention_days" {
  description = "Backup retention period in days"
  type        = number
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups"
  type        = bool
}

variable "maintenance_window" {
  description = "Maintenance window configuration"
  type = object({
    day_of_week  = number
    start_hour   = number
    start_minute = number
  })
}

variable "charset" {
  description = "Database charset"
  type        = string
}

variable "collation" {
  description = "Database collation"
  type        = string
}

variable "zone" {
  description = "Availability zone for the database server"
  type        = string
}

variable "high_availability_mode" {
  description = "High availability mode for PostgreSQL"
  type        = string

  validation {
    condition     = contains(["Disabled", "ZoneRedundant"], var.high_availability_mode)
    error_message = "High availability mode must be Disabled or ZoneRedundant."
  }
}

variable "tags" {
  description = "Additional tags for database resources"
  type        = map(string)
}
