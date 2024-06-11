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
  description = "VPC-1: Security group tudo liberado"
  value       = module.vpcs.vpc-1-sg-allow-all-id
}

output "vpcs-vpc-1-sg-allow-all-name" {
  description = "VPC-1: Security group tudo liberado"
  value       = module.vpcs.vpc-1-sg-allow-all-name
}

# VPC 2 Information
output "vpcs-vpc-2-name" {
  description = "Nome da VPC-2"
  value       = module.vpcs.vpc-2-name
}

output "vpcs-vpc-2-id" {
  description = "ID da VPC-2"
  value       = module.vpcs.vpc-2-id
}