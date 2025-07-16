
# <application_license_badge>
<!--- [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE) --->

# BC Gov Terraform Template

This repo provides a starting point for users who want to create valid Terraform modules stored in GitHub.  

## Third-Party Products/Libraries used and the licenses they are covered by
<!--- product/library and path to the LICENSE --->
<!--- Example: <library_name> - [![GitHub](<shield_icon_link>)](<path_to_library_LICENSE>) --->

## Project Status
- [x] Development
- [ ] Production/Maintenance

# Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account_route"></a> [account\_route](#module\_account\_route) | ./modules/account-routing | n/a |
| <a name="module_lz_info"></a> [lz\_info](#module\_lz\_info) | github.com/BCDevOps/terraform-aws-sea-organization-info//. | v1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_org_admin_role_name"></a> [org\_admin\_role\_name](#input\_org\_admin\_role\_name) | The role used for executing automation commands in the environment. | `string` | `"OrganizationAccountAccessRole"` | no |
| <a name="input_parent_domain"></a> [parent\_domain](#input\_parent\_domain) | The parent domain (zone) for the resources created by the module. | `string` | n/a | yes |
| <a name="input_perimeter_account_name"></a> [perimeter\_account\_name](#input\_perimeter\_account\_name) | Perimeter Account Name | `string` | `"Perimeter"` | no |
| <a name="input_perimeter_alb"></a> [perimeter\_alb](#input\_perimeter\_alb) | Public ALB names | <pre>object({<br>    dev_test = string<br>    prod     = string<br>  })</pre> | n/a | yes |
| <a name="input_project_config"></a> [project\_config](#input\_project\_config) | project.json config. | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Getting Started
<!--- setup env vars, secrets, instructions... --->

## Getting Help or Reporting an Issue
<!--- Example below, modify accordingly --->
To report bugs/issues/feature requests, please file an [issue](../../issues).


## How to Contribute
<!--- Example below, modify accordingly --->
If you would like to contribute, please see our [CONTRIBUTING](./CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](./CODE_OF_CONDUCT.md). 
By participating in this project you agree to abide by its terms.


## License
<!--- Example below, modify accordingly --->
    Copyright 2018 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
