// Cloudfront
resource "aws_cloudfront_distribution" "cloud-front-odoo" {

  enabled = true

  // Aliases = Alternate domains names
  aliases = ["brunoferreira86dev.com", "www.brunoferreira86dev.com"] 

  origin {
    domain_name = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-dns-name
    // origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    #origin_path = "brunoferreira86dev.com"
    origin_id = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id

    custom_origin_config {
      origin_protocol_policy = "https-only"
      http_port              = 80
      https_port             = 443
      //origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "from_cdn_header"
      value = "from_cdn_value"
    }
  }

  default_cache_behavior {
    target_origin_id = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id

    compress = true

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 120

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    // Managed-CachingDisabled
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"

    // Managed-AllViewer
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "BR"]
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.terraform_remote_state.remote-ssl-certificate.outputs.acm-acm-odoo-certificate-arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  http_version = "http2and3"

  is_ipv6_enabled = true

  comment = "cdn-odoo"

  tags = {
    Environment = "production"
  }
}