provider "aws" {
  region = "ca-central-1"
  alias  = "master"
}

provider "aws" {
  region = "ca-central-1"
  alias  = "perimeter"

  assume_role {
    role_arn     = "arn:aws:iam::${local.perimeter_account.id}:role/${var.org_admin_role_name}"
    session_name = "slz-terraform-automation"
  }
}

module "lz_info" {
  source = "github.com/BCDevOps/terraform-aws-sea-organization-info"
  providers = {
    aws = aws.master
  }
}

locals {
  core_accounts     = { for account in module.lz_info.core_accounts : account.name => account }
  perimeter_account = local.core_accounts[var.perimeter_account_name]

  project_config = jsondecode(var.project_config)

  public_lb_map = {
    dev     = var.perimeter_alb["dev_test"]
    test    = var.perimeter_alb["dev_test"]
    sandbox = var.perimeter_alb["dev_test"]
    prod    = var.perimeter_alb["prod"]
  }
}

module "account_route" {
  for_each = { for account in local.project_config.accounts : "${local.project_config.identifier}-${account.environment}" => {
    environmenmt   = account.environment
    public_lb_name = local.public_lb_map[account.environment]
    }
    if account.environment != "sandbox"
  }

  source = "./modules/account-routing"
  providers = {
    aws = aws.perimeter
  }

  parent_domain  = var.parent_domain
  public_lb_name = each.value.public_lb_name
  subdomain      = "${local.project_config.identifier}-${each.value.environmenmt}"
}
