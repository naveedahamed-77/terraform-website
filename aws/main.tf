# aws/main.tf -- the cloud stack: one static website on S3, public-read.
#
#   1. Create the S3 bucket (the cloud's public parking spot for the site).
#   2. Allow public GET requests (website = visitors must be able to read).
#   3. Declare this bucket a website (index = index.html).
#   4. Upload the rendered page straight from the shared Terraform template.
#
# COST: pennies per month, free-tier friendly for a demo. Destroy removes it all.

data "aws_iam_policy_document" "public_read" {
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "site" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "site" {
  bucket = aws_s3_bucket.site.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.public_read.json
  depends_on = [aws_s3_bucket_public_access_block.site]
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.site.id
  key          = "index.html"
  content_type = "text/html"
  # NOTE: no `acl` here -- BucketOwnerEnforced forbids object ACLs. Public
  # access is granted by the bucket policy (public_read) instead -- modern AWS way.
  content = templatefile("${path.module}/../index.html.tpl", {
    title      = var.site_title
    host_label = "AWS S3 (cloud, ${var.region})"
    engine     = "aws-s3-static-site"
  })
  depends_on = [aws_s3_bucket_website_configuration.site, aws_s3_bucket_policy.public_read]
}
