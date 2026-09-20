output "postgresql_server_names" {

  description = "PostgreSQL server names"

  value = {
    for k, v in azurerm_postgresql_flexible_server.postgresql :
    k => v.name
  }
}


output "postgresql_fqdns" {

  description = "PostgreSQL Fully Qualified Domain Names"

  value = {
    for k, v in azurerm_postgresql_flexible_server.postgresql :
    k => v.fqdn
  }
}


output "postgresql_database_names" {

  description = "PostgreSQL database names"

  value = {
    for k, v in var.postgresql_servers :
    k => v.database_name
  }
}


output "postgresql_admin_usernames" {

  description = "PostgreSQL administrator usernames"

  value = {
    for k, v in var.postgresql_servers :
    k => v.admin_username
  }

  sensitive = true
}