resource "aws_codecommit_repository" "codecommit_repository" {
  repository_name = var.codecommit_name
  default_branch  = var.codecommit_default_branch
  description     = var.codecommit_description
}
