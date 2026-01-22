output "resource_group_name" {
  value = azurerm_resource_group.network.name
}

output "resource_group_id" {
  value = azurerm_resource_group.network.id
}

output "resource_group_location" {
  value = azurerm_resource_group.network.location
}

output "vnet_id" {
  value = azurerm_virtual_network.devops.id
}

output "vnet_name" {
  value = azurerm_virtual_network.devops.name
}

output "vnet_address_space" {
  value = azurerm_virtual_network.devops.address_space
}

output "vnet_location" {
  value = azurerm_virtual_network.devops.location
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "aks_subnet_name" {
  value = azurerm_subnet.aks.name
}

output "aks_subnet_address_prefixes" {
  value = azurerm_subnet.aks.address_prefixes
}

output "database_subnet_id" {
  value = azurerm_subnet.database.id
}

output "database_subnet_name" {
  value = azurerm_subnet.database.name
}

output "database_subnet_address_prefixes" {
  value = azurerm_subnet.database.address_prefixes
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}

output "bastion_subnet_name" {
  value = azurerm_subnet.bastion.name
}

output "bastion_subnet_address_prefixes" {
  value = azurerm_subnet.bastion.address_prefixes
}

output "all_subnet_ids" {
  value = {
    aks      = azurerm_subnet.aks.id
    database = azurerm_subnet.database.id
    bastion  = azurerm_subnet.bastion.id
  }
}

output "environment" {
  value = var.environment
}

output "location" {
  value = var.location
}

output "module_summary" {
  value = {
    resource_group = {
      name     = azurerm_resource_group.network.name
      id       = azurerm_resource_group.network.id
      location = azurerm_resource_group.network.location
    }
    virtual_network = {
      id            = azurerm_virtual_network.devops.id
      name          = azurerm_virtual_network.devops.name
      address_space = azurerm_virtual_network.devops.address_space
      location      = azurerm_virtual_network.devops.location
    }
    subnets = {
      aks = {
        id               = azurerm_subnet.aks.id
        name             = azurerm_subnet.aks.name
        address_prefixes = azurerm_subnet.aks.address_prefixes
      }
      database = {
        id               = azurerm_subnet.database.id
        name             = azurerm_subnet.database.name
        address_prefixes = azurerm_subnet.database.address_prefixes
      }
      bastion = {
        id               = azurerm_subnet.bastion.id
        name             = azurerm_subnet.bastion.name
        address_prefixes = azurerm_subnet.bastion.address_prefixes
      }
    }
  }
  sensitive = false
}

output "local_values" {
  description = "Local values computed for this module"
  value = {
    naming_prefix = local.naming_prefix
    vnet_name     = local.vnet_name
    subnet_names  = local.subnet_names
  }
  sensitive = false
}
