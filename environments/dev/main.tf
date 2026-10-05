/*
  Databricks Account Identity Management Orchestration - Dev Environment
  Documentation:
    - https://docs.databricks.com/aws/en/admin/users-groups/
    - https://registry.terraform.io/providers/databricks/databricks/latest/docs

  Orchestrates account-level identity management and remote state storage:
    - Provisions customer-managed KMS key and S3 bucket for secure backend state storage.
    - Instantiates account-level Databricks users, groups, and service principals.
    - Manages group memberships (users, service principals, and nested groups).
    - Enforces service principal access control rule sets with sequenced dependencies.
*/

/* setup s3 backend for the project */

module "kms_key" {
  source = "../../modules/02.security/001.kms_key"

  environment         = local.env
  kms_key_alias       = "dbx_id_management_backend_kms_key"
  kms_key_description = "KMS key used for backend storage security"
}

module "backend_bucket" {
  source = "../../modules/03.storage/001.env_backend_bucket"

  bucket_name = local.backend_bucket_name
  environment = local.env
  kms_key_arn = module.kms_key.kms_arn
}

/* setup identity management for the project */

module "users" {
  source = "../../modules/04.identity_management/001.users"

  providers = { databricks = databricks.mws }

  users = local.users
}

module "groups" {
  source = "../../modules/04.identity_management/002.groups"

  providers = { databricks = databricks.mws }

  groups = local.groups
}

module "service_principals" {
  source = "../../modules/04.identity_management/003.service_principals"

  providers = { databricks = databricks.mws }

  service_principals = local.service_principals
}

module "group_memberships" {
  source = "../../modules/04.identity_management/004.group_memberships"

  providers = { databricks = databricks.mws }

  group_ids             = module.groups.ids
  user_ids              = module.users.ids
  service_principal_ids = module.service_principals.ids
  group_memberships     = local.group_memberships
}

module "service_principal_group_management" {
  source = "../../modules/04.identity_management/005.service_principal_group_management"

  providers = { databricks = databricks.mws }

  account_id                        = var.databricks_account_id
  service_principal_application_ids = module.service_principals.application_ids
  group_acl_principal_ids           = module.groups.acl_principal_ids
  service_principal_group_roles     = local.service_principal_group_roles

  depends_on = [
    module.group_memberships
  ]
}
