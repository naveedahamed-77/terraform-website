# local/variables.tf -- knobs for the laptop demo stack.

variable "site_title" {
  description = "Headline shown on the page."
  type        = string
  default     = "Deployed by Terraform"
}

variable "engine" {
  description = "Serving engine advertised in the page badge."
  type        = string
  default     = "nginx:1.27-alpine"
}

variable "http_port" {
  description = "Host port to expose the website on."
  type        = number
  default     = 8080
}
