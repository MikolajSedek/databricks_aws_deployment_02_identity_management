# 001.users

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
| [databricks_user.this](https://registry.terraform.io/providers/databricks/databricks/1.135.0/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_users"></a> [users](#input\_users) | Map of users to create. The map key is a stable logical identifier used for references from other modules; user\_name is the user's email address. | <pre>map(object({<br/>    user_name    = string<br/>    display_name = optional(string)<br/>    active       = optional(bool, true)<br/>    external_id  = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ids"></a> [ids](#output\_ids) | Map of user key => Databricks user ID. |
<!-- END_TF_DOCS -->
