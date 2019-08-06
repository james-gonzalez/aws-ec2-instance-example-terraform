resource "aws_iam_role" "default" {
  name               = "test_role"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

resource "aws_iam_instance_profile" "default" {
  name = "default_profile"
  role = aws_iam_role.default.name
}

resource "aws_iam_role_policy" "default" {
  name   = "default-policy"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "trust" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "s3.amazonaws.com"
      ]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "default" {
  statement {
    effect = "Allow"
    actions = [
      "s3:List*",
      "s3:Put*",
      "s3:Get*"
    ]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}"]
  }
}

## CODE COMMIT / CODE PIPELINE
data "aws_iam_policy_document" "pipeline_trust_policy_document" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com",
        "codepipeline.amazonaws.com",

      ]

    }
    actions = ["sts:AssumeRole"]

  }

}

resource "aws_iam_role" "pipeline_role" {
  name               = "pipeline-${var.codebuild_project_name}"
  assume_role_policy = data.aws_iam_policy_document.pipeline_trust_policy_document.json

}

data "aws_iam_policy_document" "pipeline_policy_document" {
  statement {
    effect    = "Allow"
    actions   = var.codepipeline_iam_actions
    resources = var.codepipeline_iam_resources

  }
  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.codepipeline_artifacts.arn,
      "${aws_s3_bucket.codepipeline_artifacts.arn}/*",

    ]

  }

}

resource "aws_iam_role_policy" "pipeline_policy_attachment" {
  name   = "${aws_iam_role.pipeline_role.name}-policy"
  role   = aws_iam_role.pipeline_role.name
  policy = data.aws_iam_policy_document.pipeline_policy_document.json

}

