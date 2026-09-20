variable "postgresql_servers" {

  description = "PostgreSQL Flexible Server configuration"

  type = map(object({

    resource_group_name = string
    location            = string

    server_name = string

    postgresql_version = string
    sku_name           = string
    storage_mb         = number

    admin_username = string
    admin_password = string

    database_name = string

    tags = map(string)

  }))

}