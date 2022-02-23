variable "perimeter_account_name" {
  description = "Perimeter Account Name"
  default     = "Perimeter"
}

variable "org_admin_role_name" {
  default     = "OrganizationAccountAccessRole"
  description = "The role used for executing automation commands in the environment."
  type        = string
}

variable "parent_domain" {
  type        = string
  description = "The parent domain (zone) for the resources created by the module."
}

variable "project_config" {
  description = "project.json config."
}

variable "perimeter_alb" {
  description = "Public ALB names"
  type = object({
    dev_test = string
    prod     = string
  })
}
