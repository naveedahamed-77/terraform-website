# azure/main.tf -- the cloud stack (blue): one static website on Azure Storage.
#
#   1. Resource group    = the folder that owns everything we create (destroy
#                          = delete folder = delete all, safely).
#   2. Storage account   = the house; its "$web" container is Azure static
#                          website hosting (public, URL-served).
#   3. Blob "index.html" = the page, rendered straight from the shared
#                          Terraform template (same as local & aws stacks).
#
# COST: pennies/month; destroy = zero.

resource "azurerm_resource_group" "site" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "site" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.site.name
  location                 = azurerm_resource_group.site.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.site.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  content                = templatefile("${path.module}/../index.html.tpl", {
    title      = var.site_title
    host_label = "Azure Storage (cloud, ${var.location})"
    engine     = "azure-static-website"
  })
  depends_on = [azurerm_storage_account.site]
}
