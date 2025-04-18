output "resource_group_name" {
  value = azurerm_resource_group.dtcdezc.name
}

# output "sql_server_name" {
#   value = azurerm_mssql_server.mssqlserver.name
# }

output "asw_name" {
  value = azurerm_synapse_workspace.asw.name
}

output "admin_password" {
  sensitive = true
  value     = local.admin_password
}