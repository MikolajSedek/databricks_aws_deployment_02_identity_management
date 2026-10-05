# 004.group_memberships

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
| [databricks_group_member.this](https://registry.terraform.io/providers/databricks/databricks/1.135.0/docs/resources/group_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_ids"></a> [group\_ids](#input\_group\_ids) | Map of group key => group ID (output of the groups module). | `map(string)` | n/a | yes |
| <a name="input_group_memberships"></a> [group\_memberships](#input\_group\_memberships) | Map of group key => members, expressed as lists of user, service principal and nested group keys. | <pre>map(object({<br/>    users              = optional(list(string), [])<br/>    service_principals = optional(list(string), [])<br/>    groups             = optional(list(string), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_service_principal_ids"></a> [service\_principal\_ids](#input\_service\_principal\_ids) | Map of service principal key => ID (output of the service principals module). | `map(string)` | `{}` | no |
| <a name="input_user_ids"></a> [user\_ids](#input\_user\_ids) | Map of user key => user ID (output of the users module). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_membership_ids"></a> [membership\_ids](#output\_membership\_ids) | Map of membership key (<group>/<type>/<member>) => group member resource ID. |
<!-- END_TF_DOCS -->
