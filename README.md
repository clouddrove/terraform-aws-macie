<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->


<h1 align="center">
    Terraform AWS Macie
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Provides a resource to manage an AWS Macie Account.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.1.7-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>
<a href="https://github.com/clouddrove/terraform-aws-macie/actions/workflows/tfsec.yml">
  <img src="https://github.com/clouddrove/terraform-aws-macie/actions/workflows/tfsec.yml/badge.svg" alt="tfsec">
</a>
<a href="https://github.com/clouddrove/terraform-aws-macie/actions/workflows/terraform.yml">
  <img src="https://github.com/clouddrove/terraform-aws-macie/actions/workflows/terraform.yml/badge.svg" alt="static-checks">
</a>

</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-aws-macie'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+Macie&url=https://github.com/clouddrove/terraform-aws-macie'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AWS+Macie&url=https://github.com/clouddrove/terraform-aws-macie'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>





## Prerequisites

This module has a few dependencies: 








**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-aws-macie/releases).


### Simple Example
Here is an example of how you can use this module in your inventory structure:
```hcl
# use this
    module "macie" {
    source                  = "clouddrove/macie/aws"
    version                 = "1.0.1"
    name                    = "example"
    environment             = "dev"
    label_order             = ["name","environment"]
    account_id              = data.aws_caller_identity.current.account_id
    bucket_name             = [module.s3.id]
    members                 = [{
    account_id              = "450808965822",
    email                   = "example@mail.com"
    status                  = "ENABLED"
    }]
    custom_data_identifiers = [{
    name                    = "example"
    regex                   = "[0-9]{3}-[0-9]{2}-[0-9]{4}"
    keywords                = ["keyword"]
    ignore                  = ["ignore"]
    maximum_match_distance  = 10
    }]
    classification_jobs     = [{
    name                    = "job-1"
    job_type                = "SCHEDULED"
    }]
    weekly_schedule = "MONDAY"
    }
  
```






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
| label\_order | label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| members | account\_id:<br>email:<br>status:<br>invite:<br>invitation\_message: | `list(any)` | `[]` | no |
| monthly\_schedule | Specifies a monthly recurrence pattern for running the job. | `string` | `null` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-vpc-peering"` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(string)` | `{}` | no |
| weekly\_schedule | Specifies a weekly recurrence pattern for running the job. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| account\_id | The ID of the Macie account. |






## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-aws-macie/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-aws-macie)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
