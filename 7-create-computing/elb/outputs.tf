output "alb-odoo-ecommerce-id" {
  value = aws_lb.alb-odoo-ecommerce-prod.id
}

output "alb-odoo-ecommerce-name" {
  value = aws_lb.alb-odoo-ecommerce-prod.name
}

output "alb-odoo-ecommerce-dns-name" {
  value = aws_lb.alb-odoo-ecommerce-prod.dns_name
}

output "alb-odoo-ecommerce-zone-id" {
  value = aws_lb.alb-odoo-ecommerce-prod.zone_id
}