output "ec2-bastion-id" {
  description = "ID Bastion Host ID"
  value       = module.ec2-odoo-setup.vm-bastion-id
}

output "ec2-bastion-public_ip" {
  description = "ID Bastion Host IP"
  value = module.ec2-odoo-setup.vm-bastion-public_ip
}