module "org_governance" {
  source = "../"

  name = "test"

  target_ou_id = "r-abcd"

  allowed_regions = [
    "eu-central-1"
  ]

  budget_alert_emails = [
    "alerts@example.com"
  ]
}
