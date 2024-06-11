// DNS
data "aws_route53_zone" "odoo_hosted_zone" {
  name         = "brunoferreira86dev.com"
  private_zone = false
}

// ACM SSL Certificate
resource "aws_acm_certificate" "odoo-certificate" {
  domain_name       = "brunoferreira86dev.com"
  validation_method = "DNS"

  subject_alternative_names = [
    "www.brunoferreira86dev.com"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-odoo-certificate"
  }
}

// DNS Record - Certificate validation
resource "aws_route53_record" "acm-record-validation-odoo" {
  for_each = {
    for dvo in aws_acm_certificate.odoo-certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.odoo_hosted_zone.zone_id
}

// Certificate validation
resource "aws_acm_certificate_validation" "odoo-certificate-validation" {
  certificate_arn = aws_acm_certificate.odoo-certificate.arn
  validation_record_fqdns = [
    for record in aws_route53_record.acm-record-validation-odoo : record.fqdn
  ]
}