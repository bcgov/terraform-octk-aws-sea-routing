terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "3.11.0"
		}
	}
}

provider "aws" {
	region = "ca-central-1"
	alias = "master"
}

provider "aws" {
	region = "ca-central-1"
	alias = "perimeter"

	assume_role {
		role_arn = "arn:aws:iam::${local.perimeter_account.id}:role/${var.org_admin_role_name}"
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
	core_accounts = { for account in module.lz_info.core_accounts : account.name =>  account }
	perimeter_account = local.core_accounts[var.perimeter_account_name]
}

module "account_route" {

//	for_each = var.subdomains
	for_each = { for route in var.routes : route.subdomain => route }
	source = "./modules/account-routing"
	providers = {
		aws = aws.perimeter
	}

	parent_domain = var.parent_domain
	public_alb_name = each.value.external_alb_hostname
	subdomain = each.value.subdomain
	tags = each.value.tags
}
