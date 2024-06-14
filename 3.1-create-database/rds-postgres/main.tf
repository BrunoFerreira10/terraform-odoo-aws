data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "create-network/terraform.tfstate"
  }
}