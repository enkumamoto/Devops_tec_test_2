# ============================
# Global / Environment
# ============================

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region where ACA will be deployed"
  type        = string
}

variable "tags" {
  description = "Tags applied to ACA resources"
  type        = map(string)
}

# ============================
# Resource Group
# ============================

variable "resource_group_name" {
  description = "Name of the Resource Group for ACA"
  type        = string
  default     = "rg-aca-dev"
}

# ============================
# ACA Environment
# ============================

variable "aca_subnet_id" {
  description = "ID da subnet para o ACA Environment"
  type        = string
  default     = ""
}

# ============================
# Container App Configuration
# ============================

variable "acr_login_server" {
  description = "ACR login server (ex: myacr.azurecr.io)"
  type        = string
  default     = ""
}

variable "min_replicas" {
  description = "Minimum number of replicas for the container app"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Maximum number of replicas for the container app"
  type        = number
  default     = 5
}

variable "enable_worker" {
  description = "Enable worker container app"
  type        = bool
  default     = false
}

variable "worker_min_replicas" {
  description = "Minimum replicas for worker"
  type        = number
  default     = 0
}

variable "worker_max_replicas" {
  description = "Maximum replicas for worker"
  type        = number
  default     = 3
}

# ============================
# Key Vault Configuration
# ============================

variable "key_vault_name" {
  description = "Nome do Azure Key Vault (deixar vazio para auto-nome)"
  type        = string
  default     = ""
}

variable "key_vault_sku" {
  description = "SKU do Key Vault (standard ou premium)"
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Dias de retenção para soft delete"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Habilitar purge protection"
  type        = bool
  default     = false
}

# ============================
# Database Secrets
# ============================

variable "postgresql_host" {
  description = "PostgreSQL host"
  type        = string
  default     = "postgresql-server.devops.internal"
}

variable "postgresql_username" {
  description = "PostgreSQL username"
  type        = string
  default     = "postgres"
}

# ============================
# Key Vault Secrets for ACA
# ============================

variable "key_vault_secrets" {
  description = "List of Key Vault secrets to inject as environment variables"
  type = list(object({
    name        = string
    secret_name = string
  }))
  default = [
    {
      name        = "POSTGRESQL_HOST"
      secret_name = "postgresql-host"
    },
    {
      name        = "POSTGRESQL_USERNAME"
      secret_name = "postgresql-username"
    },
    {
      name        = "POSTGRESQL_PASSWORD"
      secret_name = "postgresql-password"
    },
    {
      name        = "APP_SECRET_KEY"
      secret_name = "app-secret-key"
    }
  ]
}

# =========================
# Terraform Remote State (Backend)
# =========================

variable "tf_backend_resource_group" {
  description = "Resource Group onde está o tfstate"
  type        = string
}

variable "tf_backend_storage_account" {
  description = "Storage Account do tfstate"
  type        = string
}

variable "tf_backend_container" {
  description = "Container do tfstate"
  type        = string
}

variable "tf_backend_sas_token" {
  description = "SAS Token para acesso ao tfstate"
  type        = string
  sensitive   = true
}
