<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/acm_certificate_validation) | resource |
| [aws_lb_listener_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/lb_listener_certificate) | resource |
| [aws_route53_record.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/route53_record) | resource |
| [aws_route53_record.subdomain_ns_records](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/route53_record) | resource |
| [aws_route53_record.subdomain_wildcard_record](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/route53_record) | resource |
| [aws_route53_zone.subdomain_zone](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/route53_zone) | resource |
| [aws_lb.public_lb](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/data-sources/lb) | data source |
| [aws_lb_listener.public_lb](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/data-sources/lb_listener) | data source |
| [aws_route53_zone.parent_zone](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parent_domain"></a> [parent\_domain](#input\_parent\_domain) | The parent domain (zone) for the resources created by the module. | `string` | n/a | yes |
| <a name="input_public_lb_name"></a> [public\_lb\_name](#input\_public\_lb\_name) | The hostname of the public load balancer in that will be the entry point of inbound traffic for an account's services. | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The subdomain (beneath the parent\_domain) for which resources will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Metadata tags to apply to resources in this module to help identify/track/report on them. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->