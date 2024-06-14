terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {
    access_key     = var.AWS_ACCESS_KEY_ID
    secret_key     = var.AWS_SECRET_ACCESS_KEY

    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "create-network/terraform.tfstate"
    
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

module "vpcs" {
  source = "./vpcs"

  allowed-iplist = ["0.0.0.0/0"]

  vpc-1-name = "vpc-odoo"  
}

