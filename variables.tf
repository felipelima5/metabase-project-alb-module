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