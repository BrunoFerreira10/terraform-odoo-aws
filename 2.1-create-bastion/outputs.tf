output "ec2-bastion-id" {
  description = "ID Bastion Host ID"
  value       = module.vm-bastion.vm-bastion-id
}

output "ec2-bastion-public_ip" {
  description = "ID Bastion Host IP"
  value = module.vm-bastion.vm-bastion-public_ip
}