variable "enable_create_s3_bucket_log" {
  type = bool
}

variable "bucket_env_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}

variable "enable_versioning_configuration" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "internal" {
  type = bool
}

variable "load_balancer_type" {
  type = string
}

variable "subnets_ids" {
  type = list(string)
}

variable "enable_deletion_protection" {
  type = bool
}

variable "access_logs_prefix" {
  type = string
}

variable "aditional_tags" {
  type = map(string)
}

variable "create_rule_redirect_https" {
  type = bool
}

variable "vpc_id" {
  type = string
}