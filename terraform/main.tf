# Sample Terraform - intentionally has some issues for Checkov to find
provider "aws" {
  region = "us-east-1"
}

# This bucket is missing versioning - Checkov will flag this
resource "aws_s3_bucket" "app_artifacts" {
  bucket = "devsecops-demo-artifacts"

  tags = {
    Name        = "devsecops-demo-artifacts"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# This one is properly configured
resource "aws_s3_bucket_versioning" "app_artifacts" {
  bucket = aws_s3_bucket.app_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_artifacts" {
  bucket = aws_s3_bucket.app_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
