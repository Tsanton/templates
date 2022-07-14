terraform {
  # backend "s3" {
  #   bucket = "tantonterraformbuckets3"
  #   key    = "value"
  #   region = "value"
  # }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}

provider "aws" {
    region     = "eu-north-1"
    access_key = var.aws_access_key
    secret_key = var.aws_access_secret
}