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

variable "target_port" {
  description = "Target destination port"
  type        = number
  default     = 443
}

variable "identifier" {
  description = "The identifier for the project set."
  type        = string
}

variable "environment" {
  description = "The name of the environment."
  type        = string
}

variable "route_type" {
  description = "The type of route to create."
  type        = string
  default     = "default"

  validation {
    condition     = contains(["default", "custom"], var.route_type)
    error_message = "The route_type must be either 'default' or 'custom'."
  }
}
