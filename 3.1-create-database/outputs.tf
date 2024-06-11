output "rds-postgres-rds-1-id" {
  description = "ID do rds-1"
  value       = module.rds-postgres.rds-1-id
}

output "rds-postgres-rds-1-endpoint" {
  description = "Endpoint do rds-1"
  value       = module.rds-postgres.rds-1-endpoint
}