output "efs-addons-endpoint" {
  description = "Endpoint do filesystem para montar /etc/opt"
  value       = module.efs.fs-efs-1-dns
}

output "efs-filestore-endpoint" {
  description = "Endpoint do filesystem para montar /etc/etc"
  value       = module.efs.fs-efs-2-dns
}

output "efs-logs-endpoint" {
  description = "Endpoint do filesystem para montar /etc/etc"
  value       = module.efs.fs-efs-3-dns
}