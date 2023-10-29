provider "aws" {
  region = local.region
}
locals {
  name        = "example"
  environment = "dev"
  region      = "us-east-1"
}
data "aws_caller_identity" "current" {}

module "s3" {

  source  = "clouddrove/s3/aws"
  version = "2.0.0"

  name        = "${local.name}-logs-macie"
  environment = local.environment
  versioning  = true
  acl         = "private"
}

module "macie" {
  source = "../"

  name        = local.name
  environment = local.environment
  account_id  = data.aws_caller_identity.current.account_id
  bucket_name = [module.s3.id]
  members = [{
    account_id = "450808965822",
    email      = "hello@clouddrove.com"
    status     = "ENABLED"
  }]
  custom_data_identifiers = [{
    name                   = "example"
    regex                  = "[0-9]{3}-[0-9]{2}-[0-9]{4}"
    keywords               = ["keyword"]
    ignore                 = ["ignore"]
    maximum_match_distance = 10
  }]
  classification_jobs = [{
    name     = "job-1"
    job_type = "SCHEDULED"
  }]
  weekly_schedule = "MONDAY"
}

