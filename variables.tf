variable "s3_bucket_name" {
  default = "jamesg-data-test-bucket"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "eu-west-1"
}

variable "ingress_cidr" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "egress_cidr" {
  type    = list
  default = ["0.0.0.0/0"]
}


#### CODE COMMIT

variable codecommit_name {
  default     = "jamesg-test"
  description = "Name of CodeCommit Repository. Name must be between 2 and 256 characters and comply with the regex: (?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*"
}

variable codecommit_default_branch {
  default     = "master"
  description = "Default branch of CodeCommit Repository"
}

variable codecommit_description {
  default     = "jamesg-test"
  description = "Description of CodeCommit repository"
}

variable codebuild_project_name {
  default     = "jamesg-test"
  description = "Name of CodeBuild project"
}

variable codebuild_compute_type {
  default     = "BUILD_GENERAL1_SMALL"
  description = " Information about the compute resources the build project will use. Available values for this parameter are: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM or BUILD_GENERAL1_LARGE. BUILD_GENERAL1_SMALL is only valid if type is set to LINUX_CONTAINER"
}

variable codebuild_image_base {
  default     = "aws/codebuild/ubuntu-base"
  description = "The base for the Docker image to use for this build project. This can be custom in the form of a path to an image in a Docker repository or built-in images as described by https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html"
}

variable codebuild_image_tag {
  default     = "14.04"
  description = "The tag for the Docker image to use for this build project. This can be custom in the form of a path to an image in a Docker repository or built-in images as described by https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html"
}

variable codebuild_image_type {
  default     = "LINUX_CONTAINER"
  description = "The type of build environment to use for related builds. Available values are: LINUX_CONTAINER or WINDOWS_CONTAINER."
}

variable codebuild_privileged_mode {
  default     = true
  description = " If set to true, enables running the Docker daemon inside a Docker container."
}

variable codebuild_image_pull_credentials_type {
  default     = "CODEBUILD"
  description = "The type of credentials AWS CodeBuild uses to pull images in your build. Available values for this parameter are CODEBUILD or SERVICE_ROLE. When you use a cross-account or private registry image, you must use SERVICE_ROLE credentials. When you use an AWS CodeBuild curated image, you must use CODEBUILD credentials."
}

variable codebuild_source_type {
  default     = "CODECOMMIT"
  description = "The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET, S3 or NO_SOURCE."
}

variable codebuild_source_location {
  default     = ""
  description = "The location of the source code from git or s3."
}

variable codebuild_secondary_source_type {
  default     = "CODECOMMIT"
  description = "The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET, S3 or NO_SOURCE."
}

variable codebuild_secondary_source_identifier {
  default     = ""
  description = "The source identifier. Source data will be put inside a folder named as this parameter inside AWS CodeBuild source directory"
}

variable codebuild_secondary_source_location {
  default     = ""
  description = "The location of the secondary source code from git or s3."
}

variable codepipeline_artifact_bucket_name {
  default     = "jamesg-codepipeline-test"
  description = "Name of S3 bucket used to store build artifacts"
}

variable codepipeline_artifact_expiration {
  default     = "30"
  description = "The number of days before the artifact objects in the S3 bucket are removed"
}

variable codepipeline_name {
  default     = "jamesg-codepipeline-test"
  description = "Name of pipeline"
}

variable codepipeline_source_branch {
  default     = "master"
  description = "Branch of source code for source state of pipeline"
}

variable codepipeline_iam_actions {
  default     = ["*"]
  description = "List of actions that the pipeline is authorised to perform"
}

variable codepipeline_iam_resources {
  default     = ["*"]
  description = "The list of resources that the pipeline can interact with"
}

variable codebuild_environment_variables {
  default     = {}
  type        = map(string)
  description = "A map of key value pairs to pass to the codebuild job as environment variables"
}

variable codepipeline_tags {
  description = "A mapping of tags to assign to the codepipeline instance resource"
  type        = map(string)
  default     = {}
}

variable "secondary_sources" {
  description = "Enables secondary sources if set to true"
  default     = false
}

variable "codepipeline_stages" {
  description = "Set of variables and their types for the CodePipeline stages"
  type = list(object({
    name            = string
    category        = string
    owner           = string
    provider        = string
    version         = string
    input_artifacts = list(string)
  }))
  default = [{
    name            = "Dev"
    category        = "Build"
    owner           = "AWS"
    provider        = "CodeBuild"
    version         = "1"
    input_artifacts = ["Source"]
    },
    {
      name            = "Preprod"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["Source"]
  }]
}

variable codebuild_stages {
  default = {
    dev     = "buildspec.yml"
    preprod = "buildspec-preprod.yml"
  }
}

