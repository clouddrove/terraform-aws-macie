provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

module "s3" {

  source  = "clouddrove/s3/aws"
  version = "0.15.1"

  environment = "test"
  label_order = ["name", "environment"]

  name       = "logs-macie"
  versioning = true
  acl        = "private"
}


module "macie" {
  source = "../"

  name        = "example"
  environment = "dev"
  label_order = ["name", "environment"]

  account_id  = data.aws_caller_identity.current.account_id
  bucket_name = [module.s3.id]
  #admin_account_ids = ["232322372372"]  Provide admin account id in Origanisation. 
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

