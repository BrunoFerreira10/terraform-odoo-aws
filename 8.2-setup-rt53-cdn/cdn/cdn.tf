// Cache policies
resource "aws_cloudfront_cache_policy" "cache-policy-odoo-default" {

  name    = "Odoo-CachePolicy-default"
  comment = "Odoo-CachePolicy-default"

  min_ttl     = 1
  default_ttl = 60
  max_ttl     = 120

  parameters_in_cache_key_and_forwarded_to_origin {

    headers_config {
      header_behavior = "none"
    }
    cookies_config {
      cookie_behavior = "all"
    }
    query_strings_config {
      query_string_behavior = "all"
    }

    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip = true    
  }

}

// Cloudfront distribution
resource "aws_cloudfront_distribution" "cloud-front-odoo" {

  // Settings
  enabled         = true
  comment         = "cdn-odoo"
  price_class     = "PriceClass_All"
  http_version    = "http2and3"
  is_ipv6_enabled = true
  // Aliases = Alternate domains names
  aliases = ["brunoferreira86dev.com", "www.brunoferreira86dev.com"]
  // Custom SSL certificate
  viewer_certificate {
    acm_certificate_arn      = data.terraform_remote_state.remote-ssl-certificate.outputs.acm-acm-odoo-certificate-arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  // Security
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "BR", "NZ"]
    }
  }

  // Origins
  origin {
    domain_name = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-dns-name
    origin_id   = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id

    custom_origin_config {
      origin_protocol_policy = "match-viewer"
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    custom_header {
      name  = "from_cdn_header"
      value = "from_cdn_value"
    }
  }

  // Behaviors  

  // Default
  default_cache_behavior {

    target_origin_id = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id
    compress         = true

    // Settings
    viewer_protocol_policy = "redirect-to-https"
    # min_ttl                = 0
    # default_ttl            = 60
    # max_ttl                = 120

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    // Managed-CachingDisabled
    //cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    cache_policy_id = aws_cloudfront_cache_policy.cache-policy-odoo-default.id

    // Managed-AllViewer
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
  }

  tags = {
    Environment = "production"
  }

  # Precedend 0 = /shop
  ordered_cache_behavior {
    path_pattern     = "/shop"
    target_origin_id = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id
    compress         = false

    // Settings
    viewer_protocol_policy = "redirect-to-https"
    # min_ttl                = 0
    # default_ttl            = 60
    # max_ttl                = 120

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    // Managed-CachingDisabled
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"

    // Managed-AllViewer
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
  }

  # Precedend 1 = /shop/cart
  ordered_cache_behavior {
    path_pattern     = "/shop/cart"
    target_origin_id = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id
    compress         = false

    // Settings
    viewer_protocol_policy = "redirect-to-https"
    # min_ttl                = 0
    # default_ttl            = 60
    # max_ttl                = 120

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    // Managed-CachingDisabled
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"

    // Managed-AllViewer
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
  }

  # Precedend 2 = /shop/payment
  ordered_cache_behavior {
    path_pattern     = "/shop/payment"
    target_origin_id = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id
    compress         = false

    // Settings
    viewer_protocol_policy = "redirect-to-https"
    # min_ttl                = 0
    # default_ttl            = 60
    # max_ttl                = 120

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    // Managed-CachingDisabled
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"

    // Managed-AllViewer
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
  }

  # Precedend 3 = /payment/status
  ordered_cache_behavior {
    path_pattern     = "/payment/status"
    target_origin_id = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id
    compress         = false

    // Settings
    viewer_protocol_policy = "redirect-to-https"
    # min_ttl                = 0
    # default_ttl            = 60
    # max_ttl                = 120

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    // Managed-CachingDisabled
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"

    // Managed-AllViewer
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
  }

  # Precedend 4 = /payment/status/poll
  ordered_cache_behavior {
    path_pattern     = "/payment/status/poll"
    target_origin_id = data.terraform_remote_state.remote-computing.outputs.elb-alb-odoo-ecommerce-id
    compress         = false

    // Settings
    //viewer_protocol_policy = "redirect-to-https"
    viewer_protocol_policy = "allow-all"
    # min_ttl                = 0
    # default_ttl            = 60
    # max_ttl                = 120

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    //cached_methods  = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    // Managed-CachingDisabled
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"

    // Managed-AllViewer
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
  }

}

