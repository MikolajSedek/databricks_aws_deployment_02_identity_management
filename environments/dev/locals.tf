/*
  Local Values and Identity Model Configuration - Dev Environment
  Documentation:
    - https://developer.hashicorp.com/terraform/language/values/locals
    - https://docs.databricks.com/aws/en/admin/users-groups/

  Defines local variables, naming conventions, and the Databricks account identity catalogue:
    - Project, environment, and backend bucket naming parameters.
    - User identities parameterized from input variables.
    - Group declarations with administrative privilege toggles.
    - Service principals for automation, ETL, and data science workloads.
    - Group memberships mapping users and service principals to groups.
    - Authoritative role mappings granting groups manager/user access on service principals.
*/

locals {
  /* basic setup */

  owner           = "msedek" // NOTE: change it to your name
  env             = var.environment
  project_name    = "${local.owner}-dbx-dep"
  subproject_name = "id-provider-"

  backend_bucket_name = "${local.project_name}-${local.subproject_name}-s3-backend"

  /* identity management - keys of the maps below are stable identifiers referenced across sections */

  users = {
    user1 = {
      user_name    = var.user1_email
      display_name = "User1Admin"
    }
    user2 = {
      user_name    = var.user2_email
      display_name = "User2"
    }
  }

  groups = {
    platform_admins = {
      display_name  = "dbx-platform-admins"
      account_admin = true
    }
    data_engineers  = { display_name = "dbx-data-engineers" }
    data_scientists = { display_name = "dbx-data-scientists" }
    data_analysts   = { display_name = "dbx-data-analysts" }
  }

  service_principals = {
    terraform_automation = { display_name = "sp-terraform-automation-${local.env}" }
    etl_pipelines        = { display_name = "sp-etl-pipelines-${local.env}" }
    data_science         = { display_name = "sp-data-science-${local.env}" }
  }

  group_memberships = {
    platform_admins = { users = ["user1"] }
    data_engineers  = { users = ["user1", "user2"], service_principals = ["etl_pipelines"] }
    data_scientists = { users = ["user1"] }
    data_analysts   = { users = ["user2"] }
  }

  // service principal key => groups that manage / use it
  service_principal_group_roles = {
    terraform_automation = {
      managers = ["platform_admins"]
      users    = ["data_engineers"]
    }
    etl_pipelines = {
      managers = ["platform_admins"]
      users    = ["data_engineers"]
    }
    data_science = {
      managers = ["platform_admins"]
      users    = ["data_scientists"]
    }
  }
}
