// Hosted Zone
data "aws_route53_zone" "odoo_hosted_zone" {
  name         = "brunoferreira86dev.com"
  private_zone = false
}

// DNS Record - A
resource "aws_route53_record" "odoo_record_A" {

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.odoo_hosted_zone.zone_id
  name            = "brunoferreira86dev.com"
  type            = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloud-front-odoo.domain_name
    zone_id                = aws_cloudfront_distribution.cloud-front-odoo.hosted_zone_id
    evaluate_target_health = true
  }
}

// DNS Record - CNAME - www
resource "aws_route53_record" "odoo_record_WWW" {

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.odoo_hosted_zone.zone_id
  name            = "www.brunoferreira86dev.com"
  type            = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloud-front-odoo.domain_name
    zone_id                = aws_cloudfront_distribution.cloud-front-odoo.hosted_zone_id
    evaluate_target_health = true
  }
}