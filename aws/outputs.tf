# aws/outputs.tf -- what the cloud build announces when done.

output "website_endpoint" {
  description = "The public URL of the live website (anywhere in the world)."
  value       = "http://${aws_s3_bucket_website_configuration.site.website_endpoint}"
}

output "bucket_name" {
  value = aws_s3_bucket.site.bucket
}

output "region" {
  value = var.region
}
