environment = "dev"
location    = "canadacentral"

tags = {
  Environment = "dev"
  Project     = "devops-test"
  ManagedBy   = "Terraform"
}

resource_group_name = "rg-aca-dev" # ⬅️ MUDOU DE rg-aks-dev

# ACA Configuration
aca_subnet_id    = ""
acr_login_server = "myacr.azurecr.io" # Atualize com seu ACR

min_replicas = 1
max_replicas = 3

# Key Vault
key_vault_name = ""

soft_delete_retention_days = 7
purge_protection_enabled   = false

# Database
postgresql_host     = "postgresql-server.devops.internal"
postgresql_username = "postgres"
