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

variable "routes" {
  type = set(object({
    external_alb_hostname = string
    subdomain             = string
    tags                  = map(string)
  }))
}

variable "project_config" {
  description = "project.json config."
}

variable "alb_dns" {
  description = "alb data"
  type = map(map(object({
    dns_name = string
  })))
}

variable "fortigate" {
  type = object({
    a = object({
      name  = string
      extip = string
      host  = string
      token = string
      vdom  = string
    })
    b = object({
      name  = string
      extip = string
      host  = string
      token = string
      vdom  = string
    })
  })
}

variable "start_port" {
  description = "Port value to start allocating from"
  type        = number
}

variable "perimeter_alb" {
  description = "Public ALB names"
  type = object({
    dev_test = string
    prod     = string
  })
}

