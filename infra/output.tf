output "AZURE_DOCUMENTDB_CONNECTION_STRING_KEY" {
  value = local.documentdb_connection_string_key
}

output "AZURE_DOCUMENTDB_DATABASE_NAME" {
  value = module.documentdb.AZURE_DOCUMENTDB_DATABASE_NAME
}

output "AZURE_KEY_VAULT_ENDPOINT" {
  value     = module.keyvault.AZURE_KEY_VAULT_ENDPOINT
  sensitive = true
}

output "REACT_APP_WEB_BASE_URL" {
  value = module.web.URI
}

output "API_BASE_URL" {
  value = var.useAPIM ? module.apimApi[0].SERVICE_API_URI : module.api.URI
}

output "AZURE_LOCATION" {
  value = var.location
}

output "APPLICATIONINSIGHTS_CONNECTION_STRING" {
  value     = module.applicationinsights.APPLICATIONINSIGHTS_CONNECTION_STRING
  sensitive = true
}

output "USE_APIM" {
  value = var.useAPIM
}

output "SERVICE_API_ENDPOINTS" {
  value = var.useAPIM ? [ module.apimApi[0].SERVICE_API_URI, module.api.URI ] : [] 
}
