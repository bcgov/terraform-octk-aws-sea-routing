variable "alb_config" {
  description = "Map alb config for each environment"
  type = map(object({
    dns_name = string
    extport  = number
  }))
}

variable "extip" {
  description = "Private IP adddress of the firewall used for the virtual IP"
  type        = string
}

variable "identifier" {
  description = "Project identifier"
  type        = string
}
