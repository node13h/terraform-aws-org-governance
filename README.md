# terraform-org-governance

Terraform module for making small/personal AWS organizations slightly safer.

It sets up

- SCP to only allow specific regions,
- SCP to prevent member accounts from creating new SSO instances,
- SCP to only allow specific EC2 instance types,
- SCP to only allow specific AWS services,
- RCP to protect against the confused deputy problem,
- RCPs to only allow secure transport,
- AWS Budget for monthly spend cap alarms.

Apply this module in the organization management account.

The defaults are quite opinionated, review and override if necessary.

To test changes deploy a copy with the `target_ou_id` variable set to a sandbox OU.
For production set `target_ou_id` to organization Root id.

## Developing

See [DEVELOPING.md](DEVELOPING.md) for local development setup instructions.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.monthly_cap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |
| [aws_organizations_policy.constraints_scp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy.security_rcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy_attachment.constraints_scp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.security_rcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_iam_policy_document.constraints_scp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.security_rcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_actions"></a> [allowed\_actions](#input\_allowed\_actions) | Allowed IAM actions | `list(string)` | <pre>[<br/>  "autoscaling:*",<br/>  "account:*",<br/>  "backup:*",<br/>  "cloudformation:*",<br/>  "cloudwatch:*",<br/>  "cloudtrail:*",<br/>  "cognito-identity:*",<br/>  "cognito-sync:*",<br/>  "cognito-idp:*",<br/>  "cloudfront:*",<br/>  "ce:*",<br/>  "ec2:*",<br/>  "elasticloadbalancing:*",<br/>  "glacier:*",<br/>  "iam:*",<br/>  "kms:*",<br/>  "logs:*",<br/>  "organizations:Describe*",<br/>  "organizations:List*",<br/>  "pricing:*",<br/>  "route53:*",<br/>  "resource-explorer-2:*",<br/>  "s3:*",<br/>  "support:*",<br/>  "servicequotas:*",<br/>  "ssm:*",<br/>  "ssmmessages:*",<br/>  "ses:*",<br/>  "servicecatalog:*",<br/>  "securityhub:*",<br/>  "secretsmanager:*"<br/>]</pre> | no |
| <a name="input_allowed_ec2_instance_types"></a> [allowed\_ec2\_instance\_types](#input\_allowed\_ec2\_instance\_types) | List of allowed EC2 instance types | `list(string)` | <pre>[<br/>  "t4g.nano",<br/>  "t3a.nano",<br/>  "t3.nano"<br/>]</pre> | no |
| <a name="input_allowed_regions"></a> [allowed\_regions](#input\_allowed\_regions) | n/a | `list(string)` | n/a | yes |
| <a name="input_budget_alert_emails"></a> [budget\_alert\_emails](#input\_budget\_alert\_emails) | List of email addresses to send budget alerts to | `list(string)` | n/a | yes |
| <a name="input_monthly_cap_budget_usd"></a> [monthly\_cap\_budget\_usd](#input\_monthly\_cap\_budget\_usd) | Monthly budget cap in USD | `number` | `10` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix for resources | `string` | n/a | yes |
| <a name="input_target_ou_id"></a> [target\_ou\_id](#input\_target\_ou\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
