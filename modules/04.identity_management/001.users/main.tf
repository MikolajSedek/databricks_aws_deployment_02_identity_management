/*
  Databricks Account-Level Users
  Documentation: https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/user

  Creates one databricks_user per entry of var.users (for_each over the map key).
*/

resource "databricks_user" "this" {
  for_each = var.users // key = logical user identifier, stable across email changes

  user_name    = each.value.user_name
  display_name = each.value.display_name
  active       = each.value.active
  external_id  = each.value.external_id
}
