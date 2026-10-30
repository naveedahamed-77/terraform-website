# azure/versions.tf -- pins the Azure provider (the cloud spoke, blue edition).
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  # Login happens via `az login` (browser flow) BEFORE running terraform,
  # so no secrets are stored in this project at all.
}
