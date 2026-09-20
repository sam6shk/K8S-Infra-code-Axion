variable "infra_config" {
  description = "Complete infrastructure configuration for Dev environment"
  type = object({
    resource_groups = map(object({
      location = string
      tags     = optional(map(string), {})
    }))
    container_registries = map(object({
      rg_key        = string
      sku           = optional(string, "Standard")
      admin_enabled = optional(bool, false)
      tags          = optional(map(string), {})
    }))
    kubernetes_clusters = map(object({
      rg_key     = string
      dns_prefix = string
      default_node_pool = object({
        name       = string
        node_count = optional(number, 1)
        vm_size    = optional(string, "Standard_DS2_v2")
      })
      tags = optional(map(string), {})
    }))
    postgresql_servers = optional(map(object({
      rg_key             = string
      server_name        = string
      postgresql_version = optional(string, "16")
      sku_name           = optional(string, "B_Standard_B1ms")
      storage_mb         = optional(number, 32768)
      admin_username     = string
      admin_password     = string
      database_name      = optional(string, "postgres")
      tags               = optional(map(string), {})
    })), {})
  })
}
