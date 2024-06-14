data "terraform_remote_state" "remote-state-base-ec2" {
  backend = "s3"
  config = {
    region = "us-east-1"
    bucket = "remote-state-odoo"
    key    = "create-base-ec2-efs/terraform.tfstate"
  }
}