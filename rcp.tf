data "aws_organizations_organization" "current" {}

data "aws_iam_policy_document" "security_rcp" {
  statement {
    sid    = "EnforceConfusedDeputyProtection"
    effect = "Deny"

    actions = [
      "s3:*",
      "sqs:*",
      "kms:*",
      "secretsmanager:*",
      "sts:*",
    ]

    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEqualsIfExists"
      variable = "aws:SourceOrgID"
      values   = [data.aws_organizations_organization.current.id]
    }

    # condition {
    #   test     = "StringNotEqualsIfExists"
    #   variable = "aws:SourceAccount"
    #   values   = []
    # }

    condition {
      test     = "Bool"
      variable = "aws:PrincipalIsAWSService"
      values   = [true]
    }

    condition {
      test     = "Null"
      variable = "aws:SourceArn"
      values   = [false]
    }
  }

  statement {
    sid    = "EnforceSecureTransport"
    effect = "Deny"

    actions = [
      "sts:*",
      "s3:*",
      "sqs:*",
      "secretsmanager:*",
      "kms:*",
    ]

    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "BoolIfExists"
      variable = "aws:SecureTransport"
      values   = [false]
    }
  }

  statement {
    sid    = "EnforceS3TlsVersion"
    effect = "Deny"

    actions = [
      "s3:*"
    ]

    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "s3:TlsVersion"
      values   = ["1.2"]
    }
  }
}

resource "aws_organizations_policy" "security_rcp" {
  name    = "${var.name}-security"
  content = data.aws_iam_policy_document.security_rcp.json
  type    = "RESOURCE_CONTROL_POLICY"
}

resource "aws_organizations_policy_attachment" "security_rcp" {
  policy_id = aws_organizations_policy.security_rcp.id
  target_id = var.target_ou_id
}
