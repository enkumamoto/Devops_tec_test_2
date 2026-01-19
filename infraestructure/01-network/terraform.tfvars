# Resource Group Configuration
resource_group_name = "network"

# Virtual Network Configuration
vnet_name          = "vnet-prod"
vnet_address_space = ["10.0.0.0/16"]

# Subnet Configuration (mais espaços para produção)
aks_subnet_address_prefixes      = ["10.0.1.0/24", "10.0.11.0/24"] # Multi-AZ
database_subnet_address_prefixes = ["10.0.2.0/24", "10.0.12.0/24"] # HA
bastion_subnet_address_prefixes  = ["10.0.3.0/24"]

# Optional Variables
location    = "eastus"
environment = "dev"

# Tags Configuration
tags = {
  Environment = "production"
  Project     = "devops-technical-test"
  ManagedBy   = "Terraform"
  Owner       = "Platform Team"
  CostCenter  = "PROD-001"
  Repository  = "https://github.com/your-org/devops-technical-test"
  Criticality = "high"
  Compliance  = "pci-dss"
}
