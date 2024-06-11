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
  description = "VPC-1: Security group tudo liberado"
  value       = aws_security_group.vpc-1-sg-allow-all.id
}

output "vpc-1-sg-allow-all-name" {
  description = "VPC-1: Security group tudo liberado"
  value       = aws_security_group.vpc-1-sg-allow-all.name
}

# VPC 2 Information
output "vpc-2-name" {
  description = "Nome da VPC-2"
  value       = aws_vpc.vpc-2.tags["Name"]
}

output "vpc-2-id" {
  description = "Nome da VPC-2"
  value       = aws_vpc.vpc-2.id
}