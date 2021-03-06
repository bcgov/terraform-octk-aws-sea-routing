terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = ">= 1.10.4"
    }
  }
}

resource "fortios_firewall_address" "this" {
  for_each = var.alb_fqdn

  name                 = "${var.identifier}-${each.key}-alb"
  associated_interface = "tgw-vpn1"
  type                 = "fqdn"
  fqdn                 = each.value.dns_name

}

resource "fortios_firewall_vip" "this" {
  for_each = fortios_firewall_address.this

  name        = "${each.value.name}-vip"
  type        = "fqdn"
  extintf     = "port1"
  extip       = var.extip
  extport     = var.extport + index(keys(fortios_firewall_address.this), each.key)
  portforward = "enable"
  mapped_addr = each.value.name
  mappedport  = 443
}

resource "fortios_firewall_policy" "this" {

  name             = var.identifier
  action           = "accept"
  av_profile       = "FG-Traffic-Baseline-AV"
  inspection_mode  = "flow"
  ippool           = "enable"
  ips_sensor       = "FG-Traffic-Baseline-IPS"
  logtraffic       = "all"
  logtraffic_start = "enable"
  nat              = "enable"
  ssl_ssh_profile  = "FG-Traffic-Baseline-SSL"
  status           = "enable"
  utm_status       = "enable"
  comments         = "Inbound HTTP / HTTPS Traffic to cloud ALBs"

  srcintf {
    name = "port1"
  }

  dstintf {
    name = "tgw-vpn1"
  }

  srcaddr {
    name = "all"
  }

  dynamic "dstaddr" {
    for_each = fortios_firewall_vip.this
    content {
      name = dstaddr.value.name
    }
  }

  poolname {
    name = "cluster-ippool"
  }

  service {
    name = "HTTP"
  }

  service {
    name = "HTTPS"
  }
}
