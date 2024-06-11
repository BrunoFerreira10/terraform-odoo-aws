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

data "terraform_remote_state" "remote-ami" {
  backend = "s3"
  config = {
    shared_credentials_files = ["~/aws-dev-cli-admin-credentials.txt"]
    profile                  = "default"

    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "update-ami-optional/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-ssl-certificate" {
  backend = "s3"
  config = {
    shared_credentials_files = ["~/aws-dev-cli-admin-credentials.txt"]
    profile                  = "default"

    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "create-ssl-certificate/terraform.tfstate"
  }
}