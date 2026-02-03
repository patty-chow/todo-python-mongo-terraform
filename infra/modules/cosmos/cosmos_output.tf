output "AZURE_DOCUMENTDB_CONNECTION_STRING" {
  value     = azurerm_documentdb_account.db.connection_strings[0]
  sensitive = true
}

output "AZURE_DOCUMENTDB_DATABASE_NAME" {
  value = azurerm_documentdb_mongo_database.mongodb.name
}