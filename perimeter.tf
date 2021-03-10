locals {
  routes = {
    for account in local.project_config.accounts : account.environment => {
      for alb in lookup(account, "alb", []) : alb.name => lookup(alb, "subdomains", ["*"])
    }
  }
  tg_attachments = flatten([
    for i in data.aws_instance.firewalls : [
      for tg in aws_lb_target_group.perimeter : {
        aws_instance_id = i.id
        target_group    = tg
      }
    ]
  ])
}

data "aws_vpc" "perimeter" {
  provider = aws.perimeter

  filter {
    name   = "tag:Name"
    values = ["Perimeter_vpc"]
  }
}

data "aws_lb" "perimeter" {
  for_each = var.perimeter_alb
  provider = aws.perimeter
  name     = each.value
}

data "aws_lb_listener" "perimeter" {
  for_each          = data.aws_lb.perimeter
  provider          = aws.perimeter
  load_balancer_arn = each.value.arn
  port              = 443
}

data "aws_instance" "firewalls" {
  for_each = var.fortigate
  provider = aws.perimeter

  filter {
    name   = "tag:Name"
    values = [each.value.name]
  }
}

resource "aws_lb_target_group" "perimeter" {
  for_each = module.firewall_a.vip

  provider = aws.perimeter
  name     = each.value.name
  port     = each.value.extport
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.perimeter.id
}

resource "aws_lb_target_group_attachment" "perimeter" {
  for_each = {
    for tga in local.tg_attachments : "${tga.aws_instance_id}-${tga.target_group.name}" => tga
  }

  provider         = aws.perimeter
  target_group_arn = each.value.target_group.arn
  target_id        = each.value.aws_instance_id
  port             = each.value.target_group.port
}

resource "aws_lb_listener_rule" "perimeter" {
  for_each = {
    for k, v in aws_lb_target_group.perimeter : k => {
      alb          = split("-", k)[0] == "prod" ? "prod" : "dev_test"
      target_group = v
      hosts = [
        for subdomain in lookup(lookup(local.routes, split("-", k)[0], []), split("-", k)[1], []) :
        "${subdomain}.${local.project_config.identifier}-${split("-", k)[0]}.${var.parent_domain}"
      ]
    }
  }

  provider     = aws.perimeter
  listener_arn = data.aws_lb_listener.perimeter[each.value.alb].arn

  action {
    type             = "forward"
    target_group_arn = each.value.target_group.arn
  }

  condition {
    host_header {
      values = each.value.hosts
    }
  }
}
