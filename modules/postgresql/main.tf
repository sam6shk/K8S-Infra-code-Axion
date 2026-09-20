resource "azurerm_postgresql_flexible_server" "postgresql" {

  for_each = var.postgresql_servers

  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  version    = each.value.postgresql_version
  sku_name   = each.value.sku_name
  storage_mb = each.value.storage_mb

  administrator_login    = each.value.admin_username
  administrator_password = each.value.admin_password

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled = true

  tags = each.value.tags
}


# Allow Azure services to access PostgreSQL
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_services" {

  for_each = var.postgresql_servers

  name      = "AllowAzureServices"
  server_id = azurerm_postgresql_flexible_server.postgresql[each.key].id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}