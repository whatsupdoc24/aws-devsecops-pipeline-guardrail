provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket        = "portfolio-guardrail-test-bucket-999"
  force_destroy = true
}

# FIX 1: Enforce full KMS Server-Side Encryption on the S3 Bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_encryption" {
  bucket = aws_s3_bucket.vulnerable_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# FIX 2: Explicitly block all public access boundaries to the bucket
resource "aws_s3_bucket_public_access_block" "secure_block" {
  bucket                  = aws_s3_bucket.vulnerable_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# FIX 3: Close port 22 down from the public internet (0.0.0.0/0) to a secure single static IP
resource "aws_security_group" "vulnerable_sg" {
  name        = "vulnerable-ssh-sg"
  description = "Allow SSH from trusted office static network only"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["78.22.45.111/32"] # Secure mock company static IP block
  }
}

 
 
 
