# AWS EC2 Instance Terraform 

This is an example bit of code written in Terraform at version `0.12.6`. This shows you the fundamentals of Terraform and some cool little utilities you can use to maximise your development process and ensure maximum code quality in an automated fashion.

## Features
* EC2 Instance based on `for_each` per instance
* CodeCommit / CodePipeline / CodeBuild uing `for_each` both for attributes and the resources (CodeBuild) required
* Automated Semantic Versioning/Tagging and updating of CHANGELOG.md
* Creation of an S3 bucket for data storage
* Attachment of an IAM policy to acccess that bucket


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
| codepipeline\_stages | Set of variables and their types for the CodePipeline stages | object | `[ { "category": "Build", "input_artifacts": [ "Source" ], "name": "Dev", "owner": "AWS", "provider": "CodeBuild", "version": "1" }, { "category": "Build", "input_artifacts": [ "Source" ], "name": "Preprod", "owner": "AWS", "provider": "CodeBuild", "version": "1" } ]` | no |
| egress\_cidr |  | list | `[ "0.0.0.0/0" ]` | no |
| ingress\_cidr |  | list | `[ "0.0.0.0/0" ]` | no |
| region |  | string | `"eu-west-1"` | no |
| s3\_bucket\_name |  | string | `"jamesg-data-test-bucket"` | no |
| secondary\_sources | Enables secondary sources if set to true | string | `"false"` | no |
| vpc\_cidr |  | string | `"10.0.0.0/16"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Code written by [James Gonzalez](https://github.com/cultavix)
