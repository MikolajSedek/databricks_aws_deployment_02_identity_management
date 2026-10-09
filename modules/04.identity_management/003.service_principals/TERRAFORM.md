# 003.service_principals

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | 1.135.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | 1.135.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [databricks_service_principal.this](https://registry.terraform.io/providers/databricks/databricks/1.135.0/docs/resources/service_principal) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_principals"></a> [service\_principals](#input\_service\_principals) | Map of service principals to create. The map key is a stable logical identifier used for references from other modules. | <pre>map(object({<br/>    display_name = string<br/>    active       = optional(bool, true)<br/>    external_id  = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_ids"></a> [application\_ids](#output\_application\_ids) | Map of service principal key => application (client) ID. |
| <a name="output_ids"></a> [ids](#output\_ids) | Map of service principal key => Databricks service principal ID. |
<!-- END_TF_DOCS -->
