data "aws_iam_policy_document" "allow_from_alb" {

  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      var.enable_create_s3_bucket_log == true ? aws_s3_bucket.this[0].arn : "",
      "${var.enable_create_s3_bucket_log == true ? aws_s3_bucket.this[0].arn : ""}/*",
    ]
  }
}