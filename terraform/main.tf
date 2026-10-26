provider "aws" {
  region = "us-east-1"
}

# VIOLATION 1: S3 Bucket missing encryption or public access blocks
resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket        = "portfolio-guardrail-test-bucket-999"
  force_destroy = true
}

# VIOLATION 2: Security Group completely wide open to the public on port 22 (SSH)
resource "aws_security_group" "vulnerable_sg" {
  name        = "vulnerable-ssh-sg"
  description = "Allow SSH from everywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # This will trigger a hard-fail scan later
  }
}

 
