# VPC 1 Information
output "vpcs-vpc-1-name" {
  description = "Nome da VPC-1"
  value       = module.vpcs.vpc-1-name
}

output "vpcs-vpc-1-id" {
  description = "ID da VPC-1"
  value       = module.vpcs.vpc-1-id
}

output "vpcs-vpc-1-subnet-public-1a-id" {
  description = "VPC-1: ID da subnet publica 1a"
  value       = module.vpcs.vpc-1-subnet-public-1a-id
}

output "vpcs-vpc-1-subnet-public-1b-id" {
  description = "VPC-1: ID da subnet publica 1b"
  value       = module.vpcs.vpc-1-subnet-public-1b-id
}

output "vpcs-vpc-1-subnet-private-1a-id" {
  description = "VPC-1: ID da subnet privada 1a"
  value       = module.vpcs.vpc-1-subnet-private-1a-id
}

output "vpcs-vpc-1-subnet-private-1b-id" {
  description = "VPC-1: ID da subnet privada 1b"
  value       = module.vpcs.vpc-1-subnet-private-1b-id
}

output "vpcs-vpc-1-sg-allow-all-id" {
  description = "VPC-1: Security group tudo liberado, ID"
  value       = module.vpcs.vpc-1-sg-allow-all-id
}

output "vpcs-vpc-1-sg-allow-all-name" {
  description = "VPC-1: Security group tudo liberado, Name"
  value       = module.vpcs.vpc-1-sg-allow-all-name
}

output "vpcs-vpc-1-sg-instances-id" {
  description = "VPC-1: Security group para instancias, ID"
  value       = module.vpcs.vpc-1-sg-instances-id
}

output "vpcs-vpc-1-sg-instances-name" {
  description = "VPC-1: Security group para instancias, Name"
  value       = module.vpcs.vpc-1-sg-instances-name
}

output "vpcs-vpc-1-sg-rds-id" {
  description = "VPC-1: Security group para RDS, ID"
  value       = module.vpcs.vpc-1-sg-rds-id
}

output "vpcs-vpc-1-sg-rds-name" {
  description = "VPC-1: Security group para RDS, Name"
  value       = module.vpcs.vpc-1-sg-rds-name
}

output "vpcs-vpc-1-sg-efs-mountpoints-id" {
  description = "VPC-1: Security group para EFS mount points, ID"
  value       = module.vpcs.vpc-1-sg-efs-mountpoints-id
}

output "vpcs-vpc-1-sg-efs-mountpoints-name" {
  description = "VPC-1: Security group para EFS mount points, Name"
  value       = module.vpcs.vpc-1-sg-efs-mountpoints-name
}

output "vpcs-vpc-1-sg-alb-odoo-id" {
  description = "VPC-1: Security group para ALB Odoo, ID"
  value       = module.vpcs.vpc-1-sg-alb-odoo-id
}

output "vpcs-vpc-1-sg-alb-odoo-name" {
  description = "VPC-1: Security group para ALB Odoo, Name"
  value       = module.vpcs.vpc-1-sg-alb-odoo-name
}