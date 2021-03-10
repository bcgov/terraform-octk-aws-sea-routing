variable "alb_fqdn" {
  description = "Map alb fqdns to environments"
  type = map(object({
    dns_name = string
  }))
}

variable "extip" {
  description = "Private IP adddress of the firewall used for the virtual IP"
  type        = string
}

variable "extport" {
  description = "Port used for the virtual IP"
  type        = number
}

variable "identifier" {
  description = "Project identifier"
  type        = string
}
