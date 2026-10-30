# terraform-website — one website, two worlds (Terraform · example use case)

**Use case:** a simple static website whose entire infrastructure is code.
**Same page template, two deployment targets:**

| Stack | What it builds | Needs |
|---|---|---|
| `local/` | Docker: nginx container + port map + page | Docker Desktop |
| `aws/` | Amazon S3 static-website hosting (public URL) | AWS free-tier account |

```
 terraform-website/
 ├── index.html.tpl      ← THE shared page template (placeholders filled by Terraform)
 ├── local/              ← run it on any laptop in 2 minutes
 │   ├── versions.tf / variables.tf / main.tf / outputs.tf
 └── aws/                ← run it in the real cloud
     ├── versions.tf / variables.tf / main.tf / outputs.tf
```

## Local stack (laptop demo)

```powershell
cd local
terraform init; terraform validate; terraform plan; terraform apply
# -> open the printed URL (default http://localhost:8080)
terraform destroy   # clean removal
```

## AWS stack (cloud demo)

1. Free-tier account: https://aws.amazon.com/free
2. In IAM create a user **"terraform-demo"** with programmatic access + policy
   `AmazonS3FullAccess` (demo scope only; tighten for production).
3. Give Terraform the credentials (environment variables — never files in git):
   ```powershell
   $env:AWS_ACCESS_KEY_ID     = "<from IAM"
   $env:AWS_SECRET_ACCESS_KEY = "<from IAM"
   ```
4. Deploy:
   ```powershell
   cd aws
   terraform init; terraform plan; terraform apply
   # -> prints a public http://…s3-website…amazonaws.com URL anyone can open
   terraform destroy # remove everything (bill goes to zero)
   ```
   Bucket names are globally unique on Earth — edit `bucket_name` if taken.

## Docker-local opens door 8080 — S3 is world-open. Same page text either way:

> "Deployed by Terraform … Where it runs: Docker on this laptop"
> "Deployed by Terraform … Where it runs: AWS S3 (cloud, ap-south-1)"

**Costs:** local = ₹0. AWS demo = pennies (destroy → zero).
**Golden rule:** state (`*.tfstate`), `.terraform/`, credentials → never committed; this repo's `.gitignore already guards them`.
