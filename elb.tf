resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.this.id]
  subnets            = var.subnets_ids

  enable_deletion_protection = var.enable_deletion_protection

  access_logs {
    bucket  = var.enable_create_s3_bucket_log == true ? aws_s3_bucket.this[0].id : ""
    prefix  = var.access_logs_prefix
    enabled = var.enable_create_s3_bucket_log
  }
  depends_on = [aws_s3_bucket.this]

  tags = merge(var.tags, var.aditional_tags)
}


resource "aws_lb_listener" "redirect" {
  count = var.create_rule_redirect_https == true ? 1 : 0

  load_balancer_arn = aws_lb.this.arn
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
  tags = merge(var.tags, var.aditional_tags)
}


resource "aws_security_group" "this" {
  name        = "${var.alb_name}-application"
  description = "Allow Traffic Communication ${var.alb_name}-application"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_app_ingress_rules
    content {
      description     = ingress.value["description"]
      from_port       = ingress.value["port"]
      to_port         = ingress.value["port"]
      protocol        = ingress.value["protocol"]
      security_groups = ingress.value["security_groups"]
      cidr_blocks     = ingress.value["cidr_blocks"]
    }
  }
}