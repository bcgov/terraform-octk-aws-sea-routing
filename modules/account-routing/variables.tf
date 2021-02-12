variable "parent_domain" {
	type = string
	description = "The parent domain (zone) for the resources created by the module."
}

variable "public_alb_name" {
	type = string
	description = "The hostname of the public load balancer in that will be the entry point of inbound traffic for an account's services."
}

variable "subdomain" {
	type = string
	description = "The subdomain (beneath the parent_domain) for which resources will be created."
}

variable "tags" {
	type = map(string)
	description = "Metadata tags to apply to resources in this module to help identify/track/report on them."
}

