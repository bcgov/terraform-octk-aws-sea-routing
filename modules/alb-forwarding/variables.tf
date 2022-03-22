variable "public_lb_name" {
  description = "Public ALB name"
  type        = string
}

variable "subdomain" {
  description = "subdomain"
  type        = string
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
