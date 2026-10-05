# 005.service_principal_group_management

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
| [databricks_access_control_rule_set.this](https://registry.terraform.io/providers/databricks/databricks/1.135.0/docs/resources/access_control_rule_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Databricks account ID (UUID). | `string` | n/a | yes |
| <a name="input_group_acl_principal_ids"></a> [group\_acl\_principal\_ids](#input\_group\_acl\_principal\_ids) | Map of group key => ACL principal ID (output of the groups module). | `map(string)` | n/a | yes |
| <a name="input_service_principal_application_ids"></a> [service\_principal\_application\_ids](#input\_service\_principal\_application\_ids) | Map of service principal key => application ID (output of the service principals module). | `map(string)` | n/a | yes |
| <a name="input_service_principal_group_roles"></a> [service\_principal\_group\_roles](#input\_service\_principal\_group\_roles) | Map of service principal key => groups granted roles/servicePrincipal.manager (managers) and roles/servicePrincipal.user (users), as lists of group keys. | <pre>map(object({<br/>    managers = optional(list(string), [])<br/>    users    = optional(list(string), [])<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rule_set_ids"></a> [rule\_set\_ids](#output\_rule\_set\_ids) | Map of service principal key => access control rule set ID. |
<!-- END_TF_DOCS -->
