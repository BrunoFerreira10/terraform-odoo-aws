// Target group
resource "aws_lb_target_group" "tgrp-alb-odoo-ecommerce" {
  name     = "tgrp-alb-odoo-ecommerce"
  port     = 8069
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-id

  # stickiness {
  #   type            = "lb_cookie"
  #   cookie_duration = 3600
  # }

  health_check {
    enabled             = true
    protocol            = "HTTP"    
    port                = 8069
    interval            = 20
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher = "200-399"
  }  

  deregistration_delay = 60  
}

// Application Load balancer
resource "aws_lb" "alb-odoo-ecommerce-prod" {
  name               = "alb-odoo-ecommerce-prod"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-sg-alb-odoo-id
  ]
  subnets = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1a-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-public-1b-id
  ]

  enable_deletion_protection = false

  tags = {
    Name        = "alb-odoo-ecommerce-prod"
    Environment = "production"
  }
}

// Load balancer listeners
resource "aws_lb_listener" "listener-http-alb-odoo-ecommerce-prod-1" {
  load_balancer_arn = aws_lb.alb-odoo-ecommerce-prod.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener_rule" "rule-fw-to-alb" {
  listener_arn = aws_lb_listener.listener-https-alb-odoo-ecommerce-prod-1.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgrp-alb-odoo-ecommerce.arn
  }

  condition {
    http_header {
      http_header_name = "from_cdn_header"
      values = ["from_cdn_value"]
    }
  }
}

resource "aws_lb_listener" "listener-https-alb-odoo-ecommerce-prod-1" {
  load_balancer_arn = aws_lb.alb-odoo-ecommerce-prod.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.terraform_remote_state.remote-ssl-certificate.outputs.acm-acm-odoo-certificate-arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Acesso negado"
      status_code  = "503"
    }
  }
}

// Auto-scaling
resource "aws_autoscaling_group" "asg-odoo-v1" {

  // Group Details
  capacity_rebalance = true
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1

  lifecycle {
    create_before_destroy = true
  }

  // Launch template
  launch_template {
    id      = aws_launch_template.ltplt-odoo-v1.id
    version = "$Latest"
  }

  // Network
  vpc_zone_identifier = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1a-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-subnet-private-1b-id
  ]    

  // Load balancing
  target_group_arns = [
    aws_lb_target_group.tgrp-alb-odoo-ecommerce.arn
  ]

  // Health checks
  health_check_type = "ELB"
  health_check_grace_period = 60

  // Advanced configuration
  default_cooldown = 180

  // Metrics
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"
  
}