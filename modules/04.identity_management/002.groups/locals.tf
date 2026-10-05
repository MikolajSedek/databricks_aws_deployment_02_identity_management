/*
  Local Values - Databricks Groups Module
  Documentation: https://developer.hashicorp.com/terraform/language/values/locals

  Filters and maps group keys designated for the Account admin system role.
*/

locals {
  // groups with account_admin = true receive the account_admin system role
  account_admin_groups = {
    for key, g in var.groups : key => databricks_group.this[key].id
    if try(g.account_admin, false)
  }
}
