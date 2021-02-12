terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "3.11.0"
		}
	}
}

data aws_route53_zone "parent_zone" {
	name = var.parent_domain
}


data "aws_lb" "public_alb" {
	name = var.public_alb_name
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
		name                   = data.aws_lb.public_alb.dns_name
		zone_id                = data.aws_lb.public_alb.zone_id
		evaluate_target_health = true
	}
}
