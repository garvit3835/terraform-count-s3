provider "aws" {
  region = "us-west-2"
}

variable "environment" {
  description = "The environment in which to deploy"
  type        = string
  default     = "development"
}

locals {
  bucket_count = var.environment == "production" ? 4 : 2
}

resource "aws_s3_bucket" "example" {
  count  = local.bucket_count
  bucket = "my-tf-test-bucket-${count.index}"

  tags = {
    Name = "bucket-${count.index}"
  }
}

# Output the environment variable to verify its value
output "environment" {
  value = var.environment
}

# Output the number of buckets to be created
output "bucket_count" {
  value = local.bucket_count
}
