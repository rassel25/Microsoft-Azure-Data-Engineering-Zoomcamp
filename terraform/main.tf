locals {
  resouce_group_name = "${var.prefix}-rg"
  cosmosdb_name = "${var.prefix}-nosql"
  data_factory_name = "${var.prefix}-adf"
  storage_account_name = "${var.prefix}sa"
  storage_data_lake_name = "${var.prefix}-adls"
  synapse_workspace_name = "${var.prefix}-asw"
  databricks_workspace_name = "${var.prefix}-adw"
  sql_pool_name = "${var.prefix}sqlpool"
  spark_pool_name = "${var.prefix}sparkp"
  # mssql_server_name = "${var.prefix}-server"
  # mssql_database_name = "${var.prefix}-db"
  admin_password = try(random_password.admin_password[0].result, var.admin_password)
}

resource "azurerm_resource_group" "dtcdezc" {
  name     = local.resouce_group_name
  location = var.location
}

resource "random_password" "admin_password" {
  count       = var.admin_password == null ? 1 : 0
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                      = local.cosmosdb_name
  location                  = azurerm_resource_group.dtcdezc.location
  resource_group_name       = azurerm_resource_group.dtcdezc.name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = false
  enable_free_tier          = true
  geo_location {
    location          = azurerm_resource_group.dtcdezc.location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  depends_on = [
    azurerm_resource_group.dtcdezc
  ]
}

resource "azurerm_data_factory" "adf" {
  name                = local.data_factory_name
  resource_group_name = azurerm_resource_group.dtcdezc.name
  location            = azurerm_resource_group.dtcdezc.location
}

resource "azurerm_storage_account" "sa" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.dtcdezc.name
  location                 = azurerm_resource_group.dtcdezc.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "adls" {
  name               = local.storage_data_lake_name
  storage_account_id = azurerm_storage_account.sa.id
}

resource "azurerm_synapse_workspace" "asw" {
  name                                 = local.synapse_workspace_name
  resource_group_name                  = azurerm_resource_group.dtcdezc.name
  location                             = azurerm_resource_group.dtcdezc.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.adls.id
  sql_administrator_login              = var.db_admin_username
  sql_administrator_login_password     = local.admin_password

  identity {
    type = "SystemAssigned"
  }
}

# resource "azurerm_databricks_workspace" "adw" {
#   name                = local.databricks_workspace_name
#   resource_group_name = azurerm_resource_group.dtcdezc.name
#   location            = azurerm_resource_group.dtcdezc.location
#   sku                 = "standard"
# }

# resource "azurerm_mssql_server" "mssqlserver" {
#   name                         = local.mssql_server_name
#   resource_group_name          = azurerm_resource_group.dtcdezc.name
#   location                     = azurerm_resource_group.dtcdezc.location
#   version                      = "12.0"
#   administrator_login          = var.db_admin_username
#   administrator_login_password = local.admin_password
# }

# resource "azurerm_mssql_database" "db" {
#   name           = local.mssql_database_name
#   server_id      = azurerm_mssql_server.mssqlserver.id

#   lifecycle {
#     prevent_destroy = true
#   }
# }

resource "azurerm_synapse_sql_pool" "sqlpool" {
  name                 = local.sql_pool_name
  synapse_workspace_id = azurerm_synapse_workspace.asw.id
  sku_name             = "DW100c"
  create_mode          = "Default"
}

resource "azurerm_synapse_spark_pool" "sparkpool" {
  name                 = local.spark_pool_name
  synapse_workspace_id = azurerm_synapse_workspace.asw.id
  node_size_family     = "MemoryOptimized"
  node_size            = "Small"
  node_count           = 3
  auto_pause {
    delay_in_minutes = 12
  }
  spark_version = 3.3
}
