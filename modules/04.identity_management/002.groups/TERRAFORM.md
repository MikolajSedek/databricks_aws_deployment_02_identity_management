# 002.groups

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
| [databricks_group.this](https://registry.terraform.io/providers/databricks/databricks/1.135.0/docs/resources/group) | resource |
| [databricks_group_role.account_admin](https://registry.terraform.io/providers/databricks/databricks/1.135.0/docs/resources/group_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_groups"></a> [groups](#input\_groups) | Map of groups to create. The map key is a stable logical identifier used for references from other modules. | <pre>map(object({<br/>    display_name  = string<br/>    external_id   = optional(string)<br/>    force         = optional(bool, false)<br/>    account_admin = optional(bool, false)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acl_principal_ids"></a> [acl\_principal\_ids](#output\_acl\_principal\_ids) | Map of group key => ACL principal ID (groups/<display\_name>) used in access control rule sets. |
| <a name="output_ids"></a> [ids](#output\_ids) | Map of group key => Databricks group ID. |
<!-- END_TF_DOCS -->
