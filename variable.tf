
#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "attributes" {
  type        = list(any)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-vpc-peering"
  description = "Terraform current module repo"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `organization`, `environment`, `name` and `attributes`."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "label order, e.g. `name`,`application`."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "enabled" {
  type    = bool
  default = true
}
variable "account_status" {
  type        = bool
  description = "Macie account status. Possible values are `ENABLED` and `PAUSED`. Setting it to `ENABLED` will start all Macie activities for the account."
  default     = true
}

variable "admin_account_ids" {
  type        = list(string)
  description = "The list of AWS account IDs for the account to designate as the delegated Amazon Macie administrator accounts for the organization."
  default     = []
}

variable "members" {
  type        = list(any)
  description = <<-DOC
      account_id:
      email:
      status:
      invite:
      invitation_message:
      DOC
  default     = []
}

variable "custom_data_identifiers" {
  type        = list(any)
  description = <<-DOC
    A list of maps of custom data identifiers.
    regex:
    keywords:
    ignore_words:
    maximum_match_distance:
    name:
    description:
    tags: 
  DOC
  default     = []
}

variable "classification_jobs" {
  type        = list(any)
  description = <<-DOC
    A list of maps of classification jobs.
      name:
      description : 
      initial_run:
      job_type :
      Possible values:
      job_status:
      sampling_percentage :
      DOC
  default = [
  ]
}

variable "finding_publishing_frequency" {
  type        = string
  description = "Specifies how often to publish updates to policy findings for the account. This includes publishing updates to AWS Security Hub and Amazon EventBridge (formerly called Amazon CloudWatch Events). Valid values are FIFTEEN_MINUTES, ONE_HOUR or SIX_HOURS."
  validation {
    condition     = var.finding_publishing_frequency == "FIFTEEN_MINUTES" || var.finding_publishing_frequency == "ONE_HOUR" || var.finding_publishing_frequency == "SIX_HOURS"
    error_message = "The finding_publishing_frequency value must be one of (\"FIFTEEN_MINUTES\" | \"ONE_HOUR\" | \"SIX_HOURS\")."
  }
  default = "ONE_HOUR"
}

variable "account_id" {
  type        = string
  default     = ""
  description = "The unique identifier for the AWS account that owns the buckets."
}

variable "bucket_name" {
  type        = list(any)
  default     = []
  description = "The name of an AWS Partition S3 Bucket or the Amazon Resource Name (ARN) of S3 on Outposts Bucket that you want to associate this access point with."
}

variable "daily_schedule" {
  type        = string
  default     = null
  description = "Specifies a daily recurrence pattern for running the job."
}

variable "weekly_schedule" {
  type        = string
  default     = null
  description = "Specifies a weekly recurrence pattern for running the job."
}

variable "monthly_schedule" {
  type        = string
  default     = null
  description = "Specifies a monthly recurrence pattern for running the job."
}