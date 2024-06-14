terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {
    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "create-base-ec2-efs/terraform.tfstate"
  }
}

provider "aws" {
  region                   = var.regiao
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