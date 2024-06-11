output "ami-id" {
  value = aws_ami_from_instance.create-odoo-ami.id
}