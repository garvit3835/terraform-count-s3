provider "aws" {
  region = "us-west-2"
}

variable "environment" {
  description = "The environment in which to deploy"
  type        = string
  default     = "development"
}

variable "prod_count" {
  type = number
  default = 4
}

variable "dev_count" {
  type = number
  default = 2
}

locals {
  bucket_count = var.environment == "production" ? var.prod_count : var.dev_count
}

provider "random" {}

resource "random_string" "example-1" {
  length  = 12
  special = false
}

resource "aws_s3_bucket" "example" {
  count  = local.bucket_count
  bucket = "${lower(random_string.example-1.result)}-${count.index}"

  tags = {
    Name = "${lower(random_string.example-1.result)}-${count.index}"
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
