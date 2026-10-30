# azure/variables.tf -- knobs for the cloud stack (blue edition).

variable "resource_group_name" {
  description = "The Azure 'folder' that holds all this project's cloud objects."
  type        = string
  default     = "rg-terraform-website"
}

variable "location" {
  description = "Azure region (Central India = centralindia)."
  type        = string
  default     = "centralindia"
}

variable "storage_account_name" {
  description = "Globally-unique, lowercase 3-24 chars a-z0-9. Hosting home of the website."
  type        = string
  default     = "tfwebsitenaveed77"
}

variable "site_title" {
  description = "Headline shown on the page."
  type        = string
  default     = "Deployed by Terraform"
}
