# Container App principal (substitui o AKS cluster)
resource "azurerm_container_app" "fastapi" {
  name                         = "fastapi-${var.environment}"
  container_app_environment_id = azurerm_container_app_environment.devops.id
  resource_group_name          = azurerm_resource_group.aca.name
  revision_mode                = "Single" # Single = sempre latest revision

  secret {
    name  = "postgresql-host"
    value = azurerm_key_vault_secret.postgresql_host.value
  }

  secret {
    name  = "postgresql-username"
    value = azurerm_key_vault_secret.postgresql_username.value
  }

  secret {
    name  = "postgresql-password"
    value = azurerm_key_vault_secret.postgresql_password.value
  }

  template {
    container {
      name   = "fastapi-app"
      image  = "${var.acr_login_server}/fastapi-app:latest"
      cpu    = 0.5   # 0.5 vCPU (meio core)
      memory = "1Gi" # 1GB RAM

      # Variáveis de ambiente
      env {
        name  = "APP_ENVIRONMENT"
        value = var.environment
      }

      env {
        name  = "APP_PORT"
        value = "8000"
      }

      # Secrets do Key Vault
      dynamic "env" {
        for_each = var.key_vault_secrets
        content {
          name        = env.value.name
          secret_name = env.value.secret_name
        }
      }
    }

    # Escalabilidade
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas
  }

  # Ingress configuration (expor via HTTP)
  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8000

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  depends_on = [azurerm_resource_group.aca]

  tags = var.tags
}

resource "azurerm_container_app" "worker" {
  count = var.enable_worker ? 1 : 0

  name                         = "worker-${var.environment}"
  container_app_environment_id = azurerm_container_app_environment.devops.id
  resource_group_name          = azurerm_resource_group.aca.name
  revision_mode                = "Single"

  template {
    container {
      name   = "worker"
      image  = "${var.acr_login_server}/worker:latest"
      cpu    = 0.25
      memory = "0.5Gi"

    }

    min_replicas = var.worker_min_replicas
    max_replicas = var.worker_max_replicas
  }

  #   ingress {
  #     external_enabled = false
  #   }

  tags = var.tags
}
