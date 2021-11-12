module "labels" {
  source  = "clouddrove/labels/aws"
  version = "0.15.0"

  name        = var.name
  environment = var.environment
  attributes  = var.attributes
  repository  = var.repository
  managedby   = var.managedby
  label_order = var.label_order
}

data "aws_caller_identity" "current" {}

locals {
  enabled                 = var.enabled
  account_enabled         = local.enabled && var.account_status
  admin_account_ids       = local.enabled && length(var.admin_account_ids) > 0 ? var.admin_account_ids : []
  members                 = local.enabled && length(var.members) > 0 ? { for member in flatten(var.members) : member.account_id => member } : {}
  custom_data_identifiers = local.enabled && length(var.custom_data_identifiers) > 0 ? { for cdi in flatten(var.custom_data_identifiers) : cdi.name => cdi } : {}
  classification_jobs     = local.enabled && length(var.classification_jobs) > 0 ? { for job in flatten(var.classification_jobs) : job.name => job } : {}
}

// Setup the Organization Account as Manager, but delegate to the account set in `admin_account_id`

resource "aws_macie2_account" "default" {
  count = local.enabled ? 1 : 0

  finding_publishing_frequency = var.finding_publishing_frequency
  status                       = local.account_enabled ? "ENABLED" : "PAUSED"
}

resource "aws_macie2_organization_admin_account" "default" {

  for_each         = toset(var.admin_account_ids)
  admin_account_id = each.value
  depends_on = [
    aws_macie2_account.default
  ]
}

resource "aws_macie2_member" "default" {
  for_each                              = local.members
  account_id                            = each.value.account_id
  email                                 = each.value.email
  invite                                = lookup(each.value, "invite", null)
  invitation_message                    = lookup(each.value, "invitation_message", null)
  invitation_disable_email_notification = lookup(each.value, "invitation_disable_email_notification", null)
  status                                = lookup(each.value, "status", "ENABLED")
  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s%s%s", module.labels.id, var.delimiter, each.value.account_id)
    }
  )
  lifecycle {
    ignore_changes = [tags, status, invite, email]
  }
  depends_on = [
    aws_macie2_account.default,
    aws_macie2_organization_admin_account.default
  ]
}

resource "aws_macie2_custom_data_identifier" "default" {
  for_each = local.custom_data_identifiers

  name                   = each.value.name
  description            = lookup(each.value, "description", "Managed by Clouddrove")
  regex                  = lookup(each.value, "regex", null)
  keywords               = lookup(each.value, "keywords", null)
  ignore_words           = lookup(each.value, "ignore_words", null)
  maximum_match_distance = lookup(each.value, "maximum_match_distance", null)
  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s%s%s", module.labels.id, var.delimiter, each.value.name)
    }
  )
  depends_on = [
    aws_macie2_account.default
  ]
}

resource "aws_macie2_classification_job" "default" {
  for_each = local.classification_jobs

  name                       = each.value.name
  sampling_percentage        = lookup(each.value, "sampling_percentage", null)
  initial_run                = lookup(each.value, "initial_run", null)
  job_type                   = each.value.job_type
  job_status                 = lookup(each.value, "job_status", null)
  custom_data_identifier_ids = lookup(each.value, "custom_data_identifier_ids", null)
  s3_job_definition {
    bucket_definitions {
      account_id = var.account_id == "" ? data.aws_caller_identity.current.account_id : var.account_id
      buckets    = var.bucket_name
    }
  }
  schedule_frequency {
    daily_schedule   = var.daily_schedule
    weekly_schedule  = var.weekly_schedule
    monthly_schedule = var.monthly_schedule
  }

  tags = merge(
    module.labels.tags,
    {
      "Name" = format("%s%s%s", module.labels.id, var.delimiter, each.value.name)
    }
  )
  depends_on = [
    aws_macie2_account.default
  ]
}