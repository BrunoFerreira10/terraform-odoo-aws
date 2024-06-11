terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "aws" {
  region = var.regiao
  shared_credentials_files = ["~/aws-dev-cli-admin-credentials.txt"]
  profile = "default"
  default_tags {
    tags = {
      "owner"      = var.autor
      "project"    = var.projeto
      "customer"   = var.cliente
      "managed-by" = "terraform"
    }
  }
}