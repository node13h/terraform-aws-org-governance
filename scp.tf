data "aws_iam_policy_document" "constraints_scp" {
  statement {
    sid    = "DenyAllOutsideRequestedRegions"
    effect = "Deny"

    # Allow global services.
    not_actions = [
      "cloudfront:*",
      "iam:*",
      "organizations:*",
      "route53:*",
      "route53domains:*",
      "support:*",
      "ce:*",
      "cloudtrail:*",
      "logs:*",
    ]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"
      values   = var.allowed_regions
    }
  }

  # Prevent member accounts from creating their own SSO instances.
  statement {
    sid       = "DenyMemberAccountInstances"
    effect    = "Deny"
    actions   = ["sso:CreateInstance"]
    resources = ["*"]
  }

  statement {
    sid       = "DenyUnsupportedInstanceTypes"
    effect    = "Deny"
    actions   = ["ec2:RunInstances"]
    resources = ["arn:aws:ec2:*:*:instance/*"]

    condition {
      test     = "StringNotEquals"
      variable = "ec2:InstanceType"
      values   = var.allowed_ec2_instance_types
    }
  }

  statement {
    sid         = "DenyEverythingExceptAllowedServices"
    effect      = "Deny"
    not_actions = var.allowed_actions
    resources   = ["*"]
  }
}

resource "aws_organizations_policy" "constraints_scp" {
  name    = "${var.name}-constraints"
  content = data.aws_iam_policy_document.constraints_scp.json
  type    = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy_attachment" "constraints_scp" {
  policy_id = aws_organizations_policy.constraints_scp.id
  target_id = var.target_ou_id
}
