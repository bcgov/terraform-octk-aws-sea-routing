variable perimeter_account_name {
	description = "Perimeter Account Name"
	default = "Perimeter"
}

variable "org_admin_role_name" {
	default = "OrganizationAccountAccessRole"
	description = "The role used for executing automation commands in the environment."
	type = string
}

variable "parent_domain" {
	type = string
	description = "The parent domain (zone) for the resources created by the module."
}

variable "routes" {
	type = set(object({
		external_alb_hostname = string
		subdomain = string
		tags = map(string)
	}))
}
