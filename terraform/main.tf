terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}

provider "time" {
  # Configuration options
}

