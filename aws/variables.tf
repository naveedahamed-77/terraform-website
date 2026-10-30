# aws/variables.tf -- knobs for the cloud stack.

variable "region" {
  description = "AWS region to host the website in (Mumbai = ap-south-1)."
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally-unique S3 bucket name for the website."
  type        = string
  default     = "terraform-website-fresher-demo"
}

variable "site_title" {
  description = "Headline shown on the page."
  type        = string
  default     = "Deployed by Terraform"
}
