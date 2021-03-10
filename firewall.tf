locals {
  project_config = jsondecode(var.project_config)
  project_albs = {
    for account in local.project_config.accounts : account.environment => {
      for alb in lookup(account, "alb", {}) : alb.name => {
        extport = alb.firewall_port
      }
    }
  }
  temp_config = flatten([
    for env_key, env in var.alb_dns : [
      for alb_key, alb in env : {
        name  = "${env_key}-${alb_key}"
        value = merge(alb, local.project_albs[env_key][alb_key])
      }
    ]
  ])
  alb_config = { for alb in local.temp_config : alb.name => alb.value }
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

  alb_config = local.alb_config
  identifier = local.project_config.identifier
  extip      = var.fortigate["a"].extip

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

  alb_config = local.alb_config
  identifier = local.project_config.identifier
  extip      = var.fortigate["b"].extip

  providers = {
    fortios = fortios.b
  }
}
