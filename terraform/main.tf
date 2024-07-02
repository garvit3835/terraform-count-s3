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

provider "random" {}

resource "random_string" "example-1" {
  length  = 12
  special = false
}

resource "aws_s3_bucket" "example" {
  count  = local.bucket_count
  bucket = "${random_string.example-1.result}-${count.index}"

  tags = {
    Name = "${random_string.example-1.result}-${count.index}"
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
