provider "aws" {
  region = "us-west-2" # Specify the AWS region
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
    Name        = "bucket-${count.index}"
  }
}