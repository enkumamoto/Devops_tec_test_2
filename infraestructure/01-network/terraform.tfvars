# Resource Group Configuration
resource_group_name = "network"

# Virtual Network Configuration
vnet_name          = "vnet"
vnet_address_space = ["10.0.0.0/16"]

# Subnet Configuration (mais espaços para produção)
aks_subnet_address_prefixes      = ["10.0.1.0/24"]
database_subnet_address_prefixes = ["10.0.2.0/24"]
bastion_subnet_address_prefixes  = ["10.0.3.0/24"]

# Optional Variables
location    = "canadacentral"
environment = "dev"

# Tags Configuration
tags = {
  Project     = "devops-technical-test"
  ManagedBy   = "Terraform"
  Owner       = "Platform Team"
  CostCenter  = "001"
  Criticality = "high"
  Compliance  = "pci-dss"
}
