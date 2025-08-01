variable "name" {
  type        = string
  description = "Name prefix for resources"
}

variable "target_ou_id" {
  type = string
}

variable "allowed_regions" {
  type = list(string)
}

variable "allowed_ec2_instance_types" {
  type = list(string)
  default = [
    "t4g.nano",
    "t3a.nano",
    "t3.nano",
  ]
  description = "List of allowed EC2 instance types"
}

variable "allowed_actions" {
  type = list(string)
  default = [
    "autoscaling:*",
    "account:*",
    "backup:*",
    "cloudformation:*",
    "cloudwatch:*",
    "cloudtrail:*",
    "cognito-identity:*",
    "cognito-sync:*",
    "cognito-idp:*",
    "cloudfront:*",
    "ce:*",
    "ec2:*",
    "elasticloadbalancing:*",
    "glacier:*",
    "iam:*",
    "kms:*",
    "logs:*",
    "organizations:Describe*",
    "organizations:List*",
    "pricing:*",
    "route53:*",
    "resource-explorer-2:*",
    "s3:*",
    "support:*",
    "servicequotas:*",
    "ssm:*",
    "ssmmessages:*",
    "ses:*",
    "servicecatalog:*",
    "securityhub:*",
    "secretsmanager:*",
  ]
  description = "Allowed IAM actions"
}

variable "budget_alert_emails" {
  type        = list(string)
  description = "List of email addresses to send budget alerts to"
}

variable "monthly_cap_budget_usd" {
  type        = number
  default     = 10
  description = "Monthly budget cap in USD"
}
