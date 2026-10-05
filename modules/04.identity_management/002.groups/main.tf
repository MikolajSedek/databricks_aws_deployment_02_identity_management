/*
  Databricks Account-Level Groups
  Documentation: https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group

  Creates one databricks_group per entry of var.groups (for_each over the map key).
*/

resource "databricks_group" "this" {
  for_each = var.groups // key = logical group identifier referenced by memberships and rule sets

  display_name = each.value.display_name
  external_id  = each.value.external_id
  force        = each.value.force
}

// grants the Account admin system role to the groups selected in locals.account_admin_groups
resource "databricks_group_role" "account_admin" {
  for_each = local.account_admin_groups

  group_id = each.value
  role     = "account_admin"
}
