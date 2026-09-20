module "resource_groups" {

  source = "../../modules/resource_group"

  resource_groups = var.infra_config.resource_groups

}


module "acr" {

  source = "../../modules/acr"

  container_registries = {

    for k, v in var.infra_config.container_registries : k => {

      resource_group_name = module.resource_groups.resource_group_names[v.rg_key]

      location = var.infra_config.resource_groups[v.rg_key].location

      sku = v.sku

      admin_enabled = v.admin_enabled

      tags = v.tags

    }

  }

}


module "aks" {

  source = "../../modules/aks"

  kubernetes_clusters = {

    for k, v in var.infra_config.kubernetes_clusters : k => {

      resource_group_name = module.resource_groups.resource_group_names[v.rg_key]

      location = var.infra_config.resource_groups[v.rg_key].location

      dns_prefix = v.dns_prefix

      default_node_pool = v.default_node_pool

      tags = v.tags

    }

  }

}


# ============================================================
# PostgreSQL Flexible Server
# ============================================================

module "postgresql" {

  source = "../../modules/postgresql"

  postgresql_servers = {

    for k, v in var.infra_config.postgresql_servers : k => {

      resource_group_name = module.resource_groups.resource_group_names[v.rg_key]

      location = var.infra_config.resource_groups[v.rg_key].location

      server_name = v.server_name

      postgresql_version = v.postgresql_version

      sku_name = v.sku_name

      storage_mb = v.storage_mb

      admin_username = v.admin_username

      admin_password = v.admin_password

      database_name = v.database_name

      tags = v.tags

    }

  }

}

# module "resource_groups" {
#   source          = "../../modules/resource_group"
#   resource_groups = var.infra_config.resource_groups
# }

# module "acr" {
#   source = "../../modules/acr"
#   container_registries = {
#     for k, v in var.infra_config.container_registries : k => {
#       resource_group_name = module.resource_groups.resource_group_names[v.rg_key]
#       location            = var.infra_config.resource_groups[v.rg_key].location
#       sku                 = v.sku
#       admin_enabled       = v.admin_enabled
#       tags                = v.tags
#     }
#   }
# }

# module "aks" {
#   source = "../../modules/aks"
#   kubernetes_clusters = {
#     for k, v in var.infra_config.kubernetes_clusters : k => {
#       resource_group_name = module.resource_groups.resource_group_names[v.rg_key]
#       location            = var.infra_config.resource_groups[v.rg_key].location
#       dns_prefix          = v.dns_prefix
#       default_node_pool   = v.default_node_pool
#       tags                = v.tags
#     }
#   }
# }
