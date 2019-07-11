# AWS EC2 Instance Terraform 

## Features
* EC2 Instance
* 


## Requirements
* [git-chglog](https://github.com/git-chglog/git-chglog)
* [semtag](https://github.com/pnikosis/semtag)

Terraform module which creates EC2 instance(s) on AWS.

These types of resources are supported:

* [EC2 instance](https://www.terraform.io/docs/providers/aws/r/instance.html)


## Usage
```bash
terraform init
terraform plan
terraform apply
```


## Notes


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| s3\_bucket\_name |  | string | `"jg-test-bucket"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Code written by [James Gonzalez](https://github.com/cultavix)
