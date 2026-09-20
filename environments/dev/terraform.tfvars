infra_config = {
  resource_groups = {
    "rg-micro-dev" = {
      location = "East US"
      tags     = { Environment = "Dev", ManagedBy = "Terraform" }
    }
  }
  container_registries = {
    "acrmicrodev786" = {
      rg_key = "rg-micro-dev"
      sku    = "Basic"
    }
  }
  kubernetes_clusters = {
    "aks-micro-dev" = {
      rg_key     = "rg-micro-dev"
      dns_prefix = "aksmicrodev"
      default_node_pool = {
        name       = "default"
        node_count = 2
        vm_size    = "Standard_B2s"
      }
    }
  }
  postgresql_servers = {

    postgres_dev = {

      rg_key = "rg-micro-dev"

      server_name = "axion-postgres-server"

      postgresql_version = "16"

      sku_name = "B_Standard_B1ms"

      storage_mb = 32768

      admin_username = "devopsadmin"

      admin_password = "P@ssw01rd123"

      database_name = "postgres"

      tags = {
        Environment = "Dev"
        ManagedBy   = "Terraform"
      }
    }
  }
}

