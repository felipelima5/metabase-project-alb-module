resource "aws_s3_bucket" "this" {
  count  = var.enable_create_s3_bucket_log == true ? 1 : 0
  bucket = var.bucket_env_name
  tags   = var.tags
}

resource "aws_s3_bucket_public_access_block" "example" {
  count  = var.enable_create_s3_bucket_log == true ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}