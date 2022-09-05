terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    archive = {
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}