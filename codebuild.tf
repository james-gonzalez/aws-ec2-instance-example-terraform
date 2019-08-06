resource "aws_codebuild_project" "codebuild_project_with_secondary_source" {
  name         = var.codebuild_project_name
  service_role = aws_iam_role.pipeline_role.arn
  environment {
    compute_type                = var.codebuild_compute_type
    image                       = "${var.codebuild_image_base}:${var.codebuild_image_tag}"
    type                        = var.codebuild_image_type
    privileged_mode             = var.codebuild_privileged_mode
    image_pull_credentials_type = var.codebuild_image_pull_credentials_type

    dynamic "environment_variable" {
      for_each = var.codebuild_environment_variables

      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }
  source {
    type     = var.codebuild_source_type
    location = aws_codecommit_repository.codecommit_repository.clone_url_http
  }
  dynamic "secondary_sources" {
    for_each = [for s in local.secondary_sources : {
      type              = s.type
      source_identifier = s.source_identifier
      location          = s.location
    }]
    content {
      type              = secondary_sources.value.type
      source_identifier = secondary_sources.value.source_identifier
      location          = secondary_sources.value.location
    }
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  tags = {
    Name           = var.codebuild_project_name
    Application    = "N/A"
    Environment    = "Production"
    InfraManagedBy = "CloudPlatform"
    AppManagedBy   = "N/A"
  }
}