output "ec2-base-ami" {
  description = "EC2 base para criar a AMI"
  value       = module.ec2-odoo-setup.vm-1-id
}