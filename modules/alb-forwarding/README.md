<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table_item.alb_ip_forwarding](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item) | resource |
| [null_resource.alb_listenter](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_integer.priority](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [aws_dynamodb_table.tableName](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/dynamodb_table) | data source |
| [aws_lb.perimeter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_lb_listener.perimeter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_listener) | data source |
| [aws_vpc.perimeter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment. | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The identifier for the project set. | `string` | n/a | yes |
| <a name="input_parent_domain"></a> [parent\_domain](#input\_parent\_domain) | The parent domain (zone) for the resources created by the module. | `string` | n/a | yes |
| <a name="input_public_lb_name"></a> [public\_lb\_name](#input\_public\_lb\_name) | Public ALB name | `string` | n/a | yes |
| <a name="input_route_type"></a> [route\_type](#input\_route\_type) | The type of route to create. | `string` | `"default"` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | subdomain | `string` | n/a | yes |
| <a name="input_target_dns_name"></a> [target\_dns\_name](#input\_target\_dns\_name) | Target DNS name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->