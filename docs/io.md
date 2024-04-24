## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | The unique identifier for the AWS account that owns the buckets. | `string` | `""` | no |
| account\_status | Macie account status. Possible values are `ENABLED` and `PAUSED`. Setting it to `ENABLED` will start all Macie activities for the account. | `bool` | `true` | no |
| admin\_account\_ids | The list of AWS account IDs for the account to designate as the delegated Amazon Macie administrator accounts for the organization. | `list(string)` | `[]` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| bucket\_name | The name of an AWS Partition S3 Bucket or the Amazon Resource Name (ARN) of S3 on Outposts Bucket that you want to associate this access point with. | `list(any)` | `[]` | no |
| classification\_jobs | A list of maps of classification jobs.<br>  name:<br>  description : <br>  initial\_run:<br>  job\_type :<br>  Possible values:<br>  job\_status:<br>  sampling\_percentage : | `list(any)` | `[]` | no |
| custom\_data\_identifiers | A list of maps of custom data identifiers.<br>regex:<br>keywords:<br>ignore\_words:<br>maximum\_match\_distance:<br>name:<br>description:<br>tags: | `list(any)` | `[]` | no |
| daily\_schedule | Specifies a daily recurrence pattern for running the job. | `string` | `null` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| enabled | n/a | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| finding\_publishing\_frequency | Specifies how often to publish updates to policy findings for the account. This includes publishing updates to AWS Security Hub and Amazon EventBridge (formerly called Amazon CloudWatch Events). Valid values are FIFTEEN\_MINUTES, ONE\_HOUR or SIX\_HOURS. | `string` | `"ONE_HOUR"` | no |
| label\_order | label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| members | account\_id:<br>email:<br>status:<br>invite:<br>invitation\_message: | `list(any)` | `[]` | no |
| monthly\_schedule | Specifies a monthly recurrence pattern for running the job. | `string` | `null` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-vpc-peering"` | no |
| weekly\_schedule | Specifies a weekly recurrence pattern for running the job. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| account\_id | The ID of the Macie account. |

