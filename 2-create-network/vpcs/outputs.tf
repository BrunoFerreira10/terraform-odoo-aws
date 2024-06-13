# VPC 1 Information
output "vpc-1-name" {
  description = "Nome da VPC-1"
  value       = aws_vpc.vpc-1.tags["Name"]
}

output "vpc-1-id" {
  description = "Nome da VPC-1"
  value       = aws_vpc.vpc-1.id
}

output "vpc-1-subnet-public-1a-id" {
  description = "VPC-1: ID da subnet publica 1a"
  value       = aws_subnet.vpc-1-subnet-public-1a.id
}

output "vpc-1-subnet-public-1b-id" {
  description = "VPC-1: ID da subnet publica 1b"
  value       = aws_subnet.vpc-1-subnet-public-1b.id
}

output "vpc-1-subnet-private-1a-id" {
  description = "VPC-1: ID da subnet privada 1a"
  value       = aws_subnet.vpc-1-subnet-private-1a.id
}

output "vpc-1-subnet-private-1b-id" {
  description = "VPC-1: ID da subnet privada 1b"
  value       = aws_subnet.vpc-1-subnet-private-1b.id
}

output "vpc-1-sg-allow-all-id" {
  description = "VPC-1: Security group tudo liberado ID"
  value       = aws_security_group.vpc-1-sg-allow-all.id
}

output "vpc-1-sg-allow-all-name" {
  description = "VPC-1: Security group tudo liberado Name"
  value       = aws_security_group.vpc-1-sg-allow-all.name
}

output "vpc-1-sg-instances-id" {
  description = "VPC-1: Security group para instancias, ID"
  value       = aws_security_group.vpc-1-sg-instances.id
}

output "vpc-1-sg-instances-name" {
  description = "VPC-1: Security group para instancias, Name"
  value       = aws_security_group.vpc-1-sg-instances.name
}

output "vpc-1-sg-rds-id" {
  description = "VPC-1: Security group para RDS, ID"
  value       = aws_security_group.vpc-1-sg-rds.id
}

output "vpc-1-sg-rds-name" {
  description = "VPC-1: Security group para RDS, Name"
  value       = aws_security_group.vpc-1-sg-rds.name
}

output "vpc-1-sg-efs-mountpoints-id" {
  description = "VPC-1: Security group para EFS mount points, ID"
  value       = aws_security_group.vpc-1-sg-efs-mountpoints.id
}

output "vpc-1-sg-efs-mountpoints-name" {
  description = "VPC-1: Security group para EFS mount points, Name"
  value       = aws_security_group.vpc-1-sg-efs-mountpoints.name
}

output "vpc-1-sg-alb-odoo-id" {
  description = "VPC-1: Security group para ALB Odoo, ID"
  value       = aws_security_group.vpc-1-sg-alb-odoo.id
}

output "vpc-1-sg-alb-odoo-name" {
  description = "VPC-1: Security group para ALB Odoo, Name"
  value       = aws_security_group.vpc-1-sg-alb-odoo.name
}