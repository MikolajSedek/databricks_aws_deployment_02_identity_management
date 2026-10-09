# dev

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.66.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | 1.135.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend_bucket"></a> [backend\_bucket](#module\_backend\_bucket) | ../../modules/03.storage/001.env_backend_bucket | n/a |
| <a name="module_group_memberships"></a> [group\_memberships](#module\_group\_memberships) | ../../modules/04.identity_management/004.group_memberships | n/a |
| <a name="module_groups"></a> [groups](#module\_groups) | ../../modules/04.identity_management/002.groups | n/a |
| <a name="module_kms_key"></a> [kms\_key](#module\_kms\_key) | ../../modules/02.security/001.kms_key | n/a |
| <a name="module_service_principal_group_management"></a> [service\_principal\_group\_management](#module\_service\_principal\_group\_management) | ../../modules/04.identity_management/005.service_principal_group_management | n/a |
| <a name="module_service_principals"></a> [service\_principals](#module\_service\_principals) | ../../modules/04.identity_management/003.service_principals | n/a |
| <a name="module_users"></a> [users](#module\_users) | ../../modules/04.identity_management/001.users | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The allowed AWS Account ID to prevent accidental deployment to the wrong account. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where resources will be deployed. | `string` | `"eu-central-1"` | no |
| <a name="input_databricks_account_id"></a> [databricks\_account\_id](#input\_databricks\_account\_id) | The Databricks account ID (UUID) used by the account-level provider. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment name (e.g. dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS CLI user profile | `string` | `"default"` | no |
| <a name="input_service_principal_id"></a> [service\_principal\_id](#input\_service\_principal\_id) | The service principal ID for the Databricks workspace / account | `string` | n/a | yes |
| <a name="input_service_principal_secret"></a> [service\_principal\_secret](#input\_service\_principal\_secret) | The service principal secret for the Databricks workspace / account | `string` | n/a | yes |
| <a name="input_user1_email"></a> [user1\_email](#input\_user1\_email) | Email address of the first user to be created in Databricks. | `string` | n/a | yes |
| <a name="input_user2_email"></a> [user2\_email](#input\_user2\_email) | Email address of the second user to be created in Databricks. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
