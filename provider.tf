# Configure the AWS Provider

provider "aws" {
  profile = "default"
  region  = var.region
}

terraform {
  required_version = "1.6.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.00"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
