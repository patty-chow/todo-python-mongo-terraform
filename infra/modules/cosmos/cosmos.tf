terraform {
  required_providers {
    azurerm = {
      version = "~>3.97.1"
      source  = "hashicorp/azurerm"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~>1.2.24"
    }
  }
}
# ------------------------------------------------------------------------------------------------------
# Deploy documentdb account
# ------------------------------------------------------------------------------------------------------
resource "azurecaf_name" "db_acc_name" {
  name          = var.resource_token
  resource_type = "azurerm_documentdb_account"
  random_length = 0
  clean_input   = true
}

resource "azurerm_documentdb_account" "db" {
  name                            = azurecaf_name.db_acc_name.result
  location                        = var.location
  resource_group_name             = var.rg_name
  offer_type                      = "Standard"
  kind                            = "MongoDB"
  enable_automatic_failover       = false
  enable_multiple_write_locations = false
  mongo_server_version            = "4.2"
  tags                            = var.tags

  capabilities {
    name = "EnableServerless"
  }

  lifecycle {
    ignore_changes = [capabilities]
  }
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
    zone_redundant    = false
  }
}

# ------------------------------------------------------------------------------------------------------
# Deploy documentdb mongo db and collections
# ------------------------------------------------------------------------------------------------------
resource "azurerm_documentdb_mongo_database" "mongodb" {
  name                = "Todo"
  resource_group_name = azurerm_documentdb_account.db.resource_group_name
  account_name        = azurerm_documentdb_account.db.name
}

resource "azurerm_documentdb_mongo_collection" "list" {
  name                = "TodoList"
  resource_group_name = azurerm_documentdb_account.db.resource_group_name
  account_name        = azurerm_documentdb_account.db.name
  database_name       = azurerm_documentdb_mongo_database.mongodb.name
  shard_key           = "_id"


  index {
    keys   = ["_id"]
  }
}

resource "azurerm_documentdb_mongo_collection" "item" {
  name                = "TodoItem"
  resource_group_name = azurerm_documentdb_account.db.resource_group_name
  account_name        = azurerm_documentdb_account.db.name
  database_name       = azurerm_documentdb_mongo_database.mongodb.name
  shard_key           = "_id"

  index {
    keys   = ["_id"]
  }
}