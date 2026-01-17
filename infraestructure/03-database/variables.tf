variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Database resource group"
}

variable "db_name" {
  type        = string
  description = "PostgreSQL server name"
}

variable "postgres_version" {
  type    = string
  default = "14"
}

variable "sku_name" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "storage_mb" {
  type    = number
  default = 32768
}

variable "backup_retention_days" {
  type    = number
  default = 7
}

variable "administrator_login" {
  type      = string
  sensitive = true
}

variable "administrator_password" {
  type      = string
  sensitive = true
}
