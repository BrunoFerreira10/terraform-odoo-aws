output "vm-bastion-id" {
  value = aws_instance.vm-bastion.id
}

output "vm-bastion-public_ip" {
  value = aws_instance.vm-bastion.public_ip
}