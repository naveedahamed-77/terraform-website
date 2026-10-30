# azure/outputs.tf -- what the blue cloud build announces when done.

output "website_url" {
  description = "The public URL of the live website (anywhere on Earth)."
  value       = azurerm_storage_account.site.primary_web_endpoint
}

output "resource_group_name" {
  value = azurerm_resource_group.site.name
}

output "location" {
  value = var.location
}
