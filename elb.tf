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