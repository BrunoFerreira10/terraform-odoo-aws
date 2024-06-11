// Criar AMI
resource "aws_ami_from_instance" "create-odoo-ami" {
  name                    = "terraform-ami-odoo-efs-v1"
  source_instance_id      = data.terraform_remote_state.remote-state-base-ec2.outputs.ec2-base-ami
  snapshot_without_reboot = true

  tags = {
    Name = "terraform-ami-odoo-efs-v1"
  }
}