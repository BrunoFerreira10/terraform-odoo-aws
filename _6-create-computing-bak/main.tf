terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {
    shared_credentials_files = ["~/aws-dev-cli-admin-credentials.txt"]
    profile                  = "default"

    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "4-create-computing/terraform.tfstate"
  }
}

provider "aws" {
  region                   = var.regiao
  shared_credentials_files = ["~/aws-dev-cli-admin-credentials.txt"]
  profile                  = "default"

  default_tags {
    tags = {
      "owner"      = var.autor
      "project"    = var.projeto
      "customer"   = var.cliente
      "managed-by" = "terraform"
    }
  }
}

module "ec2-odoo-setup" {
  source = "./ec2-odoo-setup"
}