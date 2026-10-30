# local/outputs.tf -- printed when apply succeeds.

output "website_url" {
  description = "Open this in a browser."
  value       = "http://localhost:${var.http_port}"
}

output "container_name" {
  value = docker_container.web.name
}
