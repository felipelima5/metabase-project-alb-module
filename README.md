# CREATE A LoadBalancer Applications 
### How to Use the LoadBalancer Applications Terraform Module

<details><summary>Mandatory Config Requirements</summary>
<p>
  
### create file provider.tf  
```
provider "aws" {
  region  = var.region
  profile = "default"
} 

terraform {
  backend "s3" {
    bucket  = "state-tf"
    key     = "states/infra.tfstate"
    encrypt = "true"
    region  = "us-east-2"
    profile = "homolog"
  }
}  

```

### create file config_vpc.tf  

```
data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*${var.subnet_type}*"
  }
}

locals {
  subnets = data.aws_subnets.this.ids[*]
}

```


### create file variables.tf  

```

variable "vpc_id" {
  type    = string
  default = "vpc-xxxxxxxxxxxxxx"
}

variable "subnet_type" {
  type    = string
  default = "private"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

```


<details><summary>Mandatory LoadBalancer Applications Requirements</summary>
<p>

Minimum requirements to create a LoadBalancer Applications

### create file alb.tf  
```
module "alb_01" {
    source = "git@github.com:felipelima5/metabase-project-alb-module.git?ref=v1.0.0"

  alb_name                   = "alb-api-validation-logs"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  vpc_id                     = var.vpc_id
  subnets_ids                = local.subnets

  enable_create_s3_bucket_log     = false
  bucket_env_name                 = "log-alb-teste-app-module"
  access_logs_prefix              = "log-dev"
  enable_versioning_configuration = "Enabled"

  create_rule_redirect_https = true

  security_group_app_ingress_rules = [
    {
      description     = "Allow Traffic HTTP 443"
      port            = 443
      protocol        = "tcp"
      security_groups = []
      cidr_blocks     = ["0.0.0.0/0"]
    },
    {
      description     = "Allow Traffic HTTP 80"
      port            = 80
      protocol        = "tcp"
      security_groups = []
      cidr_blocks     = ["0.0.0.0/0"]
    }
  ]

  security_group_app_egress_rules = [
    {
      description     = "All Traffic"
      port            = 0
      protocol        = "-1"
      security_groups = []
      cidr_blocks     = ["0.0.0.0/0"]
    }
  ]

  aditional_tags = {
    Env = "Dev"
  }

}

```