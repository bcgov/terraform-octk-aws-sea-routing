locals {
  project_config = jsondecode(var.project_config)
  alb_dns = flatten([
    for env_key, env in jsondecode(var.alb_dns) : [
      for alb_key, alb in env : {
        name  = "${env_key}-${alb_key}"
        value = alb
      }
    ]
  ])
  alb_fqdn = { for alb in local.alb_dns : alb.name => alb.value }
}

provider "fortios" {
  alias    = "a"
  hostname = var.fortigate["a"].host
  token    = var.fortigate["a"].token
  vdom     = var.fortigate["a"].vdom
  insecure = "true"
}

module "firewall_a" {
  source = "./modules/firewall"

  alb_fqdn   = local.alb_fqdn
  identifier = local.project_config.identifier
  extip      = var.fortigate["a"].extip
  extport    = var.start_port

  providers = {
    fortios = fortios.a
  }
}

provider "fortios" {
  alias    = "b"
  hostname = var.fortigate["b"].host
  token    = var.fortigate["b"].token
  vdom     = var.fortigate["b"].vdom
  insecure = "true"
}

module "firewall_b" {
  source = "./modules/firewall"

  alb_fqdn   = local.alb_fqdn
  identifier = local.project_config.identifier
  extip      = var.fortigate["b"].extip
  extport    = var.start_port

  providers = {
    fortios = fortios.b
  }
}
