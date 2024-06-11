data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    shared_credentials_files = ["~/aws-dev-cli-admin-credentials.txt"]
    profile                  = "default"

    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "create-network/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-state-rds-postgres" {
  backend = "s3"
  config = {
    shared_credentials_files = ["~/aws-dev-cli-admin-credentials.txt"]
    profile                  = "default"

    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "create-database/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-state-efs" {
  backend = "s3"
  config = {
    shared_credentials_files = ["~/aws-dev-cli-admin-credentials.txt"]
    profile                  = "default"

    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "create-efs/terraform.tfstate"
  }
}