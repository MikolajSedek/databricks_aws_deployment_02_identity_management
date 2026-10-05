/*
  Databricks Group Memberships
  Documentation: https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member

  Assigns users, service principals and nested groups to groups. One databricks_group_member
  is created per (group, member) pair using for_each over the flattened memberships.
*/

resource "databricks_group_member" "this" {
  for_each = local.memberships // key = <group>/<type>/<member>

  group_id  = each.value.group_id
  member_id = each.value.member_id

  // plan-time referential integrity checks; messages list the offending keys
  lifecycle {
    precondition {
      condition     = length(local.unknown_group_keys) == 0
      error_message = "Unknown group keys (missing in group_ids): ${join(", ", local.unknown_group_keys)}."
    }
    precondition {
      condition     = length(local.unknown_user_keys) == 0
      error_message = "Unknown user keys (missing in user_ids): ${join(", ", local.unknown_user_keys)}."
    }
    precondition {
      condition     = length(local.unknown_service_principal_keys) == 0
      error_message = "Unknown service principal keys (missing in service_principal_ids): ${join(", ", local.unknown_service_principal_keys)}."
    }
    precondition {
      condition     = length(local.self_referencing_groups) == 0
      error_message = "A group cannot be a member of itself: ${join(", ", local.self_referencing_groups)}."
    }
  }
}
