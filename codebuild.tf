resource "aws_codebuild_project" "stage" {
  for_each     = var.codebuild_stages
  name         = "${var.codebuild_project_name}-${each.key}"
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
    type      = var.codebuild_source_type
    location  = aws_codecommit_repository.codecommit_repository.clone_url_http
    buildspec = each.value
  }
  dynamic "secondary_sources" {
    for_each = var.secondary_sources == false ? [] : [1]
    content {
      type              = var.codebuild_secondary_source_type
      source_identifier = var.codebuild_secondary_source_identifier
      location          = var.codebuild_secondary_source_location
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
