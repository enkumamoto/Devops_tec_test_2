location            = "eastus"
environment         = "dev"
resource_group_name = "rg-database"

vnet_id            = "<SUBSTITUA_PELO_VNET_ID_DO_NETWORK_MODULE>"
database_subnet_id = "<SUBSTITUA_PELO_DATABASE_SUBNET_ID_DO_NETWORK_MODULE>"

db_name                      = "psql-devops"
postgres_version             = "15"
sku_name                     = "B_Standard_B1ms"
storage_mb                   = 32768
backup_retention_days        = 7
geo_redundant_backup_enabled = false

maintenance_window = {
  day_of_week  = 0
  start_hour   = 2
  start_minute = 0
}

charset   = "UTF8"
collation = "en_US.utf8"

zone                   = "1"
high_availability_mode = "Disabled"

tags = {
  Environment = "dev"
  Project     = "devops-technical-test"
  ManagedBy   = "Terraform"
  Owner       = "Platform"
}
