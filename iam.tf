resource "aws_iam_role" "default" {
  name = "test_role"

  assume_role_policy = data.aws_iam_policy_document.default.json

  tags = {
    tag-key = "testing"
  }
}

resource "aws_iam_instance_profile" "default" {
  name = "default_profile"
  role = aws_iam_role.default.name
}


data "aws_iam_policy_document" "default" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
  }

  statement {
    actions = [
      "rds:*"
    ]

    resources = [
      "arn:aws:rds:*:{data.aws_caller_identity.current.account_id}:*:*"
    ]
  }
}
