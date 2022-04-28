data "aws_route53_zone" "parent_zone" {
  name = var.parent_domain
}

data "aws_lb" "public_lb" {
  name = var.public_lb_name
}

resource "aws_route53_zone" "subdomain_zone" {
  name = "${var.subdomain}.${var.parent_domain}"

  tags = var.tags
}

resource "aws_route53_record" "subdomain_ns_records" {
  zone_id = data.aws_route53_zone.parent_zone.zone_id
  name    = "${var.subdomain}.${var.parent_domain}"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.subdomain_zone.name_servers
}

resource "aws_route53_record" "subdomain_wildcard_record" {
  zone_id = aws_route53_zone.subdomain_zone.zone_id
  name    = "*.${var.subdomain}.${var.parent_domain}"
  type    = "A"

  alias {
    name                   = data.aws_lb.public_lb.dns_name
    zone_id                = data.aws_lb.public_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "*.${var.subdomain}.${var.parent_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.subdomain_zone.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

data "aws_lb_listener" "public_alb" {
  load_balancer_arn = data.aws_lb.public_alb.arn
  port              = 443
}

resource "aws_lb_listener_certificate" "cert" {
  listener_arn    = data.aws_lb_listener.public_alb.arn
  certificate_arn = aws_acm_certificate_validation.cert_validation.certificate_arn
}
