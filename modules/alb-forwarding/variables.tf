variable "public_lb_name" {
  description = "Public ALB name"
  type        = string
}

variable "subdomain" {
  description = "subdomain"
  type        = string
}

variable "parent_domain" {
  type        = string
  description = "The parent domain (zone) for the resources created by the module."
}

variable "target_dns_name" {
  description = "Target DNS name"
  type        = string
}

variable "identifier" {
  description = "The identifier for the project set."
  type        = string
}

variable "environment" {
  description = "The name of the environment."
  type        = string
}
