
provider "fortios" {
  alias    = "a"
  hostname = var.fortigate["a"].host
  token    = var.fortigate["a"].token
  vdom     = var.fortigate["a"].vdom
  insecure = "true"
}

module "firewall_a" {
  source = "./modules/firewall"

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

  providers = {
    fortios = fortios.b
  }
}
